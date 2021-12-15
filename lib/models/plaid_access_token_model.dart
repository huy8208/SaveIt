import 'package:cloud_firestore/cloud_firestore.dart';

// PlaidAccessToken Object to store PlaidAccessToken information from FireBase
class PlaidAccessToken {
  final String access_token;
  final String bank_name;
  final String docID;

  const PlaidAccessToken(
      {required this.docID,
      required this.access_token,
      required this.bank_name});

  static PlaidAccessToken fromSnapshot(DocumentSnapshot snapshot) {
    PlaidAccessToken accessToken = PlaidAccessToken(
        docID: snapshot.id,
        access_token: snapshot['access_token'],
        bank_name: snapshot[snapshot['access_token']]);
    return accessToken;
  }
}
