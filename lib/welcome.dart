import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodConnect"),
      ),
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: <Widget>[
        Text(
          'Hi! Welcome to FoodConnect',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
        SizedBox(height: 20,),
        Text(
          'Are you a Food Bank or a citizen?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        FlatButton(
          child: Text(
            'Food Bank',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
          onPressed: (){
            widget.storage.writeChoice(true);
          },
        ),
        FlatButton(
          child: Text(
            'Citizen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
          onPressed: (){
            widget.storage.writeChoice(false);
          },
        ),
        ],
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