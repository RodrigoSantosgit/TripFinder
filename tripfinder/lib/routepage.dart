import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripfinder/trips.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:location/location.dart';
import 'package:camera/camera.dart';

import 'camerapage.dart';

List<CameraDescription> cameras = [];

final Set<Polyline> route = <Polyline>{
  const Polyline(
      polylineId: PolylineId("poly"),
      color: Colors.blue,
      points: <LatLng>[LatLng(40.644330, -8.656687), LatLng(40.642702, -8.655329), LatLng(40.641436, -8.655139), LatLng(40.641257, -8.653307), LatLng(40.641515, -8.650096), LatLng(40.639584, -8.645558)]
    ),
};

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

              const MapSample()
            ],
          ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  StreamSubscription? _locationSubscription;
  GoogleMapController? _controller;
  Marker? marker;
  final Location _locationTracker = Location();
  Circle? circle;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
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
          _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition:  const CameraPosition(target: LatLng(40.641696, -8.649772), zoom: 15),
            markers: Set.of((marker != null) ? [marker!] : []),
            circles: Set.of((circle != null) ? [circle!] : []),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            polylines: route, 
            
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }
      ),
      persistentFooterButtons: [TextButton(onPressed: _pictureScreen, child: const Text("Take a Picture!"))],
    );
  }

  Future<StatefulWidget> _pictureScreen() async {

    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    cameras = await availableCameras(); 

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    
    return TakePictureScreen(camera: firstCamera);
  }

}

/*class CameraApp extends StatefulWidget {
  @override

  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}*/