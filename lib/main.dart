import 'package:flutter/material.dart';
import 'package:news_app/views/home_screen.dart';

void main() async{

  runApp(
    MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
