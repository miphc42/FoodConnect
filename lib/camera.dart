import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  var all = new List();
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
    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
  final String text = label.text;
  setState(() {
          all.add(text);
      });
  final String entityId = label.entityId;
  final double confidence = label.confidence;
}
labeler.close();
}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Camera',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Camera'),
        ),
        body:Center(
              child: ListView.builder(
            itemCount: all.length,
              itemBuilder: (context, i){
                  return ListTile(
                    title: Text(all.length > 0? all[i]:"No Image Detected ${all.length}" ),
                  );
                
      },
              )
              // child: _image == null? Text('No Image Selected'): Image.file(_image),
            ),
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
}