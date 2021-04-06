import 'package:bookshelf_admin/addBookDynamic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'deleteBook.dart';
import 'homepage2.dart';
import 'addBookDynamic.dart';
import 'editBook.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCEF6A0),
        drawer: navigationDrawer(),
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
        child: Center(
            child: Column(
            children: [
                Container(
                  width: 400,
                  height: 170,
                  padding: EdgeInsets.fromLTRB(20.0, 40.0,20.0, 20.0),
                  child: GestureDetector(
                    child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                      elevation: 10,
                      child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              MaterialButton(
                                onPressed: (){Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddBook1()));},
                                color: Color(0xFF02340F),
                                child: Icon(
                                  Icons.add_outlined,
                                      size: 50,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                                shape: CircleBorder(),
                              ),
                        SizedBox(
                          width: 90.0,
                          height: 55.0,

                          child: Center(
                            child: Text(
                            'Add Book',
                            style: TextStyle(
                              fontFamily: 'SEGOGEUI',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
            ),
              Container(
                width: 400,
                height: 170,
                padding: EdgeInsets.fromLTRB(20.0, 40.0,20.0, 20.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: (){Navigator.push(context, MaterialPageRoute(
                              builder: (context) => editBook()));},
                          color: Color(0xFF02340F),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                          shape: CircleBorder(),
                        ),
                        SizedBox(
                          width: 90.0,
                          height: 35.0,
                          child: Center(
                            child: Text(
                            'Edit Book',
                            style: TextStyle(
                              fontFamily: 'SEGOGEUI',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {Navigator.push(context, MaterialPageRoute(
                      builder: (context) => editBook()));},
                ),
              ),
              Container(
                width: 400,
                height: 170,
                padding: EdgeInsets.fromLTRB(20.0, 40.0,20.0, 20.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: (){Navigator.push(context, MaterialPageRoute(
                              builder: (context) => deleteBook()));},
                          color: Color(0xFF02340F),
                          child: Icon(
                            Icons.highlight_remove_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                          shape: CircleBorder(),
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 35.0,
                          child: Center(
                            child: Text(
                            'Delete Book',
                            style: TextStyle(
                              fontFamily: 'SEGOGEUI',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {Navigator.push(context, MaterialPageRoute(
                      builder: (context) => deleteBook()));},
                ),
              ),
      ],
    ),
    ),
    ),
    );
  }
}
