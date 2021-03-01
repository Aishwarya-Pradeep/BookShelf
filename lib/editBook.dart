import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_search/textfield_search.dart';



class editBook extends StatefulWidget {
  @override
  _editBookState createState() => _editBookState();
}

class _editBookState extends State<editBook> {
  String bkname = null;
  TextEditingController myController = TextEditingController();
  var dummyList = [];

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    if(myController.text != "")
      bkname = myController.text;
    else
      bkname = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCEF6A0),
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
    child: Column(
    children: [
      SizedBox(
        height: 30.0,
      ),
    Padding(
    padding: const EdgeInsets.only(top: 15.0, bottom: 7.0, left: 16.0),
    child: Text(
    'Edit Book',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    ),
    ),
    ),
      SizedBox(
        height: 30.0,
      ),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup("BookDetails").orderBy('bookName').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData){}
            else {
              List<DropdownMenuItem> currencyItems = [];

              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot snap = snapshot.data.docs[i];
                dummyList.add(snap.id);
                currencyItems.add(
                  DropdownMenuItem(
                    child: Text(
                      snap.id,
                    ),
                    value: "${snap.id}",
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0),
                child: Container(
                  width: 700.0,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: TextFieldSearch(initialList: dummyList, label: "Book Name", controller: myController),
                  ),
                ),
              );
            }
          }),
      SizedBox(
        height: 30.0,
      ),
      Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: Material(
          elevation: 5.0,
          color: Color(0xFF02340F),
          borderRadius: BorderRadius.circular(30.0),
          child: RawMaterialButton(
            onPressed: (){
              if(bkname != null)
                Navigator.pushReplacementNamed(context,'/editBookDe',arguments: {'bookname1' : bkname,});
              else
                Fluttertoast.showToast(msg: 'Please select a book',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);},
            padding: EdgeInsets.symmetric(horizontal: 70.0),
            child: Text(
              'SEARCH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
      ),
    ]),
    ),
    ),
    );
  }
}
