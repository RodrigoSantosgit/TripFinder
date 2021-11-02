import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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
       Stack( children: [ /*Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [*/
              Text(
                  trip.title,
                  textAlign: TextAlign.left,
                  style: tripTitleStyle
              ),
              //const Text("Mapa: TODO"),

              const MapSample()
            ],
          ),
       // ),
      //),
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
          ),
        ),
    );
  }

}