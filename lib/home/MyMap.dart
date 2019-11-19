import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_manager/util/AppColour.dart';
import 'package:task_manager/util/apis.dart';
import 'package:task_manager/util/httpConnection.dart';
import 'package:task_manager/util/messageText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeRouter extends CupertinoPageRoute {
  String taskId;
  String statusData;

  MyHomeRouter(this.taskId,this.statusData)
      : super(builder: (BuildContext context) => new MyHome(taskId,statusData));
}

class MyHome extends StatefulWidget {
  String taskId;
  String statusData;

  MyHome(this.taskId,this.statusData);

  @override
  MyHomeState createState() => MyHomeState(taskId,statusData);
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> {
  String taskId;
  String statusData;

  MyHomeState(this.taskId,this.statusData);

  final Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Position positionCurrent;
  LatLng _lastMapPosition, _latlongSearchLocationPosition;
  String currentl = "", destinationl = "";
  GoogleMapController controller, searchcontroller;
  String userid;
  var task_id;
  var checkin_id;
  Timer _timer;
  int _start = 10;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  var location = false;
  var track = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  Future _getLocation() async {
    var geoLocator = Geolocator();
    var status = await geoLocator.checkGeolocationPermissionStatus();

    if (status == GeolocationStatus.denied) {
      // Take user to permission settings
      _showToast(context, "Please enable Location");
    } else if (status == GeolocationStatus.disabled) {
      // Take user to location page
      _showToast(context, "Please enable Location");
    } else if (status == GeolocationStatus.restricted) {
      // Restricted
      _showToast(context, "Please enable Location");
    } else if (status == GeolocationStatus.unknown) {
      // Unknown
      _showToast(context, "Please enable Location");
    } else if (status == GeolocationStatus.granted) {
      // Permission granted and location enabled
      positionCurrent = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print(positionCurrent);
      setState(() {
        currentl = positionCurrent.latitude.toString() +
            " , " +
            positionCurrent.longitude.toString();
        _lastMapPosition =
            LatLng(positionCurrent.latitude, positionCurrent.longitude);
        print(_lastMapPosition);
        location = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(map),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: whiteColour,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
  /*    floatingActionButton:
           Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(28.0, 0.0, 0.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      heroTag: "1",
                      backgroundColor: primaryColour,
                      onPressed: () {
                        checkIn();
                      },
                      label: Text(checkin),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 14.0),
                    ),
                    FloatingActionButton.extended(
                      heroTag: "2",
                      backgroundColor: primaryColour,
                      onPressed: () {
                        checkOut();
                      },
                      label: Text(checkout),
                    ),

                  ],
                ),
              )),
          *//*  Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: "navigation",
              onPressed: () {
                if (destinationl == "") {
                  _showToast(context, please_select_destination);
                } else {
                  openMapUrl();
                }
              },
              child: Icon(Icons.navigation),
            ),
          ),*//*
        ],
      ),*/
      body: location
          ? Stack(children: <Widget>[
              GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _lastMapPosition,
                  zoom: 11.0,
                ),
              ),
            ])
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

  Future<Null> checkIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');
    setState(() {
      track="start";
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
              var record = decoded['record'];
              task_id = record['task_id'];
              checkin_id = record['checkin_id'];
              print("---------------checkin_id---------------------");
              print(checkin_id);
              if (track == "start") {
                startTimer();
              }
            }
            else if (status == expireTokenStatus) {
              Map decoded = jsonDecode(await apiRefreshRequest(context));
              checkIn();
            }else {
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
      track="stop";
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
            Map map = {"user_id": userid,"task_id":taskId,"check_out_date":"1573291679","out_time":"1573210133","checkin_id":checkin_id,"status":statusData};
           print(map);
            Map decoded =
                jsonDecode(await apiMainRequest(checkOutUrl, map, context));
//            print(decoded);
            String status = decoded['status'];
            String message = decoded['message'];

            if (status == "200") {
              _showToast(context, message);
            }
            else if (status == expireTokenStatus) {
              Map decoded = jsonDecode(await apiRefreshRequest(context));
              checkOut();
            }else {
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
              _showToast(context, lat.toString() + " " + lng.toString());
            }  else if (status == expireTokenStatus) {
              Map decoded = jsonDecode(await apiRefreshRequest(context));
              locationTrack(lat,lng);
            }else {
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

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));
    });
    setState(() {
      searchcontroller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_latlongSearchLocationPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _latlongSearchLocationPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future myPosition() async {
    Position positionCurrent = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(positionCurrent);
    locationTrack(positionCurrent.latitude, positionCurrent.longitude);
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
