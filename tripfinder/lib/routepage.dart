import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripfinder/trips.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:tripfinder/user.dart';

import 'boxes.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key, required this.trip}) : super(key: key);

  final Trips trip;

  @override
  State<RoutePage> createState() => _RoutePage(trip);
}

class _RoutePage extends State<RoutePage> {

  static const TextStyle tripTitleStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);

  final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  _RoutePage(this.trip);

  final Trips trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripFinder'),
        backgroundColor: Colors.black,
      ),
      body:
       Stack( children: [
              Text(
                  trip.title,
                  textAlign: TextAlign.left,
                  style: tripTitleStyle
              ),

              MapSample(trip: trip)
            ],
          ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key, required this.trip}) : super(key: key);

  final Trips trip;

  @override
  State<MapSample> createState() => MapSampleState(trip);
}

class MapSampleState extends State<MapSample> {
  StreamSubscription? _locationSubscription;
  StreamSubscription? _camSubscription;
  GoogleMapController? _controller;
  Marker? marker;
  final Location _locationTracker = Location();
  Circle? circle;
  late LatLng _currentLocation;
  late LatLng _destination;

  MapSampleState(this.trip);

  final Trips trip;

  Set<Polyline> route = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(this.context).load("assets/triangle_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    setState(() {
      marker = Marker(
          markerId: const MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: const CircleId("car"),
          radius: newLocalData.accuracy!,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _currentLocation = LatLng(newLocalData.latitude!, newLocalData.longitude!);
          setPolyLines();
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void moveToPosition() async {

    try {
      if (_camSubscription != null) {
        _camSubscription!.cancel();
      }

      _camSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller!.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                  bearing: newLocalData.heading!,
                  target: LatLng((newLocalData.latitude!), newLocalData.longitude!),
                  tilt: 0,
                  zoom: 18.00)));
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void cancelFollow(){
    _camSubscription!.cancel();
  }

  void addTripDone(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;
    var box = Boxes.getUsers();
    List list = box.values.toList();
    for(var i = 0; i < list.length;i++){
      Users? tmp = list[i];
      if(tmp!.email==email) {
        List<Trips> tmp2 = tmp.trips;
        for (var j = 0; j < tmp2.length; j++) {
          if (tmp2[j].id == trip.id) return;
        }
        tmp2.add(trip);
        list[i].trips = tmp2;
        list[i].save();
      }
    }
  }

  void initTripPoints(){
    _currentLocation = LatLng(trip.lat, trip.lng);
    _destination = LatLng(trip.lat, trip.lng);
  }

  @override
  void initState(){

    getCurrentLocation();
    initTripPoints();

    polylinePoints = PolylinePoints();

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Listener(
            onPointerDown: (e) {
              cancelFollow();
            },
            child: GoogleMap(
               mapType: MapType.hybrid,
               initialCameraPosition:  CameraPosition(target: _destination, zoom: 15),
               markers: Set.of((marker != null) ? [marker!] : []),
               circles: Set.of((circle != null) ? [circle!] : []),
               zoomControlsEnabled: false,
               onMapCreated: (GoogleMapController controller) {
                 _controller = controller;
                 setPolyLines();
               },
               polylines: route,
            ),
          ),
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(7.0,0.0,7.0,28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(heroTag: "btn1",child: const Icon(Icons.location_searching), onPressed: () {moveToPosition();}),
              FloatingActionButton(heroTag: "btn2",child: const Icon(Icons.done), onPressed: () {
                addTripDone();
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              }),
              FloatingActionButton(heroTag: "btn3",child: const Icon(Icons.camera_alt_outlined), onPressed: _pictureScreen),
            ]
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void setPolyLines() async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        "AIzaSyDbxG5dtaAYlUwjjNfqUei6CCvSKlTEw44",
        PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
        PointLatLng(_destination.latitude, _destination.longitude));
    route.clear();
    polylineCoordinates = [];
    if(result.status == 'OK'){
      result.points.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        route.add(
            Polyline(
              width: 10,
              polylineId: PolylineId('polyLine'),
              color: Color(0xFF08A5CB),
              points: polylineCoordinates
          )
        );
      });
    }
  }

  _pictureScreen() async {

    final ImagePicker _picker = ImagePicker();

    XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    final file = File(photo!.path);

    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';

    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/$imageName');

    final uploadTask = firebaseStorageRef.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    //uploadImageToFirebase(photo!);

    //Directory dir = await getApplicationDocumentsDirectory();
    //Directory? dir = await getExternalStorageDirectory();
    
    //String path = dir!.path;

    //photo!.saveTo(path);

    //final String fileName = basename(photo!.path); // Filename without extension
    //final String fileExtension = extension(photo.path); // e.g. '.jpg'

    //File tmpFile = File(photo.path);
    //tmpFile = await tmpFile.copy('$path/$fileName$fileExtension');

    DisplayPictureScreen(imagePath: photo.path);
  }

}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TripFinder')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}