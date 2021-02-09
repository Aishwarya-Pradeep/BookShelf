import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'adminSetup.dart';
import 'homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'constants.dart';

String genre1,genre2;
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
var category = ['Novels', 'Educational', 'Comics', 'Spiritual'];
var subjects = ['Computer Science', 'Chemistry', 'Biology', 'Literature', 'Physics', 'Mathematics', 'Law', 'Accountancy', 'Business', 'Economics', 'Humanities'];
var genres = ['Action', 'Adventure', 'Classic', 'Comedy', 'Fantasy', 'Fiction', 'History', 'Horror', 'Mystery', 'Poetry', 'Romance', 'Thriller'];
var currentGenre1Selected;
var currentGenre2Selected;
var currentLanguageSelected;
var currentCategorySelected;
var currentSubjectSelected;



class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  List<Widget> columnChild = [];

  Future<File> imageFile;
  File _image,_pdf;
  String bkname,authname,link,description,imageURL;
  Future getPDF() async {

    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    setState(() {
      if (result != null) {
        _pdf = File(result.files.single.path);
        // Use if you only need a single picture
      } else {
        print('No pdf selected.');
      }
    });

  }
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

    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageURL = await uploadFile(_image);
      } else {
        print('No image selected.');
      }
    });
  }
@override
  Widget build(BuildContext context) {
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
                  'Add a Book',
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
                    decoration: textFieldInputDecoration.copyWith(
                        hintText: 'Book Name'),
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
                    onChanged: (val){authname = val;},
                    decoration: textFieldInputDecoration.copyWith(
                        hintText: 'Author Name'),
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
                        onChanged: (String newValueSelected) {
                          setState(() {
                            currentLanguageSelected = newValueSelected;
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
                child: Container(
                  width: 350.0,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: category.map((String dropDownStringItem) {
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
                            'Category',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        onChanged: (String newValueSelected) {
                          setState(() {
                            currentCategorySelected = newValueSelected;
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
                          });
                        },
                        value: currentCategorySelected,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: columnChild,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: TextField(
                    onChanged: (val){description = val;},
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration:
                    textFieldInputDecoration.copyWith(hintText: 'Description'),
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
                    child: Text(
                  'No Image Selected',
                  textAlign: TextAlign.center,
                ))
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
              Center(

                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                    child: _pdf != null ? Container(
                      child: Text(
                        'PDF selected',
                      ),
                    )
                        : Container(
                        child: Text(
                          'No PDF Selected',
                          textAlign: TextAlign.center,
                        ))
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
                      if (currentCategorySelected == 'Spiritual')
                        addBook(bkname,authname,currentLanguageSelected,currentCategorySelected,_pdf,description,imageURL);
                      else
                        addBook(bkname,authname,currentLanguageSelected,currentCategorySelected,_pdf,description,imageURL,genre1,genre2);
                      Fluttertoast.showToast(msg: 'Book Added Successfully',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    padding: EdgeInsets.symmetric(horizontal: 70.0),
                    child: Text(
                      'ADD',
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
            },
          ),
        ),
      ),
    );
  }
}
