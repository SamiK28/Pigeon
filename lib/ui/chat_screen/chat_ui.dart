import 'package:flutter/material.dart';
import '../main_ui/screen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../UserData/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

var groupChatId;

int len1 = 1;
TextEditingController msg = new TextEditingController();

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Name'),
        actions: <Widget>[Icon(Icons.more_vert)],
        backgroundColor: Colors.teal,
      ),
      body: new Stack(
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
            height: query.size.height,
            width: query.size.width,
          ),
          // Container(
          //   child: StreamBuilder(
          //     stream: Firestore.instance
          //         .collection('messages')
          //         .document(groupChatId)
          //         .collection(groupChatId)
          //         .orderBy('timestamp', descending: true)
          //         .limit(20)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(
          //             child: CircularProgressIndicator(
          //                 valueColor:
          //                     AlwaysStoppedAnimation<Color>(Colors.teal)));
          //       } else {
          //         listMessage = snapshot.data.documents;
          //         return ListView.builder(
          //           padding: EdgeInsets.all(10.0),
          //           itemBuilder: (context, index) =>
          //               buildItem(index, snapshot.data.documents[index]),
          //           itemCount: snapshot.data.documents.length,
          //           reverse: true,
          //           controller: listScrollController,
          //         );
          //       }
          //     },
          //   ),
          // ),
          Positioned(
            bottom: 1.0,
            left: 3.0,
            child: Container(
              alignment: Alignment.bottomCenter,
              //color: Colors.white,
              height: query.size.height * giveheight() / 10,
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.tag_faces),
                          onPressed: () {},
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          width: query.size.width / 1.9,
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Type a message',
                            ),
                            controller: msg,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.camera),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () => sendMessage(name, id, msg.text),
                    ),
                    backgroundColor: Colors.teal,
                    radius: query.size.width / 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  giveheight() {
    double len = msg.text.length / 20;
    int a = len.toInt();
    if (a > 3) {
      a = 3;
    } else if (a < 1) a = 1;
    setState(() {
      len1 = a;
    });
    return len1;
  }
}

void sendMessage(String recievername, String recieverid, String message) async {
  if (Get().key.hashCode <= recieverid.hashCode) {
    groupChatId = '$Get().key-$recieverid';
  } else {
    groupChatId = '$recieverid-$Get().key';
  }

  var messages = Firestore.instance
      .collection('messages')
      .document(groupChatId)
      .collection(groupChatId)
      .document(DateTime.now().millisecondsSinceEpoch.toString());

  if (message.trim() != '') {
    msg.clear();

    var documentReference = Firestore.instance
        .collection('messages')
        .document(groupChatId)
        .collection(groupChatId)
        .document(DateTime.now().millisecondsSinceEpoch.toString());

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'idFrom': Get().key,
          'idTo': recieverid,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'message': message,
        },
      );
    });
    var listScrollController;
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  } else {
    Fluttertoast.showToast(msg: 'Nothing to send');
  }
}
