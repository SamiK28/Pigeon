import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../chat_screen/chat_ui.dart';
import '../../UserData/data.dart';
import '../front_screen/front.dart';
import './camera_screen.dart';
import './screen2.dart';

String rid, rname, rpurl;

Chat chat = new Chat();

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.camera)),
              //Tab(icon: Icon(Icons.location_on),)
            ],
          ),
          title: Text('Pigeon'),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
            new Container(width: 20.0)
          ],
          backgroundColor: Colors.black87,
        ),
        body: new TabBarView(
          children: [
            
            appinterface(),
            //Maps(),
            //Arcore(),
            Cam(),
            
            
            
            
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(Get().username),
                accountEmail: Text(Get().emailid),
                currentAccountPicture: Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(Get().photourl)),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      tileMode: TileMode.repeated,
                      colors: [Colors.grey, Colors.teal]),
                ), // ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Log Out',
                  style: Theme.of(context)
                      .accentTextTheme
                      .body2
                      .apply(color: Colors.grey.shade700),
                ),
                onTap: () {
                  setState(() {
                    googleSignIn.signOut();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Front()),
                  );
                },
              ),
              new Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget appinterface() {

  return new Stack(
    children: <Widget>[
      Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: RefreshProgressIndicator(),
              );
            } else {

              List users = snapshot.data.documents;
              users.removeWhere((i) => Get().key == i["id"]);
              print(users[0]);
              return ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:users[index]['name'].toString()!='Pigeon Bot'?
                                NetworkImage(users[index]['photourl']):AssetImage('images/d2.png')
                          ),
                          title: Text(users[index]['name']),
                          subtitle: Text(users[index]['email']),
                          onTap: () {
                            //name=users[index]['name'];
                            rid = users[index]['id'];
                            rname = users[index]['name'];
                            rpurl = users[index]['photourl'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Chat();
                              }),
                            );
                          },
                        ),
                        Divider(),
                      ],
                    );
                  });
            }
          },
        ),
      ),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.teal,
          child: Icon(Icons.message),
        ),
      ),
    ],
  );
}
