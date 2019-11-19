import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_manager/authentication/registration.dart';
import 'package:task_manager/home/home.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'forgotPassword.dart';

class Login extends StatefulWidget {
  @override
  LoginUser createState() => LoginUser();
}

class LoginUser extends State<Login> {
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passowrdControler = new TextEditingController();
  bool _obscureText = true;
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    dataStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 80.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      welcomeback,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackColour,
                          fontSize: 28.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      signintocontinue,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: blackColour,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 20.0),
              child: new InkWell(
                  onTap: () {},
                  child: new Theme(
                      data: new ThemeData(hintColor: Colors.black87),
                      child: new TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black87),
                        controller: emailControler,
                        decoration: new InputDecoration(
                            hintText: email,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromRGBO(72, 98, 115, 1),
                            ),
                            suffixStyle:
                                const TextStyle(color: Colors.black87)),
                      ))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 40.0),
              child: new InkWell(
                  onTap: () {},
                  child: new Theme(
                      data: new ThemeData(hintColor: Colors.black87),
                      child: new TextField(
                        obscureText: _obscureText,
                        style: TextStyle(color: Colors.black87),
                        controller: passowrdControler,
                        decoration: new InputDecoration(
                            hintText: password,
                            prefixIcon: const Icon(
                              Icons.lock_open,
                              color: Color.fromRGBO(72, 98, 115, 1),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryColour,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                  print(passwordVisible);
                                  if (passwordVisible) {
                                    _obscureText = false;
                                  } else {
                                    _obscureText = true;
                                  }
                                });
                              },
                            )),
                      ))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ButtonTheme(
                      minWidth: 200.0,
                      height: 44.0,
                      buttonColor: primaryColour,
                      child: RaisedButton(
                        elevation: 8.0,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColour),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: () async {
                          var email = emailControler.text;
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(email);
                          /* Navigator.push(context, MaterialPageRoute(builder: (context)=>Country()));*/
                          if (email == "") {
                            _showToast(context, pleaseEnterEmail);
                          } else if (emailValid == false) {
                            _showToast(context, pleaseEnterValidEmail);
                          } else if (passowrdControler.text == "") {
                            _showToast(context, pleaseEnterPassword);
                          }
                         /* else if (passowrdControler.text.length < 5) {
                            _showToast(
                                context, pleaseEnterCorrectLenghtPassword);
                          } */
                          else {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
//                                _showToast(context, "Please wait..");
                                permissionCheckUser();

                                /*   Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));*/
                              }
                            } on SocketException catch (_) {
                              _showToast(context, internetConnectionMessage);
                            }
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Padding(
              padding: EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 2.0),
            ),
            Center(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(new ForgotPasswordPageRoute());
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            )),
            /*  Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black54,
                      height: 36,
                    )),
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.black54),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black54,
                      height: 36,
                    )),
              ),
            ]),
           Padding(
              padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 12.0),
            ),
            Center(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(new RegisterPageRoute());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: primaryColour,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),*/
            Padding(padding: EdgeInsets.only(top: 10.0)),
          ],
        ),
      )),
    );
  }

  Future dataStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('typeScreen', "Login");
  }

  void _onLoading(BuildContext context, String email, String password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // ignore: deprecated_member_use
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset("images/loadder.gif")],
          ),
        ),],
      ),
    );

    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      main(context, email, password);
    });
  }

  main(BuildContext context, String name, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('typeScreen', "Login");
    prefs.setString('authtoken', "");
    prefs.setString('id', "");
    Map map = {
      "email": emailControler.text,
      "password": passowrdControler.text
    };
    print("response");
    Map decoded = jsonDecode(await apiRequest(signinUrl, map, context));
//    print(decoded);
    String status = decoded['status'];
    String message = decoded['message'];

    if (status == "200") {
      var record = decoded['record'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userid', record['id']);
      prefs.setString('full_name', record['full_name']);
      prefs.setString('first_name', record['first_name']);
      prefs.setString('last_name', record['last_name']);
      prefs.setString('email', record['email']);
      prefs.setString('country_code', record['country_code']);
      prefs.setString('phone', record['phone']);
      prefs.setString('department', record['department']);
      prefs.setString('designation', record['designation']);
      prefs.setString('status', record['status']);
      prefs.setString('profile_img', record['profile_img']);
      prefs.setString('profile_img_thumb', record['profile_img_thumb']);
      prefs.setString('typeScreen', "Home");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      _showToast(context, message);
    }
    print(message);
  }

  Future permissionCheckUser() async {
    print("ssssss");
    PermissionStatus permissionStatus = await _getCurrentLocationPermission();
    print(permissionStatus);
    print("=============");
    if (permissionStatus != PermissionStatus.granted ||
        permissionStatus != PermissionStatus.disabled) {
      setState(() {
        openHome();
      });
    } else if (permissionStatus == PermissionStatus.disabled) {
      setState(() {
        openHome();
      });
    } else if (permissionStatus == PermissionStatus.restricted) {
      _showToast(context, "permission restricted");
    } else if (permissionStatus == PermissionStatus.unknown) {
      _showToast(context, "permission unknown");
    } else if (permissionStatus == PermissionStatus.denied) {
      _showToast(context,
          "You denied permission.please open app setting and alow permission");
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
    } else if (permissionStatus == PermissionStatus.disabled) {}
  }

  Future openHome() async {
    print("=============");
     var dataCheck =await Geolocator()
        .isLocationServiceEnabled();
    print(dataCheck);
    if(dataCheck==false){
      checkLocationEnable();
    }else{
    _onLoading(context, emailControler.text, passowrdControler.text);
    }
  }

  void checkLocationEnable() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Please Enable gps')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  width: double.infinity,
                  // height: double.infinity,
                  child: new OutlineButton(
                      borderSide: BorderSide(color: primaryColour),
                      child: new Text(openSetting),
                      onPressed: () {
/*
                        var data = AppSettings.openLocationSettings();
*/
                        Navigator.pop(context);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                )
              ],
            ),
          );
        });
  }
}

Future<PermissionStatus> _getCurrentLocationPermission() async {
  PermissionStatus permission = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationAlways);
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.disabled) {
    Map<PermissionGroup, PermissionStatus> permissionStatus =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.locationAlways]);
    return permissionStatus[PermissionGroup.locationAlways] ??
        PermissionStatus.unknown;
  } else {
    return permission;
  }
}

_showToast(BuildContext context, String mesage) {
  Fluttertoast.showToast(
      msg: mesage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
