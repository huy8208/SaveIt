import 'package:cloud_firestore/cloud_firestore.dart';

class PlaidAccessToken {
  final String access_token;
  final String docID;

  const PlaidAccessToken({required this.access_token, required this.docID});

  static PlaidAccessToken fromSnapshot(DocumentSnapshot snapshot) {
    PlaidAccessToken accessToken = PlaidAccessToken(
        access_token: snapshot['access_token'], docID: snapshot.id);
    return accessToken;
  }
}
