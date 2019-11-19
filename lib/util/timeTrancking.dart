import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';
import 'httpConnection.dart';
import 'messageText.dart';
Timer _timer;
int _start = 10;
var track = "";

Future startTimer(context,taskId) {
  print("-----------");
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
        (Timer timer) =>
          () {
        if (_start < 1) {
          timer.cancel();
          myPosition(context,taskId);


            print("---stop------");
            _start = 10;
            if (track == "start") {
              startTimer(context,taskId);
            }

        } else {
          print("---start------");
          _start = _start - 1;
        }
      },
  );
}
Future myPosition(context,taskId) async {
  Position positionCurrent = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  print(positionCurrent);
  locationTrack(positionCurrent.latitude, positionCurrent.longitude,context,taskId);
}
Future<Null> locationTrack(double lat, double lng,context,taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString('userid');

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Map map = {
            "user_id": userid,
            "task_id": taskId,
            "user_lat": lat.toString(),
            "user_long": lng.toString()
          };
          Map decoded =
          jsonDecode(await apiMainRequest(taskTrackerUrl, map, context));
          print("-------------task detail screen----------------");
//            print(decoded);
          String status = decoded['status'];
          String message = decoded['message'];
          if (status == "200") {
//              _showToast(context, status);
//              _showToast(context, lat.toString() + " " + lng.toString());
          } else if (status == expireTokenStatus) {
            Map decoded = jsonDecode(await apiRefreshRequest(context));
            locationTrack(lat, lng,context,taskId);
          } else {
            _showToast(context, message);
          }
        }
      } on SocketException catch (_) {
        _showToast(context, internetConnectionMessage);
      }
    }
  } on SocketException catch (_) {
    _showToast(context, internetConnectionMessage);
  }
}
void _showToast(BuildContext context, String mesage) {
  Fluttertoast.showToast(
      msg: mesage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
