import 'package:flutter/material.dart';
import 'package:foodbank/Global/niceBar.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> items=[];
  TextEditingController _textController;
  var _listSection = List<Widget>();
  String name;

  @override
  void initState(){
    super.initState();
    _textController = TextEditingController();
  }

  Card listSectionMethod(String title) {
    return new Card(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NiceBar(),
      backgroundColor: Colors.lightGreen[400],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: <Widget>[
            SizedBox(height: 10,),
            Center(
              child: Text(
                'Hi!',
                style: TextStyle(
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                  fontSize: 30
                ),
              ),
            ),
            SizedBox(height: 18,),
            Center(
              child: Text(
                'What items are you currently looking for?',
                style: TextStyle(
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                  fontSize: 18
                ),
              ),
            ),
            SizedBox(height: 28,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Your List',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontFamily: 'Arial',
                      fontSize: 18
                    ),
                  ),
                  Row(
                    children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.green[900],
                      onPressed: (){
                        _showAddDialog();
                      },
                    ),
                    SizedBox(width: 2,),
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.green[900],
                      onPressed: (){
                        setState(() {
                          _listSection.removeLast();
                        });
                      },
                    )
                  ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.green[900], thickness: 1,),
            SizedBox(height: 10,),
            Column(
              children: _listSection
            ),
            SizedBox(height: 28,),
            FlatButton(
              color: Colors.lightGreen,
              child: Text(
                'Edit Information',
                style: TextStyle(
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                  fontSize: 18
                ),
              ),
              onPressed: (){},
            ),
          ],
        ),
      )
    );
  }
  _showAddDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Item"),
        content: TextField(
          controller: _textController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              if(_textController.text.isEmpty){
                Navigator.pop(context);
                return;
              }
              setState(() {
                _listSection.add(listSectionMethod(_textController.text));
                _textController.clear();
                Navigator.pop(context);
              });
            }, 
          )
        ],
      )
    );
  }
}