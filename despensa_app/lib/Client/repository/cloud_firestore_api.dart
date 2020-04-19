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
}
