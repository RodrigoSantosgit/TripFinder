import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';
import 'package:tripfinder/user.dart';

import 'mytriplist.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Profile> createState() => _Profile();
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
      textStyle: const TextStyle(fontSize: 15), minimumSize: const Size(150, 30),
      primary: Colors.blue, onPrimary: Colors.white);

  Users user = Users(1, "Ricardo Silva", "ricardo@hotmail.com","password", "https://i.imgur.com/xZ6Ahkx.jpg",
      [Trips(2, "Salinas",
          "Visita ás Salinas de Aveiro",
          "content2",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg"
      ),
        Trips(3, "Gastronomia",
            "Visita ás melhores ofertas gastronómicas de Aveiro",
            "content3",
            "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg"
        )]);

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