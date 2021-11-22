// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TripGallery extends StatefulWidget {
  const TripGallery({Key? key, required this.trip}) : super(key: key);

  final Trips trip;

  @override
  State<TripGallery> createState() => _TripGallery(trip);
}

class _TripGallery extends State<TripGallery> {

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
      TextStyle(fontSize: 15, color: Colors.black);

  _TripGallery(this.trip);

  final Trips trip;

  late final List tripimages = _listAll();

  List _listAll() {

    List images = [];
    final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('images/${trip.id}');

    // [START storage_list_all]
    // Create a reference under which you want to list

    // Find all the prefixes and items.
    firebaseStorageRef.listAll().then((res) => {
      res.items.forEach((element) {images.add(element);})
    });
  // [END storage_list_all]
    return images;
  }

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

              ListView.builder(
                  itemCount: tripimages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image(image: tripimages[index])
                      ]
                    );
                  }
              )
            ]
          ),
      )
    ),
    );
  }
}