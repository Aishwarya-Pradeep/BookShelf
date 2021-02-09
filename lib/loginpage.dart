import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'homepage.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String email, password,errormsg;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  bool usernameVal = false,passwordVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFCEF6A0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'BookShelf',
                  style: TextStyle(
                    fontSize: 120.0,
                    fontFamily: 'Dandelion',
                    color: Color(0xFF02340F),
                  ),
                ),
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/images/admin.png'),
                ),
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                height: 160,
              ),
              SizedBox(
                height: 23.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Admin Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: TextField(
                          controller: usernameController,
                          decoration: textFieldDecoration.copyWith(
                              hintText: 'Email Id',
                            errorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: Color(0xFF02340F),
                              ),
                              errorText: usernameVal== true ? 'Please enter your username' : null,),
                          onChanged: (value) {
                            email = value;

                          },

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 20.0),
                      child: Material(
                        elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,

                          obscuringCharacter: "*",
                          decoration: textFieldDecoration.copyWith(
                              hintText: 'Password',
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
                              errorText: passwordVal ? 'Please enter your password' : null,
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF02340F),
                              )),
                          onChanged: (value) {
                            password = value;

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: GestureDetector(
                        onTap: (){isValid();},
                      child: Material(
                        elevation: 5.0,
                        color: Color(0xFF02340F),
                        borderRadius: BorderRadius.circular(30.0),


                        child: RawMaterialButton(
                          onPressed: () async{
                            if(isValid())
                            try {
                              final user = await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              if (user != null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              }
                            }
                            catch(e){
                              switch(e.code){
                                case "ERROR_INVALID_EMAIL":
                                  errormsg = "Invalid mail id!Please try again";
                                  break;
                                case "ERROR_WRONG_PASSWORD":
                                  errormsg = "Incorrect password!Try again";
                                  break;
                                case "ERROR_USER_NOT_FOUND":
                                  errormsg = "No such user! Please register";
                                  break;
                                default:
                                  errormsg = "Invalid Credentials! Please try again";
                              }
                              Fluttertoast.showToast(msg: errormsg,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.transparent,textColor: Colors.red,fontSize: 12.0);
                            }
                          },


                          padding: EdgeInsets.symmetric(horizontal: 70.0),

                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New Admin?',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF02340F),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));},
                            child: Text(
                              ' Register Now',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF02340F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    String text = usernameController.text;
    String text2 = passwordController.text;
    if (text.isNotEmpty && text2.isNotEmpty)
      return true;
    if (text.isEmpty){
      setState(() {
        usernameVal = true;
      });
    }
    else
      usernameVal = false;
    if (text2.isEmpty){
      setState(() {
        passwordVal = true;
      });
    }
    else
      passwordVal = false;
    return false;

  }
}