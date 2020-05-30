import 'package:flutter/material.dart';
import 'package:foodbank/Global/niceBar.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NiceBar(),
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Column(children: <Widget>[
          
        ],),
      )

    );
  }
}