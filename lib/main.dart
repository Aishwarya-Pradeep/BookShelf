import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookshelf_admin/loginpage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
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
      },
    );
  }
}