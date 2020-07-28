import 'package:flutter/material.dart';
import 'ui/account/login.dart';
import 'ui/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Fire News',
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
