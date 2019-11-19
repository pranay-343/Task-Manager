import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/util/messageText.dart' as prefix0;

class UserDetailRoute extends CupertinoPageRoute {
  UserDetailRoute()
      : super(builder: (BuildContext context) => new UserDetail());
}

class UserDetail extends StatefulWidget {
  @override
  _UserDetailUser createState() => _UserDetailUser();
}

class _UserDetailUser extends State<UserDetail> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController birthdayController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();
  TextEditingController joiningdatetController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  String userId, userImage;
  DateTime selectedDate = DateTime.now();
  var dataload = false;

  @override
  void initState() {
    super.initState();
    userDetail();
  }

  Future<Null> userDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid');
      userImage = prefs.getString('profile_img');
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {"user_id": userId,"start_date":"1546300800"};
            Map decoded =
                jsonDecode(await apiMainRequest(profileUrl, map, context));
            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              var record = decoded['record'];
              var full_name = record['full_name'];
              var email = record['email'];
              var contact_no = record['phone'];
              var joining_date = record['joining_date'];
              /* "id": "1",
            "first_name": "Sukhdev",
            "last_name": "Pawar",
            "full_name": "Sukhdev Pawar",
            "country_code": "",
            "phone": "79860022",
            "email": "sukhdev@gmail.com",
            "password": "e10adc3949ba59abbe56e057f20f883e",
            "md_5": "123456",
            "profile_img": "",
            "document_name": "",
            "document_no": "",
            "document_front": "",
            "document_back": "",
            "added_by": "",
            "added_on": "1573132052",
            "update_by": "",
            "update_on": "1573134997",
            "last_login": "",
            "login_ip": "",
            "department": "",
            "designation": "1",
            "hiring_date": "",
            "joining_date": "",
            "work_hour": "16",
            "status": "1",
            "user_type": "3",
            "forgot_pass_link": ""*/
              setState(() {
                nameController.text = full_name;
                emailController.text = email;
                contactNumberController.text = contact_no;
                joiningdatetController.text = joining_date;
              });
              print(record);
              setState(() {
                dataload = true;
              });
              print(record);
            }
            else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              userDetail();
            }
            else{
              _showToast(context, message);
            }
          }
        } on SocketException catch (_) {
          _showToast(context, internetConnectionMessage);
        }
      }
    } on SocketException catch (_) {
      dataload = true;
      _showToast(context, internetConnectionMessage);
    }
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
              profile,
              style: TextStyle(color: whiteColour, fontSize: 16.0),
            ),
            centerTitle: true,
            backgroundColor: primaryColour,
          ),
          backgroundColor: Colors.transparent,
          body: dataload
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
                        child: new Container(
                          child: new TextFormField(
                            readOnly: true,
                            controller: nameController,
                            decoration: new InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "name cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: new Container(
                          child: new TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: new InputDecoration(
                              labelText: "Email",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: new Container(
                          child: new TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: contactNumberController,
                            decoration: new InputDecoration(
                              labelText: "Contact Number",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: new Container(
                          child: new TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: joiningdatetController,
                            decoration: new InputDecoration(
                              labelText: "Joining Date",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22.0, 30.0, 22.0, 2.0),
                      ),
                    ],
                  ),
                )
              : Container(
            color: whiteColour,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Image.asset("images/loadder.gif")],
              ),
            ),
          ),
          /*   bottomNavigationBar: dataload
              ? Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 2.0),
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
                              try {
                                final result = await InternetAddress.lookup(
                                    'google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  _onLoading(context, userId);
                                }
                              } on SocketException catch (_) {
                                _showToast(
                                    context, internetConnectionMessage);
                              }
*/ /*                              var name = nameController.text;
                              var email = emailController.text;
                              var birthday = birthdayController.text;
                              var gender = genderController.text;
                              var contact = contactNumberController.text;
                              var address = addressController.text;

                              print(contact);
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(email);
                              if (name == "") {
                                _showToast(context, please_enter_name);
                              } else if (email == "") {
                                _showToast(context, please_enter_email);
                              } else if (emailValid == false) {
                                _showToast(context, please_enter_valid_email);
                              } else if (birthday == "") {
                                _showToast(context, please_enter_birthday_date);
                              } else if (gender == "") {
                                _showToast(context, please_enter_gender);
                              } else if (contact == "") {
                                _showToast(
                                    context, please_enter_contact_number);
                              } else if (contact.length < 9 ||
                                  contact.length > 13) {
                                _showToast(context,
                                    please_enter_correct_contact_number);
                              } else if (address == "") {
                                _showToast(context, please_enter_address);
                              } else if (departmentController.text == "") {
                                _showToast(context, please_enter_department);
                              } else {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    _onLoading(context, userId);
                                  }
                                } on SocketException catch (_) {
                                  _showToast(
                                      context, internet_connection_mesage);
                                }
                              }*/ /*
                            },
                            child: Text(
                              save,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Text(''),*/
        ),
      ),
    );
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
