import 'package:flutter/material.dart';
import 'package:foodbank/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: "FoodConnect",
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Home(),
    )
  );
}

