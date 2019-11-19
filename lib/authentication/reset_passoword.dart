import 'dart:convert';
import 'dart:io';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'Login.dart';

//shirsh new

class ResetPasswordPageRouter extends CupertinoPageRoute {
  ResetPasswordPageRouter()
      : super(builder: (BuildContext context) => new ResetPasswordPage());
}

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPasswordPage> {
  TextEditingController passowrdControler = new TextEditingController();
  TextEditingController newpassowrdControler = new TextEditingController();
  TextEditingController confirmpassowrdControler = new TextEditingController();
  bool _obscureText = true;
  bool dataload = true;
  bool passwordVisible = true;
  bool passwordNewVisible = true;
  bool passwordConfirmVisible = true;
  var userId;

  @override
  void initState() {
    // TODO: implement initState
    passwordVisible = true;
    passwordNewVisible = true;
    passwordConfirmVisible = true;
    profileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: whiteColour,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            changePassword,
            style: TextStyle(color: whiteColour, fontSize: 16.0),
          ),
          centerTitle: true,
          backgroundColor: primaryColour,
        ),
        bottomNavigationBar: dataload
            ? Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 2.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 40.0,
                        buttonColor: primaryColour,
                        child: RaisedButton(
                          elevation: 16.0,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColour),
                            borderRadius: BorderRadius.circular(.0),
                          ),
                          onPressed: () async {
                            var password = passowrdControler.text;
                            var newpassword = newpassowrdControler.text;
                            var confirmpassword = confirmpassowrdControler.text;
                            if (passowrdControler.text == "") {
                              _showToast(context, pleaseEnterPassword);
                            } else if (newpassowrdControler.text == "") {
                              _showToast(context, pleaseEnterNewPassword);
                            } else if (confirmpassowrdControler.text == "") {
                              _showToast(context, pleaseEnterConfirmPassword);
                            } else if (newpassowrdControler.text !=
                                confirmpassowrdControler.text) {
                              _showToast(
                                  context, passwordAndConfirmPasswordNotMatch);
                            } else {
                              callUserLogin();
                            }
                          },
                          child: Text(
                            updatePassword,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Text(''),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                    child: new Container(
                      child: TextFormField(
                        controller: passowrdControler,
                        keyboardType: TextInputType.text,
                        obscureText: passwordVisible,
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          labelText: password,
                          hintText: password,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryColour,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                    child: new Container(
                      child: TextFormField(
                        controller: newpassowrdControler,
                        keyboardType: TextInputType.text,
                        obscureText: passwordNewVisible,
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          labelText: enterPass,
                          hintText: enterPass,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordNewVisible state choose the icon
                              passwordNewVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryColour,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordNewVisible = !passwordNewVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                    child: new Container(
                      child: TextFormField(
                        controller: confirmpassowrdControler,
                        keyboardType: TextInputType.text,
                        obscureText: passwordConfirmVisible,
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          labelText: confirmPass,
                          hintText: confirmPass,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordConfirmVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryColour,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordConfirmVisible =
                                    !passwordConfirmVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }

  Future callUserLogin() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showToast(context, "Please wait..");
        _onLoading(context);
      }
    } on SocketException catch (_) {
      _showToast(context, internetConnectionMessage);
    }
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return false;
/*
      return 'Please enter mobile number';
*/
    } else if (!regExp.hasMatch(value)) {
      return false;
/*
      return 'Please enter valid mobile number';
*/
    }
    return true;
  }

  Future profileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid');
    });
  }

  void _onLoading(BuildContext context) {
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
      main(context);
    });
  }

  main(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map map = {
      "user_id": userId,
      "new_password": newpassowrdControler.text,
      "old_password": passowrdControler.text
    };
    print(map);
    print("response");
    Map decoded = jsonDecode(await apiMainRequest(changePasswordUrl, map, context));
    print(decoded);
    String status = decoded['status'];
    String message = decoded['message'];
    if (status == successStatus) {
      _showToast(context, message);
    } else if (status == unauthorizedStatus) {
//      String status = await checkLoginStatus(context);
    } else if (status == expireTokenStatus) {
//      Map decoded = jsonDecode(await apiRefreshRequest(context));
//      main(context, email, password);
    } else {
      _showToast(context, message);
    }
    print(message);
  }
}

Widget _showToast(BuildContext context, String mesage) {
  Fluttertoast.showToast(
      msg: mesage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
