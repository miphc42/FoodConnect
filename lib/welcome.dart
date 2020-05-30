import 'package:flutter/material.dart';
import 'package:foodbank/Global/niceBar.dart';
import 'package:foodbank/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:foodbank/camera.dart';
import 'dart:async';
import 'dart:io';

class Welcome extends StatefulWidget {
  final Storage storage;
  Welcome({this.storage});
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    widget.storage.readChoice().then((bool value) {
      if(value==true){
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
          ),
        );
      }else if(value==false){
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Camera(),
          ),
        );
      }
    });

    return Scaffold(
      appBar: NiceBar(),
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
            'Hi! Welcome to FoodConnect',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
          SizedBox(height: 80,),
          Text(
            'Are you a Food Bank or a donator?',
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 28
            ),
          ),
          SizedBox(height: 50,),
          FlatButton(
            padding: EdgeInsets.fromLTRB(20,10,20,10),
            shape: StadiumBorder(
              side: BorderSide(color: Colors.green[900], width: 2)
            ),
            child: Text(
              'Food Bank',
              style: TextStyle(
                fontFamily: "Arial",
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
                fontSize: 20
              ),
            ),
            onPressed: (){
              widget.storage.writeChoice(true);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home())
              );
            },
          ),
          SizedBox(height: 10,),
          FlatButton(
            padding: EdgeInsets.fromLTRB(40,10,40,10),
            shape: StadiumBorder(
              side: BorderSide(color: Colors.green[900], width: 2)
            ),
            child: Text(
              'Donator',
              style: TextStyle(
                fontFamily: "Arial",
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
                fontSize: 20
              ),
            ),
            onPressed: (){
              widget.storage.writeChoice(false);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Camera())
              );
            },
          ),
          ],
        ),
      ),
    );
  }
}

class Storage{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/foodbank.txt');
  }

  Future<bool> readChoice() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      if(contents=='false'){
        return false;
      }
      else if(contents=='true'){
        return true;
      }
      else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<File> writeChoice(bool choice) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$choice');
  }
}