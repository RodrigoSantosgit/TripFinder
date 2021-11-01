import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {

  static const TextStyle headerStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle dataStyle =
  TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  'Olá Ricardo',
                  style: headerStyle,
                ),
                const Spacer(),
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("https://i.imgur.com/xZ6Ahkx.jpg"),
                    )
                  ),
                ),
              ],
            ),
            const Text(''),
            const Text(
              'E-mail ',
              style: dataStyle,
            ),
            const Text(
              'ricardo@hotmail.com'
            )
          ],
        ),
      ),
    );
  }
}