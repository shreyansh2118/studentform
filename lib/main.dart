import 'package:flutter/material.dart';
import 'package:studentform/homepage.dart';
import 'package:studentform/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  homePage(),
    );
  }
}