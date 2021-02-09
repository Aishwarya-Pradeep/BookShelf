import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'adminSetup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _auth = FirebaseAuth.instance;
  String username,email, password;
  bool emailValidate = true, passwordValidate = true, nameValidate = true ;
  bool showSpinner = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController(),mailid = TextEditingController();


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    mailid.dispose();
  }

  bool usernameVal = false,passwordVal = false,mail = false;
  void validateEmail(String email) {
    final emailRegex =
    RegExp(r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+([\.-]?\w+)*(\.\w{2,3})+$');
    if (email.isNotEmpty) {
      if (emailRegex.hasMatch(email))
        setState(() {
          emailValidate = true;
        });
      else
        setState(() {
          emailValidate = false;
        });
    } else
      setState(() {
        emailValidate = false;
      });
  }

  void validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (password.isNotEmpty) {
      if (passwordRegex.hasMatch(password))
        setState(() {
          passwordValidate = true;
        });
      else
        setState(() {
          passwordValidate = false;
        });
    } else
      setState(() {
        passwordValidate = false;
      });
  }

  void validateName(String name) {
    final passwordRegex = RegExp(r'^[a-zA-Z ]*$');
    if (name.isNotEmpty) {
      if (passwordRegex.hasMatch(name))
        setState(() {
          nameValidate = true;
        });
      else
        setState(() {
          nameValidate = false;
        });
    } else
      setState(() {
        nameValidate = false;
      });
  }

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
                height: 20.0,
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
                        'Admin Sign Up',
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
                            hintText: 'Admin Name',
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none)),
                            suffixIcon: Icon(
                              Icons.account_circle,
                              color: Color(0xFF02340F),
                            ),
                            errorText:
                            nameValidate ? null : 'Incorrect Full name',),
                          onChanged: (value) {
                            username = value;
                          },
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
                          controller: mailid,
                          decoration: textFieldDecoration.copyWith(
                            hintText: 'Email Id',
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none)),
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Color(0xFF02340F),
                            ),
                              errorText:
                              emailValidate ? null : 'Incorrect Email ID'),
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
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                              errorText: passwordValidate
                                  ? null
                                  : 'Password must have minimum 8 characters with at least 1 letter and 1 number',
                              errorMaxLines: 2,
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
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        //onTap: (){isValid();},
                        child: Material(
                          elevation: 5.0,
                          color: Color(0xFF02340F),
                          borderRadius: BorderRadius.circular(30.0),


                          child: RawMaterialButton(
                            onPressed: () async {
                              validateEmail(mailid.text);
                              validatePassword(passwordController.text);
                              validateName(usernameController.text);
                              if (emailValidate &&  passwordValidate && nameValidate)
                                try {
                                final newUser = await _auth
                                    .createUserWithEmailAndPassword(
                                    email: email, password: password);
                                if (newUser != null) {
                                  adminSetup(usernameController.text);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomePage()));
                                }

                              }
                              catch (e) {
                                print(e);
                                Fluttertoast.showToast(msg: 'User already exists! Please login',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.transparent,textColor: Colors.red,fontSize: 12.0);
                              }
                            },
                            padding: EdgeInsets.symmetric(horizontal: 70.0),

                            child: Text(
                              'REGISTER',
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
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF02340F),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
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


    bool isValidu() {
      String text = usernameController.text;
      if (text.isNotEmpty) {
        usernameVal = false;
        return true;
      }
      else
        usernameVal = true;
      return false;
    }
    bool isValidp() {
      String text2 = passwordController.text;
      if (text2.isNotEmpty) {
        passwordVal = false;
        return true;
      }
      else
        passwordVal = true;
      return false;
    }
  bool isValidm() {
    String text3 = mailid.text;
    if (text3.isNotEmpty) {
      mail = false;
      return true;
    }
    else
      mail = true;
    return false;
  }
  }