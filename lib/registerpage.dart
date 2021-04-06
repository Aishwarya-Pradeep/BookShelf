import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'adminSetup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Timer timer;
  User user;
  Future<dynamic> coolAlert;
  final _auth = FirebaseAuth.instance;
  String username,email, password;
  bool emailValidate = true, passwordValidate = true, nameValidate = true ;
  bool showSpinner = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController(),mailid = TextEditingController();


  @override
  void dispose() {
    super.dispose();
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
  Future<void> checkEmail() async{
    var user = _auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      await adminSetup(usernameController.text);
      setState(() {
        coolAlert = CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: 'Successful',
            text: "Your email has been verified.",
            confirmBtnText: 'Continue',
            confirmBtnColor: Color(0xFF02340F),
            backgroundColor: Color(0xFFCEF6A0),
            onConfirmBtnTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => HomePage()));
            }
        );
      });
    }
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
                    fontSize: 100.0,
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
                height: 120,
              ),
              SizedBox(
                height: 18.0,
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
                          horizontal: 12.0, vertical: 2.0),
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
                          horizontal: 12.0, vertical: 10.0),
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
                          horizontal: 12.0, vertical: 8.0),
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
                                  user = _auth.currentUser;
                                  user.updateProfile(displayName: username);
                                  user.sendEmailVerification();
                                  setState(() {
                                    coolAlert = CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      confirmBtnColor: Color(0xFF02340F),
                                      backgroundColor: Color(0xFFCEF6A0),
                                      title: 'Verify',
                                      text: "A verification link has been sent to you account. Click on it to verify your email.",
                                    );
                                  });
                                  timer = Timer.periodic(Duration(seconds: 3), (timer) {checkEmail(); });

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
                      height: 20.0,
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
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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