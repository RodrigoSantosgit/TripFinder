import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:tripfinder/authentication_service.dart';
import 'package:tripfinder/trips.dart';
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
  /*addTrips(){
    var box = Boxes.getTrips();
    List<Trips> lTrips = [
      Trips(1, 15,"Ria de Aveiro",
          "Passeio ao longo da Ria de Aveiro",
          "Passeio ao longo da Ria de Aveiro, desfrute desta maravilhosa experiência passando por diversos locais de interesse em Aveiro como o Fórum e a Praça do Peixe.",
          "https://i2.wp.com/www.portugalnummapa.com/wp-content/uploads/2015/02/moliceiros-na-ria-de-aveiro-e1424799989448.jpg?fit=700%2C498&ssl=1",
          "Aveiro",
          40.641482,
          -8.653080
      ),
      Trips(2, 10, "Salinas",
          "Visita ás Salinas de Aveiro",
          "content2",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg",
          "Aveiro",
          40.644699,
          -8.662301
      ),
      Trips(3, 20, "Gastronomia",
          "Visita ás melhores ofertas gastronómicas de Aveiro",
          "content3",
          "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg",
          "Aveiro",
          40.635749,
          -8.649522
      ),
      Trips(4, 20, "Aliados",
          "Visite uma grande referência turística do Porto, a Avenida dos Aliados",
          "Poderá percorrer a pé toda a região, passear pelas várias ruas extremamente bonitas, visitar vários cafés, a igreja do Carmo, mercado do Bolhão  e estação de são Bento, entre outros",
          "https://turistaprofissional.com/wp-content/uploads/2013/05/downtownportoPraadaLiberdadeeAliados2.jpg",
          "Porto",
          41.148148,
          -8.610847
      )
    ];
    for(var i = 0; i < lTrips.length;i++){
      box.add(lTrips[i]);
    }
  }*/

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