// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripfinder/routepage.dart';
import 'package:tripfinder/user.dart';

import 'boxes.dart';

class MyTripList extends StatefulWidget {
  const MyTripList({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  State<MyTripList> createState() => _MyTripList(user);
}

class _MyTripList extends State<MyTripList> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
  TextStyle(fontSize: 15, color: Colors.black);

  static const TextStyle tripTitleStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15),
      primary: Colors.blue, onPrimary: Colors.white);

  _MyTripList(this.user);

  final Users user;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
                child: Text(
                  'My Previous Trips',
                  style: optionStyle
                )
              ),
              Container(
                height: 350,
                  child: ListView.builder(
                    itemCount: (user.trips).length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoutePage(trip: user.trips[index]),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white,), borderRadius: const BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //The image
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              alignment: FractionalOffset.topCenter,
                                              image: NetworkImage(user.trips[index].imageurl))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            //The title
                                            Text(
                                                user.trips[index].title,
                                                textAlign: TextAlign.left,
                                                style: tripTitleStyle
                                            ),
                                            //The content
                                            Text(
                                                user.trips[index].contentShort,
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: contentStyle
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Text(''),
                        ],
                      );
                    },
                  ),
              ),
              ]
        ),
      )
      ),
    );
  }
}