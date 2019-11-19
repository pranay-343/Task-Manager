import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/home/MyMap.dart';
import 'package:task_manager/home/home.dart';
import 'dart:io';
import 'dart:async';

import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPageRoute extends CupertinoPageRoute {
  RegisterPageRoute()
      : super(builder: (BuildContext context) => new Registration());
}

class Registration extends StatefulWidget {
  @override
  _registrationUser createState() => _registrationUser();
}

class _registrationUser extends State<Registration> {
  TextEditingController nameControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();
  TextEditingController contactControler = new TextEditingController();
  TextEditingController passowrdControler = new TextEditingController();
  TextEditingController confirmpassowrdControler = new TextEditingController();
  bool _obscureText = true;
  bool _obscureconfirmText = true;
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    confirmpasswordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Scaffold(
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
              'Sign up',
              style: TextStyle(color: whiteColour),
            ),
            centerTitle: true,
            backgroundColor: primaryColour,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 10.0),
                  child: new InkWell(
                      onTap: () {},
                      child: new Theme(
                          data: new ThemeData(hintColor: Colors.black87),
                          child: new TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black87),
                            controller: nameControler,
                            decoration: new InputDecoration(
                                hintText: 'Full Name',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(72, 98, 115, 1),
                                ),
                                suffixStyle:
                                    const TextStyle(color: Colors.black87)),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 10.0),
                  child: new InkWell(
                      onTap: () {},
                      child: new Theme(
                          data: new ThemeData(hintColor: Colors.black87),
                          child: new TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black87),
                            controller: emailControler,
                            decoration: new InputDecoration(
                                hintText: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color.fromRGBO(72, 98, 115, 1),
                                ),
                                suffixStyle:
                                    const TextStyle(color: Colors.black87)),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 10.0),
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
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 10.0),
                  child: new InkWell(
                      onTap: () {},
                      child: new Theme(
                          data: new ThemeData(hintColor: Colors.black87),
                          child: new TextField(
                            obscureText: _obscureconfirmText,
                            style: TextStyle(color: Colors.black87),
                            controller: confirmpassowrdControler,
                            decoration: new InputDecoration(
                                hintText: confirmpassword,
                                prefixIcon: const Icon(
                                  Icons.lock_open,
                                  color: Color.fromRGBO(72, 98, 115, 1),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on confirmpasswordVisible state choose the icon
                                    confirmpasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: primaryColour,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      confirmpasswordVisible = !confirmpasswordVisible;
                                      print(confirmpasswordVisible);
                                      if (confirmpasswordVisible) {
                                        _obscureconfirmText = false;
                                      } else {
                                        _obscureconfirmText = true;
                                      }
                                    });
                                  },
                                )),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 10.0),
                  child: new InkWell(
                      onTap: () {},
                      child: new Theme(
                          data: new ThemeData(hintColor: Colors.black87),
                          child: new TextField(
                            style: TextStyle(color: Colors.black87),
                            controller: contactControler,
                            maxLength: 15,
                            keyboardType: TextInputType.phone,
                            decoration: new InputDecoration(
                                hintText: 'Phone Number',
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Color.fromRGBO(72, 98, 115, 1),
                                ),
                                suffixStyle:
                                    const TextStyle(color: Colors.black87)),
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
                          height: 40.0,
                          buttonColor: primaryColour,
                          child: RaisedButton(
                            elevation: 8.0,
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColour),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () async {
                              /* Navigator.push(context, MaterialPageRoute(builder: (context)=>Country()));*/
                              var name = nameControler.text;
                              var email = emailControler.text;
                              var password = passowrdControler.text;
                              var confirmpassword = confirmpassowrdControler.text;
                              var contact = contactControler.text;
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(email);
                              if (name == "") {
                                _showToast(context, pleaseEnterName);
                              } else if (email == "") {
                                _showToast(context,pleaseEnterEmail);
                              } else if (emailValid == false) {
                                _showToast(context, pleaseEnterValidEmail);
                              }else if (password == "") {
                                _showToast(context, pleaseEnterPassword);
                              } else if (password.length<5) {
                                _showToast(context, pleaseEnterCorrectLenghtPassword);
                              }else if (confirmpassword == "") {
                                _showToast(context, pleaseEnterConfirmPassword);
                              } else if (confirmpassword.length<5) {
                                _showToast(context, pleaseEnterCorrectLenghtPassword);
                              }
                              else if (password!=confirmpassword) {
                                _showToast(context, passwordAndConfirmPasswordNotMatch);
                              }
                              else if (contact == "") {
                                _showToast(
                                    context, pleaseEnterContactNumber);
                              } else if (contact.length<9||contact.length>13) {
                                _showToast(context, pleaseEnterCorrectContactNumber);
                              }   else {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                  /*  _onLoading(context, name, email, contact,
                                        password);*/
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

                                  }
                                } on SocketException catch (_) {
                                  _showToast(context, internetConnectionMessage);

                                }
                              }
                              /*   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));*/
                            },
                            child: Text(
                              'SIGN UP NOW',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 2.0),
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(72, 98, 115, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

void _onLoading(BuildContext context, String name, String email, String contact,
    String password) {
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
    main(context, name, email, contact, password);
  });
}

main(BuildContext context, String name, String email, String contact,
    String password) async {
  Map map = {
    "name": name,
    "email": email,
    "contact": contact,
    "password": password
  };
  print(map);
  print(email);
  print(password);
  Map decoded = jsonDecode(await apiRequest(signinUrl, map,context));
  String status = decoded['status'];
  String message = decoded['message'];

  if (status == "200") {
    String userId = decoded['userId'];
    String username = decoded['username'];
    String contact = decoded['contact'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('userId', userId);
    prefs.setString('username', username);
    prefs.setString('contact', contact);
    print(userId);
    print(contact);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    //after the login REST api call && response code ==200

  } else {}
  print(message);
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
