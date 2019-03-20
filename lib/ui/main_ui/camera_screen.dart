import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class Cam extends StatefulWidget {
  @override
  _CamState createState() => _CamState();
}

class _CamState extends State<Cam> {


  File _image;
  
  Future getImage() async{

    var image=await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image=image;
    });
    
  }
  @override
  void initState() {
    super.initState();
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    return Center(

      child: _image==null?Text('No Image To Load'):Image.file(_image)
      
    );
  }
}