import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as Path;

Future<void> adminSetup(String displayName) async{
  CollectionReference admins = FirebaseFirestore.instance.collection('Admin');
  FirebaseAuth auth = FirebaseAuth.instance;
  admins.doc(auth.currentUser.email.toString()).set({
    'adminName': displayName
  });
  return;
}
Future<void> addBook(String bookname,String author,String language,String category,String link,String description,File _image,[String genre1,String genre2]) async{
  String path = 'Books/'+ category+'/'+'BookDetails',l;
  l = await saveImages(_image,path);
  CollectionReference bookDetails = FirebaseFirestore.instance.collection(path);
  bookDetails.doc(bookname).set({
    'bookName': bookname,
    'author' : author,
    'language' : language,
    'category' : category,
    'link' : link,
    'description' : description,
    'image' : l,
    'genre1' : genre1,
    'genre2' :genre2,
  });

}
Future<String> uploadFile(File _image,String path) async {
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('bookimages/${Path.basename(_image.path)}');
  UploadTask uploadTask = storageReference.putFile(_image);
  String returnURL;
  var url = await(await uploadTask).ref.getDownloadURL();
  returnURL = url.toString();
  return returnURL;
}
Future<String> saveImages(File _image,String path) async {
    String imageURL = await uploadFile(_image,path);
    return imageURL;
}
