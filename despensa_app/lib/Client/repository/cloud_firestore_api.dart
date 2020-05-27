import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Product/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {
  final String CLIENTS = "clients";
  final String PRODUCTS = "products";

  final Firestore _db = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateClientData(Client client) async {
    print(
        "*************************************UpdateClientData********************************************");
    DocumentReference ref = _db.collection(CLIENTS).document(client.uid);
    return await ref.setData({
      'uid': client.uid,
      'name': client.name,
      'email': client.email,
      'photoURL': client.photoURL,
      'date': client.date,
      'phone': client.phone,
      'status': true,
      'lastSignIn': DateTime.now(),
    }, merge: true);
  }

  Future<void> updateProductData(Product product) async {
    CollectionReference refProducts = _db.collection(PRODUCTS);

    await _auth.currentUser().then((FirebaseUser user) {
      refProducts.add({
        'name': product.name,
        'description': product.description,
        'likes': product.likes,
        'urlImage': product.urlImage,
        'userOwner': _db.document("${CLIENTS}/${user.uid}"), //reference
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          //ID Product REFERENCIA ARRAY
          DocumentReference refUsers =
              _db.collection(CLIENTS).document(user.uid);
          refUsers.updateData({
            'myProducts': FieldValue.arrayUnion(
                [_db.document("${CLIENTS}/${snapshot.documentID}")])
          });
        });
      });
    });
  }

  List<Product> buildProducts(
      List<DocumentSnapshot> productsListSnapshot, Client user) {
    List<Product> products = List<Product>();

    productsListSnapshot.forEach((p) {
      Product product = Product(
        id: p.documentID,
        name: p.data["name"],
        description: p.data["description"],
        urlImage: p.data["urlImage"],
        likes: p.data["likes"],
        price: p.data["price"].toDouble(),
        isBulk: p.data["isBulk"],
        category: p.data["category"],
        store: p.data["store"],
      );
      List usersLikedRefs = p.data["usersLiked"];
      product.liked = false;
      usersLikedRefs?.forEach((drUL) {
        if (user.uid == drUL.documentID) {
          product.liked = true;
        }
      });
      List usersAddedRefs = p.data["usersAdded"];
      product.added = false;
      usersAddedRefs?.forEach((drUL) {
        if (user.uid == drUL["userReference"].documentID) {
          product.added = true;
          product.amount = drUL["amount"];
        }
      });
      products.add(product);
    });
    return products;
  }

  Future likeProduct(Product product, String uid) async {
    await _db
        .collection(PRODUCTS)
        .document(product.id)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds.data["likes"];

      _db.collection(PRODUCTS).document(product.id).updateData({
        'likes': product.liked ? likes + 1 : likes - 1,
        'usersLiked': product.liked
            ? FieldValue.arrayUnion([_db.document("${CLIENTS}/${uid}")])
            : FieldValue.arrayRemove([_db.document("${CLIENTS}/${uid}")])
      });
    });
  }

  Future addFavorites(Product product, String uid) async {
    await _db
        .collection(PRODUCTS)
        .document(product.id)
        .get()
        .then((DocumentSnapshot ds) {
      print("Added to favorites");
      print(ds.data);

      _db.collection(CLIENTS).document(uid).updateData({
        'favorites': product.liked
            ? FieldValue.arrayUnion([_db.document("${PRODUCTS}/${product.id}")])
            : FieldValue.arrayRemove(
                [_db.document("${PRODUCTS}/${product.id}")])
      });
    });
  }

  Future addProduct(Product product, String uid, bool plus, bool newP) async {
    print(product.amount);
    await _db
        .collection(PRODUCTS)
        .document(product.id)
        .get()
        .then((DocumentSnapshot ds) {
      if (newP) {
        _db.collection(PRODUCTS).document(product.id).updateData({
          'usersAdded': product.added
              ? FieldValue.arrayUnion([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": 1
                  }
                ])
              : FieldValue.arrayRemove([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": product.amount
                  }
                ])
        });
      } else {
        _db.collection(PRODUCTS).document(product.id).updateData({
          'usersAdded': plus
              ? FieldValue.arrayRemove([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": product.amount - 1
                  }
                ])
              : FieldValue.arrayRemove([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": product.amount + 1
                  }
                ])
        });
        _db.collection(PRODUCTS).document(product.id).updateData({
          'usersAdded': product.added
              ? FieldValue.arrayUnion([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": product.amount
                  }
                ])
              : FieldValue.arrayRemove([
                  {
                    "userReference": _db.document("${CLIENTS}/${uid}"),
                    "amount": product.amount
                  }
                ])
        });
      }
    });
  }

  Future addCart(Product product, String uid) async {
    await _db
        .collection(PRODUCTS)
        .document(product.id)
        .get()
        .then((DocumentSnapshot ds) {
      print("Added to cart");
      print(ds.data);

      _db.collection(CLIENTS).document(uid).updateData({
        'shoppingCart': product.added
            ? FieldValue.arrayUnion([_db.document("${PRODUCTS}/${product.id}")])
            : FieldValue.arrayRemove(
                [_db.document("${PRODUCTS}/${product.id}")])
      });
    });
  }

  Future clearShoppingCart(String uid, List<Product> products) async {
    print("clearShoppingCart");
    products?.forEach((product) async {
      print(product.name+": "+product.amount.toString());
      await _db
          .collection(PRODUCTS)
          .document(product.id)
          .get()
          .then((DocumentSnapshot ds) {
        _db.collection(PRODUCTS).document(product.id).updateData({
          'usersAdded': FieldValue.arrayRemove([
            {
              "userReference": _db.document("${CLIENTS}/${uid}"),
              "amount": product.amount
            }
          ])
        });
      });
    });
  }
}
