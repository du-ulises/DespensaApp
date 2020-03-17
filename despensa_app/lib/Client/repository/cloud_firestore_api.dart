import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despensaapp/Client/model/client.dart';

class CloudFirestoreAPI {

  final String CLIENTS = "clients";

  final Firestore _db = Firestore.instance;

  void updateClientData(Client client) async{
    print("*************************************UpdateClientData********************************************");
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

}