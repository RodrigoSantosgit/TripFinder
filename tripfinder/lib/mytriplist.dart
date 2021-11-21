// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripfinder/routepage.dart';
import 'package:tripfinder/trips.dart';
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

  /*addTrips(){
    var box = Boxes.getTrips();

    List<Trips> lTrips = [
      Trips(1, 15,"Ria de Aveiro",
          "Passeio ao longo da Ria de Aveiro",
          "Passeio ao longo da Ria de Aveiro, desfrute desta maravilhosa experiência passando por diversos locais de interesse em Aveiro como o Fórum e a Praça do Peixe.",
          "https://i2.wp.com/www.portugalnummapa.com/wp-content/uploads/2015/02/moliceiros-na-ria-de-aveiro-e1424799989448.jpg?fit=700%2C498&ssl=1",
          "Aveiro"
      ),
      Trips(2, 10, "Salinas",
          "Visita ás Salinas de Aveiro",
          "content2",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg",
          "Aveiro"
      ),
      Trips(3, 20, "Gastronomia",
          "Visita ás melhores ofertas gastronómicas de Aveiro",
          "content3",
          "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg",
          "Aveiro"
      ),
      Trips(4, 20, "Aliados",
          "Visite uma grande referência turística do Porto, a Avenida dos Aliados",
          "Poderá percorrer a pé toda a região, passear pelas várias ruas extremamente bonitas, visitar vários cafés, a igreja do Carmo, mercado do Bolhão  e estação de são Bento, entre outros",
          "https://turistaprofissional.com/wp-content/uploads/2013/05/downtownportoPraadaLiberdadeeAliados2.jpg",
          "Porto"
      )
    ];
    for(var i = 0; i < lTrips.length;i++){
      box.add(lTrips[i]);
    }
  }*/

  @override
  /*initState(){
    addTrips();
    super.initState();
  }*/
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