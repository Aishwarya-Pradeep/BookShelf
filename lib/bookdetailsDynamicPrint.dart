import 'add_book.dart';
import 'adminSetup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'components.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

import 'homepage.dart';

var currentUserEmail;
const apiKey = "AIzaSyCOPh4H81SCcHbC32jvhIw8DI0YUj_pF0I";
var category = ['Novels', 'Educational', 'Comics', 'Spiritual'];
var subjects = ['Computer Science', 'Chemistry', 'Biology', 'Literature', 'Physics', 'Mathematics', 'Law', 'Accountancy', 'Business', 'Economics', 'Humanities'];
var genres = ['Action', 'Adventure', 'Classic', 'Comedy', 'Fantasy', 'Fiction', 'History', 'Horror', 'Mystery', 'Poetry', 'Romance', 'Thriller'];
var currentLanguageSelected;
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
String genre1,genre2;
var currentGenre1Selected;
var currentGenre2Selected;
var currentCategorySelected;
var currentSubjectSelected;
class SelectedBook extends StatefulWidget {
  final String author, title, imageURL, path;
  SelectedBook({this.author, this.imageURL, this.title, this.path});

  @override
  _SelectedBookState createState() => _SelectedBookState();
}

class _SelectedBookState extends State<SelectedBook> {
  Future<File> imageFile;
  File _image,_pdf;
  String fileName = "";

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

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
    imageURL = await uploadFile(_image);
  }

  bool isSpiritual = false;
  String genre1 = "", genre2 = "", description = "";
  Map bookname1;
  List<Widget> columnChild = [];
  String imageURL = "", author = "", language = "", bName = "",bookname = "";
  TextEditingController booknameController = new TextEditingController(),authnameController = new TextEditingController(),langController = new TextEditingController(),descController = new TextEditingController();
  int counter = 1;
  void getBookDetails(String name) async
  {
    if (counter == 1) {
      Networking networking = Networking(
          url: 'https://www.googleapis.com/books/v1/volumes?q=intitle:$name&key=$apiKey');
      var bookData = await networking.getBookData();
      if (bookData == "error"){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Invalid BookName'),  // To display the title it is optional
                content: Text('Please enter the book details manually'),   // Message which will be pop up on the screen
                // Action widget which will provide the user to acknowledge the choice
                actions: [
                  FlatButton(           // FlatButton widget is used to make a text to work like a button
                    textColor: Colors.black,
                    onPressed: () {Navigator.pop(context);},        // function used to perform after pressing the button
                    child: Text('CANCEL'),
                  ),
                  FlatButton(
                    textColor: Colors.black,
                    onPressed: () {Navigator.pushReplacementNamed(context,'/addBook');},
                    child: Text('OK'),
                  ),
                ],
              );
            });
      }
      if (bookData != null) {
        setState(() {
          try {
            bName = bookData['items'][0]['volumeInfo']['title'];
            author = bookData['items'][0]['volumeInfo']['authors'][0];
            description = bookData['items'][0]['volumeInfo']['description'];
            imageURL =
            bookData['items'][0]['volumeInfo']['imageLinks']['thumbnail'];
            language = bookData['items'][0]['volumeInfo']['language'];
          }
          catch (e){
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Invalid BookName'),  // To display the title it is optional
                    content: Text('Please enter the details manually'),   // Message which will be pop up on the screen
                    // Action widget which will provide the user to acknowledge the choice
                    actions: [
                      FlatButton(           // FlatButton widget is used to make a text to work like a button
                        textColor: Colors.black,
                        onPressed: () {Navigator.pop(context);},        // function used to perform after pressing the button
                        child: Text('CANCEL'),
                      ),
                      FlatButton(
                        textColor: Colors.black,
                        onPressed: () {Navigator.pushReplacementNamed(context,'/addBook',);},
                        child: Text('OK'),
                      ),
                    ],
                  );
                });
          }
        });
        print('language = $language');
        print('imageurl = $imageURL');
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AddBook()));
      }

      counter = counter+1;
    }
  }


  @override
  Widget build(BuildContext context) {
    bookname1 = ModalRoute.of(context).settings.arguments;
    bookname = bookname1['bookname1'];
    getBookDetails(bookname);
    if((bName == null)||(author == null)||(description == null)||(imageURL == null)||(language == null))
    {        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid BookName'),  // To display the title it is optional
            content: Text('Please enter the book details manually'),   // Message which will be pop up on the screen
            // Action widget which will provide the user to acknowledge the choice
            actions: [
              FlatButton(           // FlatButton widget is used to make a text to work like a button
                textColor: Colors.black,
                onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => HomePage()));},        // function used to perform after pressing the button
                child: Text('CANCEL'),
              ),
              FlatButton(
                textColor: Colors.black,
                onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => AddBook()));},
                child: Text('OK'),
              ),
            ],
          );
        });
    }
    booknameController.value = TextEditingValue(text: bName);
    authnameController.value = TextEditingValue(text: author);
    descController.value = TextEditingValue(text: description);
    if (language == "en"){
      langController.value  = TextEditingValue(text: "English");
      currentLanguageSelected = "English";
    }
    return Scaffold(
      backgroundColor: Color(0xFFCEF6A0),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
              child: Row(
                children: [GestureDetector(
                  onTap: (){getImage(true);},
                  child: _image != null ? Container(
                    child: Image.file(
                      _image,
                      width: 120.0,
                      height: 190.0,
                      fit: BoxFit.fill,
                    ),
                  )
                      :
                      imageURL != null ?
                  Image.network(imageURL,width: 120.0,
                    height: 190.0,
                    fit: BoxFit.fill,)
                  : Text ('Image not selected'),
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170.0,
                          child: /*Text(bName,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),
                            maxLines: 4,
                          ),*/
                          TextField(
                            controller: booknameController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 4,
                            onChanged: (value) {
                              bName = value;
                              },
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,

                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0)
                            ),

                          ),
                        ),
                        SizedBox(
                          width: 170.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: TextField(
                              controller: authnameController,
                              onChanged: (value) {
                                author = value;
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14.0,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0)
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 120.0,
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.transparent,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(

                                  items: languages.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem,style: TextStyle(fontSize: 12.0,),),
                                        );
                                  }).toList(),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      'Language',
                                      style: TextStyle(fontSize: 12.0,),
                                    ),
                                  ),
                                  onChanged: (String newValueSelected) {
                                    currentLanguageSelected = newValueSelected;
                                  },
                                  value: currentLanguageSelected,
                                ),
                              ),
                            ),
                          ),


                  Container(
                      width: 120.0,
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: category.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem,style: TextStyle(fontSize: 12.0,),),
                              );
                            }).toList(),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Category',
                                style: TextStyle(fontSize: 12.0,),
                              ),
                            ),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                currentCategorySelected = newValueSelected;
                                columnChild = [];
                                if(currentCategorySelected == 'Novels' || currentCategorySelected == 'Comics'){
                                  columnChild.add(Genre1());
                                  columnChild.add(Genre2());
                                }
                                if(currentCategorySelected == 'Educational'){
                                  columnChild.add(Subject());
                                  columnChild.add(Tag());
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

                      Row(
                    children: columnChild,
                  ),
                    ]
      ),
    ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 16.0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
              //   //color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //     //  color: Color(0x20000000),
              //       offset: Offset(0.0, -1.0),
              //       blurRadius: 20.0,
              //     ),
              //   ],
              // ),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 28.0),
                    child: Text('About the Book',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 16.0, bottom: 7.0),
                    // child: Material(
                    //   color: Colors.transparent,
                    //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: TextField(
                        onChanged: (val){description = val;},
                        controller: descController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.justify,
                        minLines: 4,
                        maxLines: 10,
                      ),
                    // ),
                  ),
                ],
              ),
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
            Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Material(
                elevation: 5.0,
                color: Color(0xFF02340F),
                borderRadius: BorderRadius.circular(30.0),
                child: RawMaterialButton(
                  onPressed: () {
                    if (currentCategorySelected == 'Spiritual')
                      addBook(bName,author,currentLanguageSelected,currentCategorySelected,_pdf,description,imageURL);
                    else
                      addBook(bName,author,currentLanguageSelected,currentCategorySelected,_pdf,description,imageURL,currentGenre1Selected,currentGenre2Selected);
                      Fluttertoast.showToast(msg: 'Book Added Successfully',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                  ,
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
            ),),
          ],
        ),
      ),
    );
  }

}
class Networking {
  final String url;

  Networking({this.url});

  Future getData() async {
    try{
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
    else
      print(response.statusCode);
    }
    catch(e){
      return "error";
    }
  }

  Future<dynamic> getBookData() async
  {
    var bookData = await getData();
    return bookData;
  }
}
class Subject extends StatefulWidget {
  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 125.0,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: subjects.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem,style: TextStyle(fontSize: 12.0,),),
                );
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Subjects',
                  style: TextStyle(fontSize: 12.0,),
                ),
              ),
              onChanged: (String newValueSelected) {
                setState(() {
                  currentGenre1Selected = newValueSelected;
                  genre1 = newValueSelected;
                });
              },
              value: currentSubjectSelected,
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
    return Container(
        width: 80.0,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: genres.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem,style: TextStyle(fontSize: 12.0,),),
                    );
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Genre 1',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              onChanged: (String newValueSelected) {
                setState(() {
                  genre1 = newValueSelected;
                  currentGenre1Selected = newValueSelected;

                });
              },
              value: currentGenre1Selected,
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
    return  Padding(
        padding: const EdgeInsets.only(left: 35.0),
        child: Container(
        width: 80.0,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: genres.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem,style: TextStyle(fontSize: 12.0,),),
                    );
              }).toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Genre 2',
                  style: TextStyle(fontSize: 12.0,),
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
      ),);
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
    return
      Padding(
        padding: const EdgeInsets.only(left: 35.0),
    child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          width: 50.0,
          child: TextField(
            decoration: InputDecoration(hintText: "Tag"),
            style: TextStyle(fontSize: 12.0,),

            onChanged: (val) {
              currentGenre2Selected = val;
              genre2 = val;
            },
          ),
        ),
      ),);
  }
}