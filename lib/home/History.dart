import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/authentication/Login.dart';
import 'package:task_manager/authentication/reset_passoword.dart';
import 'package:task_manager/home/taskdetail.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:task_manager/util/messageText.dart';

import 'LocationMap.dart';

class HistoryPageRoute extends CupertinoPageRoute {
  HistoryPageRoute() : super(builder: (BuildContext context) => new History());
}

class History extends StatefulWidget {
  @override
  _History createState() => _History();
}

class _History extends State<History> {
  List<RecordCategory> _list = List();
  var dataLoad = false;
  var datanotFound = false;
  String userid, fullname, email;

  @override
  void initState() {
    super.initState();
    dashboardData("");
  }

  Future<Null> dashboardData(data) async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime open = dateFormat.parse("10:30");
    open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);
    DateTime close = dateFormat.parse("15:30");
    print("---------time-------------");
    print(open.difference(close).inHours);
    print("--------------------------");
    _list.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    fullname = prefs.getString('full_name');
    email = prefs.getString('email');

    setState(() {});
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {"user_id": userid, "start_date": data.toString()};
            print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(taskUrl, map, context));
            print("-------------home screen----------------");
            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              var record = decoded['record'];
              _list = record
                  .map<RecordCategory>((json) => RecordCategory.fromJson(json))
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
            } else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              dashboardData(data);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
          history,
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
    );
  }

  Widget dataList() {
    return datanotFound
        ? Center(child: Image.asset("images/nodatasfound.png"))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return allHistory(_list,index);

            });
  }

  timeShowWidget(index) {
    /*  var in_time = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(_list[index].time_diff));
      var start = DateTime.parse(callStart);
    var end = DateTime.parse(callEnd);
    var diff = end.difference(start);
    var amountOfTime = diff.toString();*/
    /*  var data = "";
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
          'Total Time',
          style: TextStyle(fontSize: 14.0),
        ),
        dataTextSet(index),

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

  dataTextSet(index) {
    String time="";
    time=_list[index].time_diff.toString();
    if(time==""){
      time="0 second(s)";
    }
    return Text(
      time,
      style: TextStyle(fontSize: 14.0),
    );
  }

  Widget allHistory(_list,index) {
    if(_list[index].status=="4"){
      return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: GestureDetector(
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
                              flex: 3,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          timeShowWidget(index),
                                          Padding(padding: EdgeInsets.only(left: 20.0),),
                                          FloatingActionButton(
                                              heroTag: index.toString(),
                                              backgroundColor: whiteColour,
                                              onPressed: (){
                                                Navigator.of(context).push(
                                                    new MyLocationRouter(
                                                        _list[index].id,
                                                        _list[index]
                                                            .task_titile));
                                              },
                                              child:  Icon(
                                                Icons.navigation,
                                                color: Colors.green,
                                              )
                                          )

                                        ],
                                      ))),
                            )
                          ],
                        ),
                      ],
                    ))),
            onTap: () {
              Navigator.of(context)
                  .push(new TaskDetailRoute(_list[index].id));
            },
          ));
    }else{
     return SizedBox.shrink();
    }

  }
}

class RecordCategory {
   var id,
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
      in_time,
      out_time,
      priority,
      time_diff;


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
    this.in_time,
    this.out_time,
    this.priority,
    this.time_diff,
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
      in_time: json['in_time'],
      out_time: json['out_time'],
      priority: json['priority'],
      time_diff: json['time_diff'],
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
