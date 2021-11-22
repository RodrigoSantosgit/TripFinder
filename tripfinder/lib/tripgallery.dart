// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TripGallery extends StatefulWidget {
  const TripGallery({Key? key, required this.photos, required this.trip}) : super(key: key);

  final List photos;
  final Trips trip;

  @override
  State<TripGallery> createState() => _TripGallery(photos, trip);
}

class _TripGallery extends State<TripGallery> {

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
      TextStyle(fontSize: 15, color: Colors.black);

  _TripGallery(this.photos,this.trip);

  final List photos;
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

              Container(
                height: 400,
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 3,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageDisplay(
                                    image: photos[index],
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(photos[index]),
                              ),
                            ),
                          ),
                        );
                      }
                  )
              )
            ]
          ),
      )
    ),
    );
  }
}

class ImageDisplay extends StatelessWidget{
  ImageDisplay({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    body: return Scaffold(
      appBar: AppBar(
        title: const Text('TripFinder'),
        backgroundColor: Colors.black,
      ),
      body: Center(child:
      AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          child: Image(
            image: NetworkImage(image),
          ),
        ),
      ),
      ),
    );
  }
}