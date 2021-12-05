import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUser {
  final String date_created;
  final String dob;
  final String email;
  final String name;
  final String docID;

  const FireStoreUser(
      {required this.date_created,
      required this.dob,
      required this.email,
      required this.name,
      required this.docID});

  static FireStoreUser fromSnapshot(DocumentSnapshot snapshot) {
    FireStoreUser profile = FireStoreUser(
        date_created: snapshot['date_created'],
        dob: snapshot['dob'],
        email: snapshot['email'],
        name: snapshot['name'],
        docID: snapshot.id);
    return profile;
  }
}
