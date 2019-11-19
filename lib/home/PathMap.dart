
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_manager/util/AppColour.dart';


class PathRouter extends CupertinoPageRoute {
  List<LatLng> latlngSegment1 = List();
  LatLng _lat1,_fisrstLatLng;

  PathRouter(this.latlngSegment1, this._lat1,this._fisrstLatLng)
      : super(
            builder: (BuildContext context) =>
                new MyPath(latlngSegment1, _lat1,_fisrstLatLng));
}

class MyPath extends StatefulWidget {
  List<LatLng> latlngSegment1 = List();
  LatLng _lat1,_fisrstLatLng;

  MyPath(this.latlngSegment1, this._lat1,this._fisrstLatLng);

  @override
  _TestMapPolylineState createState() =>
      _TestMapPolylineState(latlngSegment1, _lat1,_fisrstLatLng);
}

class _TestMapPolylineState extends State<MyPath> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> latlngSegment1 = List();
  GoogleMapController controller;
  List<LatLng> latlngSegment2 = List();
  LatLng _lastMapPosition,_fisrstLatLng;

  _TestMapPolylineState(this.latlngSegment1,this._lastMapPosition,this._fisrstLatLng);

  @override
  void initState() {
    super.initState();
    //line segment 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        centerTitle: true,
        title: Text('Path'),
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: whiteColour,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GoogleMap(
        //that needs a list<Polyline>
        polylines: _polyline,
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Last Position',
          snippet: 'End Point',
        ),
      ));
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_fisrstLatLng.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _fisrstLatLng,
        infoWindow: InfoWindow(
          title: 'First Position',
          snippet: 'Start Point',
        ),
      ));
      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));

      //different sections of polyline can have different colors
      _polyline.add(Polyline(
        polylineId: PolylineId('line2'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment2,
        width: 2,
        color: Colors.red,
      ));
    });
  }
}
