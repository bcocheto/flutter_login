import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';

class FirebaseAuthAppRoutes {
  var routes = <String, WidgetBuilder>{
    "/home": (BuildContext context) => HomePage(),
    "/login": (BuildContext context) => LoginPage(),
  };
}

