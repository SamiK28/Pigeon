import 'package:flutter/material.dart';
import './ui/front_screen/front.dart';
import './ui/main_ui/screen1.dart';
import './UserData/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pigeon',
      home: FutureBuilder(
        initialData: false,
        builder: (context, snapshot) {
          bool _isSignedIn = snapshot.data;
          if (_isSignedIn) {
            return FutureBuilder(
                initialData: null,
                builder: (context, snapshot) => snapshot.hasData
                    ? UI()
                    : Center(
                        child: Material(
                          child: CircularProgressIndicator()
                          ),
                      ),
                future: getUser());
          } else {
            return Front();
          }
        },
        future: googleSignIn.isSignedIn(),
      ),
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.black,
      ),
    );
  }
}

// FutureBuilder(
//         initialData: false,
//         builder: (context, snapshot) => snapshot.data ? UI() : Front(),
//         future: googleSignIn.isSignedIn(),
//       ),
//       theme:
//           new ThemeData(primarySwatch: Colors.teal, primaryColor: Colors.black),
