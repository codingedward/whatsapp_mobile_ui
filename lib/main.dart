import 'package:flutter/material.dart';
import 'screens/welcome/welcome.dart';

void main() => runApp(
  MaterialApp(
    home: Welcome(),
    theme: ThemeData(
      cursorColor: Color(0xff075e54),
      primaryColor: Color(0xff075e54),
    ),
  )
);