import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/authentication/Login.dart';
import 'package:task_manager/authentication/reset_passoword.dart';
import 'package:task_manager/home/taskdetail.dart';
import 'package:task_manager/home/userdetail.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/Calendar.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:task_manager/util/messageText.dart';

import 'History.dart';

class Home extends StatefulWidget {
  @override
  _HomelUser createState() => _HomelUser();
}

class _HomelUser extends State<Home> {
  List<RecordCategory> _list = List();
  List<AllRecordCategory> _list_all_record = List();

  void _handleNewDate(date) {
    print(date);
//    DateTime todayDate = DateTime.parse(date);
    setState(() {
      print("----------");
      dashboardData(date);
    });

  }

/*
  List _selectedEvents=List();
*/
/*
  DateTime _selectedDay;
*/
  var dataLoad = false;
  var datanotFound = false;
  Map _events = {};
  String userid="", fullname="", emailText="";
  var now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    print("-----------------");
    print(now.toUtc());
    print("-------time-----");
    dashboardData(now.toUtc());
/*
    _selectedEvents = _events[_selectedDay] ?? [];
*/
  }

  Future<Null> dashboardData(data) async {
    _list.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    fullname = prefs.getString('full_name');
    emailText = prefs.getString('email');

    setState(() {});
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {"user_id": userid,"start_date":data.toString()};
            print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(taskUrl, map, context));
            print("-------------home screen----------------");
            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              var record = decoded['record'];
              var allrecord = decoded['dates'];
              _list = record
                  .map<RecordCategory>((json) => RecordCategory.fromJson(json))
                  .toList();
              _list_all_record = allrecord
                  .map<AllRecordCategory>((json) => AllRecordCategory.fromJson(json))
                  .toList();
              setState(() {
                if (_list.length == 0) {
                  datanotFound = true;
                  dataLoad = true;
                } else {
                  datanotFound = false;
                  dataLoad = true;
                }
              });
              print(record);
            }
            else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              dashboardData(data);
            }
            else {
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

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Task Detail",
              style: TextStyle(color: whiteColour),
            ),
            centerTitle: true,
            backgroundColor: primaryColour,
          ),
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   title: Text('Calendario'),
          // ),
          body: SafeArea(
            child: dataLoad
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        calendarData(),
//                  _buildEventList(),
                        dataList(),
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
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                GestureDetector(
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: primaryColour,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              fullname,
                              style:
                                  TextStyle(color: whiteColour, fontSize: 16.0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                            ),
                            Text(
                              emailText,
                              style:
                                  TextStyle(color: whiteColour, fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(new UserDetailRoute());
                  },
                ),
                histroy(),
                changePassowrd(),
                logOut(),
              ],
            ),
          ),
        ));
  }

  Widget calendarData() {
    Map map;
    for (int i = 0; i < _list_all_record.length; i++) {
   /*   var date = new DateTime.fromMillisecondsSinceEpoch(
          int.parse(_list_all_record[i].start_date) * 1000);*/
      print("----------------dateFormat--------------------");
      print(_list_all_record[i].start_date);
      List dateSplit=_list_all_record[i].start_date.split("-");
      int Year=int.parse(dateSplit[0]);
      int month=int.parse(dateSplit[1]);
      int day=int.parse(dateSplit[2]);
      print(dateSplit[0]);
      print(dateSplit[1]);
      print(dateSplit[2]);
      print(dateSplit);
      map = {
        DateTime(Year, month, day): [
          {'name': 'Event A', 'isDone': true},
        ],
      };
      _events.addAll(map);
    }

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new OutlineButton(
          borderSide: BorderSide(color: primaryColour),
          child: Calendar(
              events: _events,
              onRangeSelected: (range) =>
                  print("Range is ${range.from}, ${range.to}"),
              onDateSelected: (date) => _handleNewDate(date),
              isExpandable: true,
              showTodayIcon: true,
              eventDoneColor: Colors.green,
              eventColor: Colors.grey),
          onPressed: () {},
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0))),
    ));
  }

  Widget dataList() {
    return datanotFound
        ? Center(child: Image.asset("images/nodatasfound.png"))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(new TaskDetailRoute(_list[index].id));
                    },
                    child: Card(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: new Container(
                                            child: Icon(
                                              Icons.adjust,
                                              color: Colors.green,
                                            ),
                                            width: 60.0,
                                            height: 60.0,
                                            padding: const EdgeInsets.all(2.0),
                                            // borde width
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            _list[index].task_titile,
                                            style: TextStyle(fontSize: 14.0),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 22.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              timeShowWidget(index),
                                              Icon(
                                                Icons.watch_later,
                                                color: Colors.green,
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            )))),
              );
            });
  }

  timeShowWidget(index) {
/*    var date = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(_list[index].start_time) * 1000);
    var data = "";
    print(date.runtimeType.toString());
    int Time;
    int total;
    String timeShow;
    Time = int.parse(date.hour.toString());
    if (Time > 12) {
      total = Time - 12;
      data = "PM";
    } else if (Time == 12) {
      total = Time;
      data = "PM";
    } else {
      data = "AM";
      total = Time;
    }

    String hourData;
    String minData;
    if (total < 10) {
      hourData = "0" + total.toString();
    } else {
      hourData = total.toString();
    }
    if (date.minute < 10) {
      minData = "0" + date.minute.toString();
    } else {
      minData = date.minute.toString();
    }
    timeShow = hourData + ":" + minData + " " + data;*/
    return Column(
      children: <Widget>[
        Text(
          'Start Time',
          style: TextStyle(fontSize: 14.0),
        ),
        Text(
          _list[index].start_time,
          style: TextStyle(fontSize: 14.0),
        )
      ],
    );
  }

  Widget histroy() {
    return Container(
      height: 45.0,
      alignment: Alignment.centerLeft,
      color: whiteColour,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new HistoryPageRoute());
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.history,
                          size: 25.0, color: primaryColour)),
                  Expanded(
                      flex: 5,
                      child: Text(history,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: blackColour,
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget changePassowrd() {
    return Container(
      height: 45.0,
      alignment: Alignment.centerLeft,
      color: whiteColour,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new ResetPasswordPageRouter());
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.lock_outline,
                          size: 25.0, color: primaryColour)),
                  Expanded(
                      flex: 5,
                      child: Text(changePassword,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: blackColour,
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logOut() {
    return Container(
      height: 45.0,
      alignment: Alignment.centerLeft,
      color: whiteColour,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                logoutApp();
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.power_settings_new,
                          size: 25.0, color: primaryColour)),
                  Expanded(
                      flex: 5,
                      child: Text(loggout,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: blackColour,
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future logoutApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}

class RecordCategory {
  final String id,
      task_by,
      task_titile,
      description,
      task_category,
      images,
      special_note,
      assign_to,
      start_date,
      start_time,
      dead_line,
      status,
      priority;

  RecordCategory._({
    this.task_by,
    this.id,
    this.task_titile,
    this.task_category,
    this.description,
    this.images,
    this.special_note,
    this.assign_to,
    this.start_date,
    this.start_time,
    this.dead_line,
    this.status,
    this.priority,
  });

  factory RecordCategory.fromJson(Map<String, dynamic> json) {
    return new RecordCategory._(
        id: json['id'],
        task_by: json['task_by'],
        task_titile: json['task_titile'],
        task_category: json['task_category'],
        description: json['description'],
        images: json['images'],
        special_note: json['special_note'],
        assign_to: json['assign_to'],
        start_date: json['start_date'],
        start_time: json['start_time'],
        dead_line: json['dead_line'],
        status: json['status'],
        priority: json['priority']);
  }
}


class AllRecordCategory {
  final String start_date,
      dead_line_date;

  AllRecordCategory._({
    this.start_date,
    this.dead_line_date,
  });

  factory AllRecordCategory.fromJson(Map<String, dynamic> json) {
    return new AllRecordCategory._(
        start_date: json['start_date'],
        dead_line_date: json['dead_line_date']
    );
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
