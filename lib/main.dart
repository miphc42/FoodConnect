import 'package:flutter/material.dart';
import 'package:foodbank/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      title: "FoodConnect",
      theme: new ThemeData(
        fontFamily: "TenaliRamakrishna",
        primarySwatch: Colors.lightGreen,
      ),
      home: Welcome(storage: Storage(),),
    )
  );
}

