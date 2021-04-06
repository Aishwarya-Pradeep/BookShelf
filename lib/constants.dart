import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  labelStyle: TextStyle(color: Colors.black),
  hintText: 'Email ID',
  suffixIcon: Icon(Icons.email, color: Color(0xFF02340F),),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
  ),
);
InputDecoration textFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  labelStyle: TextStyle(color: Colors.black),
  hintText: 'Book Name',
  suffixIcon: null,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
  ),
);
class DividerWidget extends StatelessWidget {
  final double left, right;
  DividerWidget({this.left, this.right});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new Container(
        margin: EdgeInsets.only(left: left, right: right),
        child: Divider(
          color: Colors.black,
          height: 36,
          thickness: 1.5,
        ),
      ),
    );
  }
}
