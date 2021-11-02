import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:tripfinder/user.dart';

import 'mytriplist.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  State<Profile> createState() => _Profile(user);
}

class _Profile extends State<Profile> {

  static const TextStyle headerStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle typeStyle =
  TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static const TextStyle valueStyle =
  TextStyle(color: Colors.blue);

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15), minimumSize: const Size(150, 25),
      primary: Colors.blue, onPrimary: Colors.white);

  _Profile(this.user);
  final Users user;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Row(
                children: <Widget>[
                  const Text(
                    'Olá ',
                    style: headerStyle,
                  ),
                  Text(
                    user.name,
                    style: headerStyle,
                  ),
                  const Spacer(),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(user.profilePic),
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 120,
                child: Column(
                    children: <Widget>[
                      const Text(
                        'E-mail ',
                        style: typeStyle,
                      ),
                      Text(
                        user.email,
                        style: valueStyle,
                      ),
                      const Text(''),
                      const Text(
                          'Trips made',
                          style: typeStyle
                      ),
                      Text(
                          (user.trips).length.toString()
                      )
                    ]
                )
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () {},
              child: const Text('Preferences'),
            ),
            const Text(''),
            TextButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTripList(user: user),
                  ),
                );
              },
              child: const Text('My Trips'),
            ),
          ],
        ),
      ),
    );
  }
}