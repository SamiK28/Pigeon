import 'package:flutter/material.dart';
import '../main_ui/screen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../UserData/data.dart';
//import 'package:fluttertoast/fluttertoast.dart';

//var groupChatId;

int len1 = 1;
TextEditingController msg = new TextEditingController();

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> listofmessages = new List();
  List<bool> types = new List();

  void method1() async {
    listofmessages.clear();
    types.clear();
    final QuerySnapshot querysnap =
        await Firestore.instance.collection('messages').getDocuments();
    final List<DocumentSnapshot> msgs = querysnap.documents;
    for (int i = 0; i < msgs.length; i++) {
      if (Get().key == msgs[i]["senderId"] && rid == msgs[i]["recieverId"]) {
        types.add(true);
        listofmessages.add(msgs[i]["message"]);
      } else if (rid == msgs[i]["senderId"] &&
          Get().key == msgs[i]["recieverId"]) {
        types.add(false);
        listofmessages.add(msgs[i]["message"]);
      }
    }
  }

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
          wallpaper(query),
          Positioned(
            top: 0.0,
            left: 5.0,
            right: 5.0,
            bottom: 55,
            child: Container(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  method1();
                  return messageview(index, query);
                },
                reverse: true,
              ),
            ),
          ),
          typebox(query),
        ],
      ),
    );
  }

  int giveheight() {
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

  void sendMessage(String recieverid, String message) async {
    _textSubmitted(message);
    Firestore.instance.collection('messages').document().setData({
      "senderId": Get().key,
      "recieverId": recieverid,
      "message": message,
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
    });
    method1();
    setState(() {});
  }


  Widget wallpaper(MediaQueryData query) {
    return Container(
      color: Colors.blueGrey,
      height: query.size.height,
      width: query.size.width,
    );
  }


  Widget messageview(int index, MediaQueryData query) {
    return Column(
      crossAxisAlignment:
          types[index] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment:
              types[index] ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: listofmessages[index].length >= 26
                  ? query.size.width / 1.3
                  : null,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: types[index]
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[
                  listofmessages[index].length >= 26
                      ? Flexible(
                          child: Text(
                            listofmessages[index],
                            maxLines: 100,
                          ),
                        )
                      : Text(listofmessages[index])
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget typebox(MediaQueryData query) {
    return Positioned(
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
                      onSubmitted: _textSubmitted,
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
                onPressed: () => sendMessage(rid, msg.text),
              ),
              backgroundColor: Colors.teal,
              radius: query.size.width / 12,
            ),
          ],
        ),
      ),
    );
  }

Future<Null> _textSubmitted(String value) async {
    msg.clear();
  }

}
