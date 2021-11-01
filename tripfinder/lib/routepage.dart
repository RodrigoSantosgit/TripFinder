import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';

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
       Center( child: Padding(
      padding: const EdgeInsets.all(20.0),
        child: Column(
            children: [
              Text(
                  trip.title,
                  textAlign: TextAlign.left,
                  style: tripTitleStyle
              ),
              const Text("Mapa: TODO"),
            ],
          ),
        ),
      ),
    );
  }
}