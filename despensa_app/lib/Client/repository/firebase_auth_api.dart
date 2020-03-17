import 'dart:async';
import 'dart:io';
import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Client/repository/cloud_firestore_repository.dart';
import 'package:despensaapp/Client/repository/firebase_storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    FirebaseUser user = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: gSA.idToken, accessToken: gSA.accessToken));
    return user;
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((FirebaseUser user) async {
      print(user);
      final String CLIENTS = "clients";
      final Firestore _db = Firestore.instance;
      DocumentSnapshot ds = await _db.collection(CLIENTS).document(user.uid).get();
      if (ds.exists){
        print('********************** EXISTE CLIENTE **********************');
        if(ds.data["status"]==true){
          print('********************** CLIENTE ACTIVO **********************');
        }else{
          print('********************** CLIENTE INACTIVO **********************');
          return Future.wait([
            _firebaseAuth
                .signOut()
                .then((onValue) => print("Sesión cerrada: _firebaseAuth")),
          ]);
        }
      }else{
        print('********************** NO EXISTE CLIENTE **********************');
        return Future.wait([
          _firebaseAuth
              .signOut()
              .then((onValue) => print("Sesión cerrada: _firebaseAuth")),
        ]);
      }
    });
  }

  Future<void> signUp(
      {String email,
      String password,
      String name,
      String lastName,
      String date,
      String phone,
      File image}) async {
    print('Image path: ' + image.path);
    return await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((FirebaseUser client) {
      print(client);
      //ID del usuario logeado actualmente
      String uid = client.uid;
      String path = "${uid}/${DateTime.now().toString()}.jpg";

      uploadFile(path, image).then((StorageUploadTask storageUploadTask) {
        storageUploadTask.onComplete.then((StorageTaskSnapshot snapshot) {
          snapshot.ref.getDownloadURL().then((urlImage) {
            print("URLIMAGE: ${urlImage}");

            //2. Cloud Firestore
            //Place - title, description, url, userOwner, likes
            var fulname = name + ' ' + lastName;
            updateClientData(Client(
                uid: client.uid,
                email: client.email,
                name: fulname,
                photoURL: urlImage,
                date: date,
                phone: phone,
            ));
          });
        });
      });
    });
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth
          .signOut()
          .then((onValue) => print("Sesión cerrada: _firebaseAuth")),
      _googleSignIn
          .signOut()
          .then((onValue) => print("Sesión cerrada: _googleSignIn")),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  //Casos uso
  // Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateClientData(Client client) =>
      _cloudFirestoreRepository.updateClientDataFirestore(client);

  // Cargar imagen en Storage
  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);
}