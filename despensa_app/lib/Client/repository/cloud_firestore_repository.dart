import 'package:despensaapp/Client/model/client.dart';
import 'package:despensaapp/Client/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateClientDataFirestore(Client client) =>
      _cloudFirestoreAPI.updateClientData(client);

}
