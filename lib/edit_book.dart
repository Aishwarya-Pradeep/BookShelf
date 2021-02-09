import 'package:bookshelf_admin/adminSetup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'adminSetup.dart';
import 'constants.dart';

final _firestore = FirebaseFirestore.instance;
Future<File> imageFile;
File _image;
String bkname,authname,link,description,img,language,cat,genre1,genre2;
var languages = [
  'English',
  'Hindi',
  'Malayalam',
  'Tamil',
  'French',
  'German',
  'Korean',
  'Japanese',
  'Spanish'
];
String bookname;
var category = ['Novels', 'Educational', 'Comics', 'Spiritual'];
var subjects = ['Computer Science', 'Chemistry', 'Biology', 'Literature', 'Physics', 'Mathematics', 'Law', 'Accountancy', 'Business', 'Economics', 'Humanities'];
var genres = ['Action', 'Adventure', 'Classic', 'Comedy', 'Fantasy', 'Fiction', 'History', 'Horror', 'Mystery', 'Poetry', 'Romance', 'Thriller'];
var currentGenre1Selected;
var currentGenre2Selected;
var currentLanguageSelected;
var currentCategorySelected;
var currentSubjectSelected;

class editBookDetails extends StatefulWidget {
  @override
  _editBookDetailsState createState() => _editBookDetailsState();
}

class _editBookDetailsState extends State<editBookDetails> {



  List<Widget> columnChild = [];
  Future<File> imageFile;
  File _image;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if(gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,);
    }
    // Otherwise open camera to get new photo
    else{
      pickedFile = await picker.getImage(
        source: ImageSource.camera,);
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        updateImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }
  File _pdf;
  Future getPDF() async {

    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if(result != null){
      _pdf = File(result.files.single.path);
      Fluttertoast.showToast(msg: 'Pdf Added',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 12.0);
      updatePdf(_pdf);
    }


  }
  Map bookname1;


  @override
  Widget build(BuildContext context) {
    bookname1 = ModalRoute.of(context).settings.arguments;
    bookname = bookname1['bookname1'];
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collectionGroup('BookDetails')
          .where('bookName', isEqualTo: bookname)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final books = snapshot.data.docs;
          for (var book in books) {
            img = book.data()['image'];
            bkname = book.data()['bookName'];
            authname = book.data()['author'];
            link = book.data()['link'];
            currentLanguageSelected = book.data()['language'];
            description = book.data()['description'];
            currentCategorySelected = book.data()['category'];
            if (cat != 'Spiritual'){
            currentGenre1Selected = book.data()['genre1'];
            currentGenre2Selected = book.data()['genre2'];}
          }
          columnChild = [];
          if(currentCategorySelected == 'Novels' || currentCategorySelected == 'Comics'){
            columnChild.add(Divide());
            columnChild.add(Genre1());
            columnChild.add(Genre2());
            columnChild.add(Divide());
          }
          if(currentCategorySelected == 'Educational'){
            columnChild.add(Divide());
            columnChild.add(Subject());
            columnChild.add(Tag());
            columnChild.add(Divide());
          }
          if (currentCategorySelected == 'Spiritual'){
            columnChild = [];
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Text(
                  'BookShelf',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Dandelion',
                    color: Color(0xFFCEF6A0),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Color(0xFFCEF6A0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 15.0, bottom: 7.0, left: 16.0),
                      child: Text(
                        'Edit Book',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          enabled: false,
                          decoration: textFieldInputDecoration.copyWith(
                              hintText: bkname),
                          onChanged: (val){bkname = val;},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          onChanged: (val){CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                          bookDetails.doc(bookname).update({
                            'author' : val
                          });},
                          decoration: textFieldInputDecoration.copyWith(
                              hintText: authname),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Container(
                        width: 350.0,
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(

                              items: languages.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Text(dropDownStringItem),
                                    ));
                              }).toList(),
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(
                                  'Language',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              onChanged: (String newValueSelected) {CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                              bookDetails.doc(bookname).update({
                                'language' : newValueSelected,
                              });
                              },
                              value: currentLanguageSelected,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          enabled: false,
                          decoration: textFieldInputDecoration.copyWith(
                              hintText: currentCategorySelected),
                        ),
                      ),
                    ),
                    Column(
                      children: columnChild,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                    //   child: Material(
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //     child: TextField(
                    //       onChanged: (val){CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                    //       bookDetails.doc(bookname).update({
                    //         'link' : val,
                    //       });},
                    //       decoration: textFieldInputDecoration.copyWith(
                    //           hintText: link),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          onChanged: (val){CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                          bookDetails.doc(bookname).update({
                            'description' : val,
                          });},
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          decoration:
                          textFieldInputDecoration.copyWith(hintText: description),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                          width: 200.0,
                          child: FlatButton.icon(
                            onPressed: () {
                              getImage(true);
                            },
                            icon: Icon(Icons.image),
                            label: Text('Image'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                        child: _image != null ? Container(
                          child: Image.file(
                            _image,
                            width: 300,
                            height: 300,
                          ),

                        )

                            : Container(
                            child: Image.network(img,width: 300,
                              height: 300,))
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Container(
                            width: 200.0,
                            child: FlatButton.icon(
                              onPressed: () {
                                getPDF();

                              },
                              icon: Icon(Icons.upload_file),
                              label: Text('PDF'),
                            ),
                          ),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        color: Color(0xFF02340F),
                        borderRadius: BorderRadius.circular(30.0),
                        child: RawMaterialButton(
                          onPressed: (){
                            Fluttertoast.showToast(msg: 'Edited Successfully',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);
                            Navigator.pop(context);},
                          padding: EdgeInsets.symmetric(horizontal: 70.0),
                          child: Text(
                            'EDIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: SizedBox(height: 1.0,),
          );
        }
      },
    );
  }

  Future<void> updateImage(File image) async {
    String l = await uploadFile(_image);
    CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
    bookDetails.doc(bookname).update({
      'image' : l
    });
  }
  Future<void> updatePdf(File pdf) async {
    String l = await uploadPDF(_pdf);
    CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
    bookDetails.doc(bookname).update({
      'link' : l
    });
  }
}
class Subject extends StatefulWidget {
  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 7.0, bottom: 7.0),
      child: Container(
        width: 250.0,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: subjects.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(dropDownStringItem),
                    ));
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  'Subjects',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              onChanged: (String newValueSelected) {
                setState(() {
                  currentSubjectSelected = newValueSelected;
                  genre1 = newValueSelected;
                  CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                  bookDetails.doc(bookname).update({
                    'genre1' : genre1
                  });
                });
              },
              value: currentSubjectSelected,
            ),
          ),
        ),
      ),
    );
  }
}

class Genre1 extends StatefulWidget {
  @override
  _Genre1State createState() => _Genre1State();
}

class _Genre1State extends State<Genre1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 7.0, bottom: 7.0),
      child: Container(
        width: 250.0,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: genres.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(dropDownStringItem),
                    ));
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  'Genre 1',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              onChanged: (String newValueSelected) {
                setState(() {
                  currentGenre1Selected = newValueSelected;
                  genre1 = newValueSelected;
                  CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                  bookDetails.doc(bookname).update({
                    'genre1' : genre1
                  });
                });
              },
              value: currentGenre1Selected,
            ),
          ),
        ),
      ),
    );
  }
}

class Genre2 extends StatefulWidget {
  @override
  _Genre2State createState() => _Genre2State();
}

class _Genre2State extends State<Genre2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 7.0, bottom: 7.0),
      child: Container(
        width: 250.0,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: genres.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(dropDownStringItem),
                    ));
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  'Genre 2',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              onChanged: (String newValueSelected) {
                setState(() {
                  currentGenre2Selected = newValueSelected;
                  genre2 = newValueSelected;
                  CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
                  bookDetails.doc(bookname).update({
                    'genre2' : genre2
                  });

                });
              },
              value: currentGenre2Selected,
            ),
          ),
        ),
      ),
    );
  }
}

class Divide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Divider(
        color: Colors.black,
        height: 36,
        thickness: 1.5,
      ),
    );
  }
}

class Tag extends StatefulWidget {
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          width: 250.0,
          child: TextField(
            decoration: textFieldInputDecoration.copyWith(
                hintText: 'Tag'),
            onChanged: (val){
              genre2 = val;
              CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+ currentCategorySelected+'/'+'BookDetails');
              bookDetails.doc(bookname).update({
                'genre2' : genre2
              });
            },
          ),
        ),
      ),
    );
  }
}