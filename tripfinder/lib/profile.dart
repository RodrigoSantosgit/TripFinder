import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tripfinder/authentication_service.dart';
import 'package:tripfinder/user.dart';

import 'boxes.dart';
import 'mytriplist.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


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

  final ButtonStyle logoutbuttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15), minimumSize: const Size(150, 25),
      primary: Colors.red, onPrimary: Colors.white);

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15), minimumSize: const Size(150, 25),
      primary: Colors.blue, onPrimary: Colors.white);

  late final Users _currentUser;

  var image;

  getUsers() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;
    var box = Boxes.getUsers();
    List list = box.values.toList();
    for(var i = 0; i < list.length;i++){
      Users? tmp = list[i];
      if(tmp!.email==email) _currentUser = tmp;
    }
  }

  @override
  initState(){
    getUsers();
    if(_currentUser.profilePic.isEmpty){
      image = Container(
        width: 120.0,
        height: 120.0,
        child: const Icon(Icons.account_circle, size: 80, color: Colors.grey),
      );
    }else{
      image = Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(_currentUser.profilePic),
            )
        ),
      );
    }
    super.initState();
  }
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
                    _currentUser.name,
                    style: headerStyle,
                  ),
                  const Spacer(),
                  image,
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
                        _currentUser.email,
                        style: valueStyle,
                      ),
                      const Text(''),
                      const Text(
                          'Trips made',
                          style: typeStyle
                      ),
                      Text(
                          (_currentUser.trips).length.toString()
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
                    builder: (context) => MyTripList(user: _currentUser),
                  ),
                );
              },
              child: const Text('My Trips'),
            ),
            const Text(''),
            TextButton(
              style: logoutbuttonStyle,
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}