import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> adminSetup(String displayName) async{
  CollectionReference admins = FirebaseFirestore.instance.collection('Admin');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  admins.doc(auth.currentUser.email.toString()).set({
    'adminName': displayName
  });
  return;
}