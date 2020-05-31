import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:foodbank/Global/niceBar.dart';
import 'package:foodbank/welcome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
   final databaseReference = Firestore.instance;
  File _image;
  var all = new List();
  var _listSection = List<Widget>();
  String allText;
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
  Future getImage() async{
  var image;
  image = await ImagePicker.pickImage(source: ImageSource.camera);
  setState((){
      _image = image;
    });
    final File imageFile = _image;
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler(
  ImageLabelerOptions(confidenceThreshold: 0.75),
);
    all.clear();
    allText = "";
    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
  final String text = label.text;
  setState(() {
          all.add(text);
          allText += text + " ";
          
      });
      
      
  final String entityId = label.entityId;
  final double confidence = label.confidence;
}
setState((){_listSection.add(listSectionMethod(all.contains(
  "fruit")?"Food"
: "Orange")); });labeler.close();
}
   @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
      title: Text(
        'FoodConnect',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'TenaliRamakrishna',
          color: Colors.white,
          fontSize: 30,
        ),
      ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: 30.0,
            color: Colors.white,
           onPressed: (){
            //  Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => Welcome())
            //   );
           }) //{
           //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) //=> Texting()));
          //  },
        ],)
          
        ,
        backgroundColor: Colors.lightGreen[400],
        body:Center(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20,),

    //                new Container(
    //           width: 250.0,
    //       height: 250.0,
    //   alignment: Alignment.center,
    //   decoration: new BoxDecoration(

    //   image: DecorationImage(
    //       image: AssetImage('assets/Launcher_Icon.png'),
    //       fit: BoxFit.fill
    //   ),
    // ),      
        Container(
          alignment: Alignment.center,
          child: _image == null ? Text('No Image Showing') : Image.file(_image, height: 200,
          width: 300,),
        ),
        SizedBox(height: 20,),
         Column(
              children: _listSection
            ),
            FlatButton(
              color: Colors.lightGreen,
              child: Text(
                'Donate!',
                style: TextStyle(
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                  fontSize: 18
                ),
              ),
              onPressed: (){
                showAlertDialog(context).then((value) => deleteRecord());
                
             //   print("AAAAAAAAAAAAAAAAAAAA");
                
              },
            ),
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
              onPressed: (){
                
              },
            ),
      
                      
                
        // Text(allText != "" && all.contains("fruit")? "Orange": "No Food Found"),
                  ],
                )
                ),
                // child: _image == null? Text('No Image Selected'): Image.file(_image),
          
            // Text(
            //   all.length > 0 ? all[0]: ''
            //   ,
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(
            Icons.camera
          ),
        ),

        )
      );}
      
  void deleteRecord() {
    Firestore.instance.collection('requested_items').document("Orange").delete().whenComplete((){
  print('Field Deleted');
   setState(() {
                
                _listSection.removeLast();
              });
});
  }
   String t;
   String x,y;
   Future showAlertDialog(BuildContext context) async {
     x ="";
     y="";
     getData();
  // set up the button
  Widget okButton = await FlatButton(
    child: Text("OK"),
    onPressed: () {
        Navigator.of(context).pop();
     },
  );

  // Firestore.instance
  //       .collection('requeted_items')
  //       .document('Orange')
  //       .get()
  //       .then((DocumentSnapshot ds) {
  //      t = ds.data.toString();
  //      print(t);
  //      print("AAAAAAAAA");
  //      if(t=="null"){
  //        t = "No Foodbanks Need this Item";
  //        print("ww");
  //      }
  //      print(t);
  //   });
  
  // set up the AlertDialog
  AlertDialog alert = await AlertDialog(
    title: Text("Location of Foodbank"),
    content: Text(t),
    actions: [
      okButton,
    ],
  );
  x = "";

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
void getData() {
  databaseReference
      .collection("requested_items")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => f.documentID.toString() == "Orange"? x = f.data.toString().split(": ").toString(): y = "No Foodbanks Need this Item");
   
    snapshot.documents.forEach((f) =>print( f.documentID.toString()));
    setState(() {
       if(x==""){
      t = y;
    }else{t=x;}
    });
    print(t);
    
  });
}

}

