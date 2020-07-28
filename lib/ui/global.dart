import 'package:flutter/material.dart';

Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regex = RegExp(pattern);

displaySnackBar(String msg, GlobalKey<ScaffoldState> _scaffoldKey,
    [Color color = Colors.black87]) {
  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: color,
    duration: Duration(milliseconds: 1500),
  );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}
