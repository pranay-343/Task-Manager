import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/messageText.dart';
import 'authentication/Login.dart';
import 'home/home.dart';

Future main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: email == null ? MyApp() : Home(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new Login()
      },
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<MyApp> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  bool _visible = true;

  void navigationPage() {
    setState(() {
      _visible = !_visible;
    });
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    });
  }

  @override
   initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        color: primaryColour,
        child: Center(
          child: SingleChildScrollView(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  AnimatedOpacity(
                    // If the widget is visible, animate to 0.0 (invisible).
                    // If the widget is hidden, animate to 1.0 (fully visible).
                    opacity: _visible ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 2000),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: Text(
                      appName,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
