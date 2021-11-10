import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'dart:io';
import 'package:camera/camera.dart';

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
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:  const CameraPosition(target: LatLng(40.628189, -8.652676), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: route, 
            
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _doNothing,
          label: const Text('Take Picture'),
          icon: const Icon(Icons.camera_alt_outlined)
        ),
    );
  }

  Future<StatefulWidget> _doNothing() async {

    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    return TakePictureScreen(camera: firstCamera);

  }

}

/// ************************
/// ******* Camera *********
/// ************************
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}