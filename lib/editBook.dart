import 'package:bookshelf_admin/edit_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


class editBook extends StatefulWidget {
  @override
  _editBookState createState() => _editBookState();
}

class _editBookState extends State<editBook> {
  String bkname;
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
                    left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                child: Container(
                  width: 850.0,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: currencyItems,
                        onChanged: (currencyValue) {
                          setState(() {
                            bkname = currencyValue;
                          });
                        },
                        value: bkname,
                        isExpanded: false,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Book Name',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
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
            onPressed: (){Navigator.pushReplacementNamed(context,'/editBookDe',arguments: {'bookname1' : bkname,});},
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
