import 'package:bookshelf_admin/addBookDynamic.dart';
import 'package:bookshelf_admin/add_book.dart';
import 'package:bookshelf_admin/bookdetailsDynamicPrint.dart';
import 'package:bookshelf_admin/delete_book.dart';
import 'package:bookshelf_admin/edit_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit_book.dart';
import 'delete_book.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(bookshelf_admin());
}

class bookshelf_admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF02340F),
        fontFamily: 'SegoeUI',
        textTheme:TextTheme(
          bodyText1:TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=>SplashScreen(),
        '/home': (context)=>HomePage(),
        '/editBookDe' : (context)=>editBookDetails(),
        '/deleteBookDe' : (context)=>deleteBookD(),
        '/printdetAdd' : (context)=>SelectedBook(),
        '/addBook' : (context)=>AddBook(),
      },
    );
  }
}