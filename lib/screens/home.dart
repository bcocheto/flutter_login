import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/style/theme.dart' as Theme;
import 'package:login/util/navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;
  String sname;
  String email;

  _HomePageState() {
    getTextFromFile(context).then((val) => setState(() {
          this.name = val['name'];
          this.sname = val['sname'];
          this.email = val['email'];
        }));
  }

  // ignore: missing_return
  Future<Map> getTextFromFile(context) async {
    var user = await FirebaseAuth.instance.currentUser();
    var uid;

    if (user != null) {
      email = user.email;
      uid =
          user.uid; // The user's ID, unique to the Firebase project. Do NOT use
// this value to authenticate with your backend server, if
// you have one. Use User.getToken() instead.
      DocumentSnapshot snapshot =
          await Firestore.instance.collection('users').document('$uid').get();

      if (snapshot.data['name'] != null && snapshot.data['sname'] != null) {
        this.name = snapshot.data['name'];
        this.sname = snapshot.data['sname'];
        this.email = snapshot.data['email'];

        return snapshot.data;
      }
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getTextFromFile(context));
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl =
        'https://cdn.iconscout.com/icon/free/png-256/avatar-372-456324.png';
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Perfil',
            style: TextStyle(fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
          ),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
        ),
        drawer: new Drawer(
            child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('$name $sname'),
              accountEmail: new Text('$email'),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.loginGradientStart,
                      Theme.Colors.loginGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(imgUrl),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Sair',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.grey),
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey,
                ),
                onTap: () {
                  FirebaseNavigator.goToLogin(context);
                },
              ),
            ),
          ],
        )),
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: _height / 12,
                ),
                new CircleAvatar(
                  radius: _width < _height ? _width / 4 : _height / 4,
                  backgroundImage: NetworkImage(imgUrl),
                ),
                new SizedBox(
                  height: _height / 25.0,
                ),
                new Text(
                  '$name $sname',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.white),
                ),
                new Padding(
                  padding: new EdgeInsets.only(
                      top: _height / 30, left: _width / 8, right: _width / 8),
                  child: new Text(
                    'Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                    style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: _width / 25,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Padding(
                  padding:
                      new EdgeInsets.only(left: _width / 8, right: _width / 8),
                  child: new FlatButton(
                    onPressed: () {},
                    child: new Container(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(
                          width: _width / 30,
                        ),
                        new Text('FOLLOW')
                      ],
                    )),
                    color: Colors.blue[50],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
