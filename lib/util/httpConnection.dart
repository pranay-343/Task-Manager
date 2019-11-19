import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/authentication/Login.dart';
import 'apis.dart';
import 'messageText.dart';

Future<String> apiRequest(String url, Map jsonMap, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set("api_key", "test");
  request.headers.set("app_secret", "test123");
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  List headerData = response.headers['authtoken'];
  if (headerData == null) {
  } else {
    headerData = response.headers['authtoken'];
    prefs.setString('authtoken', headerData[0]);
    print(headerData);
  }
  httpClient.close();
  Map decoded = jsonDecode(reply);
  String status = decoded['status'];
  print(decoded);
  if (status == "201") {
    _showToast(context, alreadyLoginAuthetification);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
  return reply;
}

Future<String> apiMainRequest(
    String url, Map jsonMap, BuildContext context) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authtoken = prefs.getString('authtoken');
  request.headers.set('authtoken', authtoken);
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();

  List headerData = response.headers['authtoken'];
  if (headerData == null) {
  } else {
    headerData = response.headers['authtoken'];
    prefs.setString('authtoken', headerData[0]);
    print(headerData);
  }
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  Map decoded = jsonDecode(reply);
  String status = decoded['status'];
  print(decoded);
  if (status == "401") {
    _showToast(context, alreadyLoginAuthetification);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
  return reply;
}
Future<String> apiRefreshRequest(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId');
  String authtoken = prefs.getString('authtoken');
  print(authtoken);
  Map jsonMap={
    "user_id":userId,
    "oldToken":authtoken
  };
  /**/
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(refreshTokenUrl));
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  List headerData = response.headers['authtoken'];
  print("New Token");
  print(headerData);
  if (headerData == null) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  } else {
    prefs.setString('authtoken', headerData[0]);
  }
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}
void _showToast(BuildContext context, String mesage) {
  Fluttertoast.showToast(
      msg: mesage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
