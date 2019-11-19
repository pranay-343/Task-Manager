import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/home/MyMap.dart';
import 'package:task_manager/home/home.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/util/AppColour.dart';
import 'Login.dart';
import 'registration.dart';
import 'dart:io';

//shirsh new
class ForgotPasswordPageRoute extends CupertinoPageRoute {
  ForgotPasswordPageRoute()
      : super(builder: (BuildContext context) => new ForgotPassword());
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordUser createState() => _ForgotPasswordUser();
}

class _ForgotPasswordUser extends State<ForgotPassword> {
  TextEditingController emailControler = new TextEditingController();

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
          'Forgot Passowrd',
          style: TextStyle(color: whiteColour),
        ),
        centerTitle: true,
        backgroundColor: primaryColour,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(22.0, 25.0, 22.0, 20.0),
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
                          var email = emailControler.text;
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(email);
                          if (emailControler.text == "") {
                            _showToast(context, pleaseEnterEmail);
                          } else if (emailValid == false) {
                            _showToast(context, pleaseEnterValidEmail);
                          } else {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
//                                _showToast(context, "Please wait..");
                                _onLoading(context, emailControler.text);
                              }
                            } on SocketException catch (_) {
                              _showToast(context, internetConnectionMessage);
                            }
                          }
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(fontSize: 16.0, color: whiteColour),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

void _onLoading(BuildContext context, String email) {
  showDialog(
    context: context,
    barrierDismissible: false,
    // ignore: deprecated_member_use
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset("images/loadder.gif")],
          ),
        ),
      ],
    ),
  );

  new Future.delayed(new Duration(seconds: 3), () {
    Navigator.pop(context); //pop dialog
    main(context, email);
  });
}

main(BuildContext context, String email) async {
  Map map = {
    "email": email,
  };
  print("response");
  Map decoded = jsonDecode(await apiRequest(forgotPasswordUrl, map, context));
  print(decoded);
  String status = decoded['status'];
  String message = decoded['message'];

  if (status == "200") {
    _showToast(context, message);
  } else {
    _showToast(context, message);
  }
  print(message);
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
