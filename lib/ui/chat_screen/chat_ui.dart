import 'package:flutter/material.dart';

int len1 = 1;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _msg = new TextEditingController();

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
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
            height: query.size.height,
            width: query.size.width,
          ),
          Container(
            alignment: Alignment.center,
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
                          controller: _msg,
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
                    onPressed: () => sendMessage(),
                  ),
                  backgroundColor: Colors.teal,
                  radius: query.size.width / 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  giveheight() {
    double len = _msg.text.length / 20;
    int a = len.toInt();
    if (a > 3) {
      a = 3;
    } else if (a < 1) a = 1;
    setState(() {
      len1 = a;
    });
    return len1;
  }

  sendMessage() {



    
  }
}
