// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripfinder/routepage.dart';
import 'package:tripfinder/tripgallery.dart';
import 'package:tripfinder/trips.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key, required this.trip}) : super(key: key);

  final Trips trip;

  @override
  State<TripPage> createState() => _TripPage(trip);
}

class _TripPage extends State<TripPage> {

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
      TextStyle(fontSize: 15, color: Colors.black);

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15),
      primary: Colors.blue, onPrimary: Colors.white);

  _TripPage(this.trip);

  final Trips trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripFinder'),
        backgroundColor: Colors.black,
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(trip.title, style: optionStyle, textAlign: TextAlign.center),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.topCenter,
                          image: NetworkImage(trip.imageurl))),
                ),
              ),

              Text(trip.contentFull, style: contentStyle, textAlign: TextAlign.center),

              const SizedBox(height: 30),
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutePage(trip: trip),
                  ),
              );
                },
                child: const Text(' Start Trip '),
              ),

              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripGallery(trip: trip),
                  ),
              );
                },
                child: const Text(' Trip Gallery '),
              ),

            ]
          ),
      )
    ),
    );
  }
}