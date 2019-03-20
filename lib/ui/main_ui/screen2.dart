import 'package:flutter/material.dart';
import 'package:camera/camera.dart';



class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {

  List<CameraDescription> cameras;
  CameraController controller;

  @override
  void initState() {
    super.initState();
    _setupCameras();
}

  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      // initialize camera controllers.
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) {
      return;
    }
    setState(() {
      
    });
}
  
@override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    if(!controller.value.isInitialized){
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
      

    );

  }
}