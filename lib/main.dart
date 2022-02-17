import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapplication/pages/home_page.dart';
import 'routes/route.dart' as route;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      initialRoute: '/',
      onGenerateRoute: route.controller,
    );
  }
}
