import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = FirebaseFirestore.instance;
String bkname,authname,description,image_url,category;

class deleteBookD extends StatefulWidget {
  @override
  _deleteBookDState createState() => _deleteBookDState();
}

class _deleteBookDState extends State<deleteBookD> {
  String bkname,authname,description,image_url,category;
  Map bookname1;

  @override
  Widget build(BuildContext context) {
    bookname1 = ModalRoute.of(context).settings.arguments;
    bkname = bookname1['bookname1'];
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collectionGroup('BookDetails')
          .where('bookName', isEqualTo: bkname)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final books = snapshot.data.docs;
          for (var book in books) {
            image_url = book.data()['image'];
            authname = book.data()['author'];
            description = book.data()['description'];
            category = book.data()['category'];
          }
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
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
              Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0, bottom: 7.0),
                    child: GestureDetector(
                      child: Card(
                        color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                            children: [
                              SizedBox(
                                width: 130,
                              child: Image.network(image_url,fit: BoxFit.contain,),),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 170.0,
                                      child: Text(bkname,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        maxLines: 4,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text('by '+authname,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                SizedBox(height: 20.0,),
                                SizedBox(
                                  width: 150.0,
                                  child: Text(description,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 7,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                child: Material(
                                  elevation: 10.0,
                                  color: Color(0xFF02340F),
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: RawMaterialButton(
                                    onPressed: (){
                                      CollectionReference bookDetails = FirebaseFirestore.instance.collection('Books/'+category+'/BookDetails');
                                      bookDetails.doc(bkname).delete();
                                      Fluttertoast.showToast(msg: 'Deleted Book Successfully',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Color(0xFF02340F),textColor: Color(0xFFCEF6A0),fontSize: 18.0);
                                      Navigator.pop(context);},

                                    padding: EdgeInsets.symmetric(horizontal: 130.0),
                                    child: Text(
                                      'DELETE',
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
                      onTap: (){},
                    ),
                  )]
              ),
            ),
          )

          );
        } else {
          return Center(
            child: SizedBox(height: 1.0,child: Text('hello'),),
          );
        }
      },
    );
  }

}
