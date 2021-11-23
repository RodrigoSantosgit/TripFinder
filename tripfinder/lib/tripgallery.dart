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

  _TripGallery(this.trip);

  final Trips trip;

  late List tripimages = [];

  _listAll() {

    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/${trip.id}');

    // [START storage_list_all]
    // Create a reference under which you want to list

    // Find all the prefixes and items.
    firebaseStorageRef.listAll().then((res) => {
      res.items.forEach((element) async {
        var url;
        try{
          url = await element.getDownloadURL();
          setState(() {
            tripimages.add(url);
          });
        } on Exception catch(e){
          print("error: "+e.toString());
        }
      })
    });
  }

  @override
  initState(){
    super.initState();
    _listAll();
  }
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
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 3,
                      ),
                      itemCount: tripimages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageDisplay(
                                    image: tripimages[index],
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(tripimages[index]),
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
    return Scaffold(
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