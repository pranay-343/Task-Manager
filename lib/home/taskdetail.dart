import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:task_manager/util/messageText.dart';
import 'LocationMap.dart';
import 'MyMap.dart';
import 'PathMap.dart';

class TaskDetailRoute extends CupertinoPageRoute {
  String taskId;

  TaskDetailRoute(this.taskId)
      : super(builder: (BuildContext context) => new TaskDetailData(taskId));
}

class TaskDetailData extends StatefulWidget {
  String taskId;
  String progressData = "";

  TaskDetailData(this.taskId);

  @override
  _TaskDetail createState() => _TaskDetail(taskId);
}

class _TaskDetail extends State<TaskDetailData> {
  String taskId;
  var checkin_id;
  var checkStatus = false;

  _TaskDetail(this.taskId);

  var dataLoad = false;
  String userid;
  List<CommentCategory> _list = List();
  List<TaskLatLngList> _listTracker = List();
  Timer _timer;
  int _start = 10;
  var starttext = "";
  var startTimetext = "";
  var deadlineText = "";
  var appNameText = "";
  var description = "";
  var task_by;
  var start_time;
  var dead_line_time;
  String StatusDataShow = "";
  var assignByName = "";
  String statusData = "";
  var dataShow = true;
  var taskCheckout = false;
  var track = "";
  TextEditingController reasonController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskDetailData();
  }

  Future<Null> checkIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    setState(() {
      track = "start";
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {
              "user_id": userid,
              "task_id": taskId,
              "check_in_date": "1573291679",
              "in_time": "1573210133"
            };
            Map decoded =
                jsonDecode(await apiMainRequest(checkInUrl, map, context));
            print("-------------task detail screen----------------");
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              _showToast(context, "Start Tracking...");
              var record = decoded['record'];
              taskId = record['task_id'];
              checkin_id = record['checkin_id'];
              if (track == "start") {
                setState(() {
                  taskCheckout = true;
                  StatusDataShow = "Check-In";
                });
                setState(() {
                  checkStatus = true;
                });
                startTimer();
              }
            } else if (status == expireTokenStatus) {
              Map decoded = jsonDecode(await apiRefreshRequest(context));
              checkIn();
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

  Future<Null> checkOut() async {
    setState(() {
      checkStatus = false;
      track = "stop";
    });
    print("-------------checkout detail screen----------------");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {
              "user_id": userid,
              "task_id": taskId,
              "check_out_date": "1573291679",
              "out_time": "1573210133",
              "status": "4"
            };
            print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(checkOutUrl, map, context));
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];

            if (status == "200") {
              _showToast(context, message);
              setState(() {
                StatusDataShow = "Done";
                dataShow = false;
              });
            } else if (status == expireTokenStatus) {
              Map decoded = jsonDecode(await apiRefreshRequest(context));
              checkOut();
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

  Future myPosition() async {
    Position positionCurrent = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(positionCurrent);
    locationTrack(positionCurrent.latitude, positionCurrent.longitude);
  }

  Future<Null> locationTrack(double lat, double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');

    setState(() {});
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
              locationTrack(lat, lng);
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            myPosition();

            setState(() {
              print("---stop------");
              _start = 10;
              if (track == "start") {
                startTimer();
              }
            });
          } else {
            print("---start------");
            _start = _start - 1;
          }
        },
      ),
    );
  }

  Future<Null> taskDetailData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {"task_id": taskId, "page_no": 1};
            Map decoded =
                jsonDecode(await apiMainRequest(detailUrl, map, context));
            print("-------------task detail screen----------------");
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              var record = decoded['record'];
              var task_detail = record['task_detail'];
              var start_date = task_detail['start_date'];
              var dead_line = task_detail['dead_line_date'];
              appNameText = task_detail['task_titile'];
              description = task_detail['description'];
              start_time = task_detail['start_time'];
              dead_line_time = task_detail['dead_line_time'];
              task_by = task_detail['task_by'];
              statusData = task_detail['status'];
              assignByName = task_detail['Task_by_name'];
              /*0=save, 1=assign,2=ongoing,3=reject,4=done
*/
              setState(() {
                if (statusData == "0") {
                  StatusDataShow = "save";
                } else if (statusData == "1") {
                  StatusDataShow = "Assign";
                } else if (statusData == "2") {
                  StatusDataShow = "Ongoing";
                  taskCheckout = true;
                } else if (statusData == "3") {
                  StatusDataShow = "Reject";
                } else if (statusData == "4") {
                  StatusDataShow = "Done";
                  dataShow = false;
                }
              });
              print(dead_line);
              /* var enddate = new DateTime.fromMillisecondsSinceEpoch(
                  int.parse(dead_line) * 1000);
              var startdate = new DateTime.fromMillisecondsSinceEpoch(
                  int.parse(start_date) * 1000);*/
              List dateSplit = start_date.split("-");
              int Year = int.parse(dateSplit[0]);
              int month = int.parse(dateSplit[1]);
              int day = int.parse(dateSplit[2]);
              starttext = day.toString() + "/" + month.toString();
              List dateSplit1 = dead_line.split("-");
              int Yearend = int.parse(dateSplit[0]);
              int monthend = int.parse(dateSplit[1]);
              int dayend = int.parse(dateSplit[2]);
              deadlineText = dayend.toString() + "/" + monthend.toString();
              var all_comments = record['all_comments'];
              _list = all_comments
                  .map<CommentCategory>(
                      (json) => CommentCategory.fromJson(json))
                  .toList();
              setState(() {
                dataLoad = true;
              });
              print(record);
            } else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              taskDetailData();
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

  Future<Null> createComments(String Comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {
              "user_id": userid,
              "task_id": taskId,
              "comment": Comment,
              "comment_to": task_by
            };
            print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(addCommentUrl, map, context));
            print("-------------task detail screen----------------");
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              taskDetailData();
              setState(() {
                reasonController.text = "";
              });

              var record = decoded['record'];
              var task_id = record['task_id'];
              var comment_id = record['comment_id'];
            } else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              createComments(Comment);
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

  Future<Null> trackerPathList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Map map = {"user_id": userid, "task_id": taskId};
            print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(trackerListUrl, map, context));
            print("-------------task detail screen----------------");
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];
            if (status == "200") {
              var record = decoded['record'];
              _listTracker = record
                  .map<TaskLatLngList>((json) => TaskLatLngList.fromJson(json))
                  .toList();
              List<LatLng> latlngSegment1 = List();
              LatLng _lat2;
              LatLng _lat1;
              LatLng _lat3;
              for (int i = 0; i < _listTracker.length; i++) {
                _lat1 = LatLng(22.7244, 75.8839);
                _lat3 = LatLng(22.7533, 75.8937);
//                _lat1 = LatLng( double.tryParse(_listTracker[i].user_lat),  double.tryParse(_listTracker[i].user_long));
                _lat2 = LatLng(22.7339, 75.8499);

//                latlngSegment1.add(_lat1);
                latlngSegment1.add(_lat3);
                latlngSegment1.add(_lat2);
//                _lat2  = LatLng( double.tryParse(_listTracker[i].user_lat),  double.tryParse(_listTracker[i].user_long));
              }
              Navigator.of(context)
                  .push(new PathRouter(latlngSegment1, _lat2, _lat1));
            } else if (status == expireTokenStatus) {
              jsonDecode(await apiRefreshRequest(context));
              trackerPathList();
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
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dataLoad
          ? Container(
              color: Colors.white,
              child: Scaffold(
                appBar: AppBar(
                  leading: new IconButton(
                      icon: new Icon(
                        Icons.arrow_back_ios,
                        color: whiteColour,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  elevation: 0.0,
                  title: Text(
                    "Task Detail",
                    style: TextStyle(color: whiteColour),
                  ),
                  centerTitle: true,
                  backgroundColor: primaryColour,
                ),
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: <Widget>[
                    Container(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      FlatButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    10.0)),
                                        child: Text(StatusDataShow),
                                        onPressed: () async {},
                                        color: dataShow
                                            ? Colors.yellow[100]
                                            : greenColour,
                                        textColor: dataShow
                                            ? Colors.yellow[900]
                                            : whiteColour,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: blackColour,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: primaryColour,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            assignBy,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 2.0),
                                          ),
                                          Text(assignByName)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                dataShow
                                    ? Expanded(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                IconData(0xe900,
                                                    fontFamily: 'checkin'),
                                                color: taskCheckout
                                                    ? blacklightColour
                                                    : greenColour,
                                                size: 40.0,
                                              ),
                                              onPressed: () {
                                                taskCheckout
                                                    ? dataBlanck()
                                                    : checkIn();
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                IconData(0xe900,
                                                    fontFamily: 'checkout'),
                                                color: taskCheckout
                                                    ? redColour
                                                    : blacklightColour,
                                                size: 40.0,
                                              ),
                                              onPressed: () {
                                                taskCheckout
                                                    ? checkOut()
                                                    : dataBlanck();
                                              },
                                            ),
                                          ],
                                        ))
                                    : Text('')
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Text(
                              appNameText,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 10,
                                  child: FlatButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    child: Wrap(
                                      verticalDirection: VerticalDirection.up,
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                        ),
                                        Text(
                                          starttext,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.0),
                                        ),
                                        timeStartWidget(),
                                      ],
                                    ),
                                    onPressed: () {},
                                    color: Colors.black12,
                                    textColor: blackColour,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: blackColour,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: primaryColour,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(''),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: FlatButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    child: Wrap(
                                      verticalDirection: VerticalDirection.up,
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                        ),
                                        Text(
                                          deadlineText,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.0),
                                        ),
                                        timeEndWidget(),
                                      ],
                                    ),
                                    onPressed: () {},
                                    color: Colors.black12,
                                    textColor: blackColour,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: blackColour,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: primaryColour,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Text(description),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.track_changes),
                                        Text(
                                          ' Start Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    )),
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 1,
                                  child: timeShowWidget(),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
/*                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(new MyLocationRouter(taskId, statusData));
//                            trackerPathList();
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Responsible Person',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigation,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),*/

                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                            ),
                            dataList(),
                          ],
                        ),
                      ),
                    )),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: SafeArea(
                        child: Card(
                          elevation: 0.0,
                          color: whiteColour,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                            child: OutlineButton(
                                onPressed: () {},
                                borderSide: BorderSide(
                                    color: primaryColour, width: 2.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 10,
                                        child: new TextField(
                                          controller: reasonController,
                                          maxLines: 1,
                                          style: TextStyle(color: Colors.black),
                                          decoration: new InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              hintText: comment + "*",
                                              suffixStyle: const TextStyle(
                                                  color: Colors.black)),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            if (reasonController.text
                                                    .toString()
                                                    .trim() ==
                                                "") {
                                              _showToast(context,
                                                  "Please add comment");
                                            } else {
                                              createComments(reasonController
                                                  .text
                                                  .toString());
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                            }
                                          },
                                          icon: Icon(Icons.send),
                                        ))
                                  ],
                                ),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0))),

                            /* FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(addcomment),
                      onPressed: () async {
                        dialogShow(context, "", "");
                      },
                      color: primaryColour,
                      textColor: whiteColour,
                      disabledColor: Colors.grey,
                      disabledTextColor: blackColour,
                      padding: EdgeInsets.all(8.0),
                      splashColor: primaryColour,
                    )*/
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }

  Widget dataList() {
    return Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                          child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 0.0, 10.0, 0.0),
                                            child: Row(
                                              children: <Widget>[
                                                new Container(
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          primaryColour,
                                                      child: Text(
                                                        'TD',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: whiteColour),
                                                      ),
                                                      minRadius: 40,
                                                      maxRadius: 40,
                                                    ),
                                                    width: 40.0,
                                                    height: 40.0,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    // borde width
                                                    decoration:
                                                        new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    )),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                ),
                                                Text(
                                                  _list[index].comment_by_name,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: timeShowCommentWidget(
                                            _list[index].comment_on),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        55.0, 0.0, 10.0, 0.0),
                                    child: Text(_list[index].comment),
                                  ),
                                ],
                              ))),
                    ],
                  ));
            }));
  }

  String dialogShow(BuildContext context, String message, String type) {
    TextEditingController reasonController = new TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  OutlineButton(
                      onPressed: () {},
                      borderSide: BorderSide(color: primaryColour, width: 2.0),
                      child: new TextField(
                        controller: reasonController,
                        maxLines: 5,
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: comment + "*",
                            suffixStyle: const TextStyle(color: Colors.black)),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  ButtonTheme(
                    minWidth: double.maxFinite,
                    buttonColor: primaryColour,
                    child: RaisedButton(
                      elevation: 8.0,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColour),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        if (reasonController.text.toString().trim() == "") {
                          _showToast(context, "Please add comment");
                        } else {
                          createComments(reasonController.text.toString());
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        submit,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: double.infinity,
                    // height: double.infinity,
                    child: new OutlineButton(
                        borderSide: BorderSide(color: primaryColour),
                        child: new Text(cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0))),
                  )
                ],
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)));
        });
  }

  timeShowWidget() {
    /*  var date =
        new DateTime.fromMillisecondsSinceEpoch(int.parse(start_time) * 1000);
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
    setState(() {
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
      timeShow = hourData + ":" + minData + " " + data;
    });*/
    return Column(
      children: <Widget>[
        Text(
          'Start Time',
          style: TextStyle(fontSize: 14.0),
        ),
        Text(
          start_time,
          style: TextStyle(fontSize: 14.0),
        )
      ],
    );
  }

  timeStartWidget() {
    /*  var date =
        new DateTime.fromMillisecondsSinceEpoch(int.parse(start_time) * 1000);
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
    setState(() {
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
      timeShow = " " + hourData + ":" + minData + " " + data;
    });*/
    return Column(
      children: <Widget>[
        Text(
          start_time,
          style: TextStyle(fontSize: 14.0),
        )
      ],
    );
  }

  timeEndWidget() {
    /*var date = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(dead_line_time) * 1000);
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
    setState(() {
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
      timeShow = " " + hourData + ":" + minData + " " + data;
    });*/
    return Column(
      children: <Widget>[
        Text(
          dead_line_time,
          style: TextStyle(fontSize: 14.0),
        )
      ],
    );
  }

  timeShowCommentWidget(comment_on) {
    var date =
        new DateTime.fromMillisecondsSinceEpoch(int.parse(comment_on) * 1000);
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
    timeShow = hourData + ":" + minData + " " + data;

    return Text(
      timeShow,
      style: TextStyle(fontSize: 14.0),
    );
  }

  dataBlanck() {}
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

class CommentCategory {
  final String id,
      comment_by,
      comment_by_name,
      comment_by_profile,
      comment_by_profile_thumb,
      comment_to,
      comment_to_name,
      comment,
      comment_on;

  CommentCategory._(
      {this.id,
      this.comment_by,
      this.comment_by_name,
      this.comment_by_profile,
      this.comment_by_profile_thumb,
      this.comment_to,
      this.comment_to_name,
      this.comment,
      this.comment_on});

  factory CommentCategory.fromJson(Map<String, dynamic> json) {
    return new CommentCategory._(
        id: json['id'],
        comment_by: json['comment_by'],
        comment_by_name: json['comment_by_name'],
        comment_by_profile: json['comment_by_profile'],
        comment_by_profile_thumb: json['comment_by_profile_thumb'],
        comment_to: json['comment_to'],
        comment_to_name: json['comment_to_name'],
        comment: json['comment'],
        comment_on: json['comment_on']);
  }
}

class TaskLatLngList {
  final String id,
      task_id,
      user_lat,
      user_long,
      added_on,
      user_id,
      user_name,
      user_profile_img;

  /*        "id": "1",
            "task_id": "1",
            "user_lat": "22.7172939",
            "user_long": "75.8770155",
            "added_on": "1573304840",
            "user_id": "2",
            "user_name": "Abhialsh johri",
            "user_profile_img": ""*/

  TaskLatLngList._({
    this.id,
    this.task_id,
    this.user_lat,
    this.user_long,
    this.added_on,
    this.user_id,
    this.user_name,
    this.user_profile_img,
  });

  factory TaskLatLngList.fromJson(Map<String, dynamic> json) {
    return new TaskLatLngList._(
        id: json['id'],
        task_id: json['task_id'],
        user_lat: json['user_lat'],
        user_long: json['user_long'],
        added_on: json['added_on'],
        user_id: json['user_id'],
        user_name: json['user_name'],
        user_profile_img: json['user_profile_img']);
  }
}
