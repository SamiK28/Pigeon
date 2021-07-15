import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../UserData/data.dart';
import '../main_ui/screen1.dart';

//Get getdata;
bool check = false;

class Front extends StatefulWidget {
  @override
  _FrontState createState() => _FrontState();
}

class _FrontState extends State<Front> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Image.asset(
                'images/d1.png',
                height: 73.0,
                width: 73.0,
                color: Colors.white,
              ),
              radius: 70,
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
            ),
            check ? welcome() : google(),
          ],
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  Widget google() {
    MediaQueryData queryData = MediaQuery.of(context);
    return RaisedButton(
      onPressed: () => gSignin(),
      child: Container(
        height: queryData.size.height / 11,
        width: queryData.size.width / 1.52,
        child: Row(
         
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
            ),
            Image.asset(
              "images/gvector.png",
              height: queryData.size.height / 18,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27.0),
            ),
            Text(
              'Sign in with Google',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      animationDuration: Duration(seconds: 3),
      highlightElevation: 10.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0)),
    );
  }

  Future<Null> gSignin() async {
    User user1 = await getUser();

    if (user1 != null) {
      
      setState(() {
        check = true;
      });
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user1.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      
      if (documents.length == 0) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user1.uid)
            .set(Get().toJson());
      }
    }
  }

  Widget welcome() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Welcome ${Get().username}',
              style: Theme.of(context).accentTextTheme.headline,
            ),
          ),
          Container(
            height: 30.0,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UI()),
              );
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.navigate_next),
            foregroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
