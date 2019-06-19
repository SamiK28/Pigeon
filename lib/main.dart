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
      debugShowCheckedModeBanner: false,
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
                    : Material(
                        color: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: CircularProgressIndicator(
                                  semanticsLabel: "Loading...",
                                  strokeWidth: 3.0,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Text(
                                "Loading...",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
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
