import 'package:bookshelf_admin/edit_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';


class AddBook1 extends StatefulWidget {
  @override
  _AddBook1State createState() => _AddBook1State();
}

class _AddBook1State extends State<AddBook1> {
  String bkname = null;
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
                    'Add a Book',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
                          Navigator.pushReplacementNamed(context,'/printdetAdd',arguments: {'bookname1' : bkname,});
                        else
                          Fluttertoast.showToast(msg: 'Please enter the book name',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);},
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: Text(
                        'VERIFY',
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
