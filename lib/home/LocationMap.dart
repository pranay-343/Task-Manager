import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyLocationRouter extends CupertinoPageRoute {
  String taskId;
  String statusData;

  MyLocationRouter(this.taskId,this.statusData)
      : super(builder: (BuildContext context) => new MyHome(taskId,statusData));
}

class MyHome extends StatefulWidget {
  String taskId;
  String statusData;

  MyHome(this.taskId,this.statusData);

  @override
  MyHomeState createState() => MyHomeState(taskId,statusData);
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> {
  String taskId;
  String statusData;

  MyHomeState(this.taskId, this.statusData);

  var url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = "http://35.245.186.20/Task-manager/index.php/home/map/" + taskId;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(map),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: whiteColour,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
