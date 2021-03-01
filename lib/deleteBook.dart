import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_search/textfield_search.dart';

final _firestore = FirebaseFirestore.instance;
dynamic data;
class deleteBook extends StatefulWidget {
  @override
  _deleteBookState createState() => _deleteBookState();
}

class _deleteBookState extends State<deleteBook> {
  String bkname = null;
  TextEditingController mycontrol = new TextEditingController();
  var bookN;

    _printLatestValue() {
      if(mycontrol.text != "")
        bkname = mycontrol.text;
      else
        bkname = null;
    }

    @override
    void initState() {
      super.initState();
      mycontrol.addListener(_printLatestValue);
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
                    'Delete Book',
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
                    stream: _firestore.collectionGroup("BookDetails").orderBy('bookName').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData){}
                      else {
                        List bknames = [];
                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data.docs[i];
                          bknames.add(snap.id);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 16.0, bottom: 7.0),
                          child: Container(
                            width: 850.0,
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              child: TextFieldSearch(initialList: bknames, label: "Book Name", controller: mycontrol),
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
                        if (bkname != null)
                          Navigator.pushReplacementNamed(context,'/deleteBookDe',arguments: {'bookname1' : bkname,});
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