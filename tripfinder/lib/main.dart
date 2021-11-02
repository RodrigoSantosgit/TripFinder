/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:flutter/material.dart';
import 'package:tripfinder/profile.dart';
import 'package:tripfinder/trippage.dart';
import 'package:tripfinder/trips.dart';
import 'package:tripfinder/user.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyNavBar(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key}) : super(key: key);

  @override
  State<MyNavBar> createState() => _MyNavBar();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyNavBar extends State<MyNavBar> {

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(title: 'Home'),
    Stat(user: Users(1, "Ricardo Silva", "ricardo@hotmail.com","password", "https://i.imgur.com/xZ6Ahkx.jpg",
        [Trips(2, 10, "Salinas",
            "Visita ás Salinas de Aveiro",
            "content2",
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg"
        ),
          Trips(3, 20, "Gastronomia",
              "Visita ás melhores ofertas gastronómicas de Aveiro",
              "content3",
              "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg"
          )])
    ),
    const Notification(title: 'Notification'),
    Profile(user: Users(1, "Ricardo Silva", "ricardo@hotmail.com","password", "https://i.imgur.com/xZ6Ahkx.jpg",
        [Trips(2, 10, "Salinas",
            "Visita ás Salinas de Aveiro",
            "content2",
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg"
        ),
          Trips(3, 20, "Gastronomia",
              "Visita ás melhores ofertas gastronómicas de Aveiro",
              "content3",
              "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg"
          )])
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripFinder'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  List<Trips> lTrips = [
    Trips(1, 15,"Ria de Aveiro",
      "Passeio ao longo da Ria de Aveiro",
      "Passeio ao longo da Ria de Aveiro, desfrute desta maravilhosa experiência passando por diversos locais de interesse em Aveiro como o Fórum e a Praça do Peixe.",
      "https://i2.wp.com/www.portugalnummapa.com/wp-content/uploads/2015/02/moliceiros-na-ria-de-aveiro-e1424799989448.jpg?fit=700%2C498&ssl=1"
    ),
    Trips(2, 10, "Salinas",
      "Visita ás Salinas de Aveiro", 
      "content2", 
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg"
    ),
    Trips(3, 20, "Gastronomia",
      "Visita ás melhores ofertas gastronómicas de Aveiro", 
      "content3", 
      "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg"
    )
  ];

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
      TextStyle(fontSize: 15, color: Colors.grey);

  static const TextStyle tripTitleStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: [
                Text('Nearby Trips', style: optionStyle),
                Spacer(),
                Text('Aveiro', style: tripTitleStyle),
              ]
            ),

            InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripPage(trip: lTrips[0]),
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
                              image: NetworkImage(lTrips[0].imageurl))),
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
                              lTrips[0].title,
                              textAlign: TextAlign.left,
                              style: tripTitleStyle
                            ),
                            //The content
                            Text(
                              lTrips[0].contentShort,
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

            Container(
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
                              image: NetworkImage(lTrips[1].imageurl))),
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
                              lTrips[1].title,
                              textAlign: TextAlign.left,
                              style: tripTitleStyle
                            ),
                            //The content
                            Text(
                              lTrips[1].contentShort,
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

            Container(
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
                              image: NetworkImage(lTrips[2].imageurl))),
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
                              lTrips[2].title,
                              textAlign: TextAlign.left,
                              style: tripTitleStyle
                            ),
                            //The content
                            Text(
                              lTrips[2].contentShort,
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

          ],
        ),
      ),
    );
  }
}

class Stat extends StatefulWidget {
  const Stat({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  State<Stat> createState() => _Stat(user);
}

class _Stat extends State<Stat> {

  static const TextStyle headerStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle headerNameStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);

  static const TextStyle typeStyle =
  TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static const TextStyle valueStyle =
  TextStyle(color: Colors.blue);

  _Stat(this.user);
  final Users user;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
                height:100,
                child: Row(
                  children: [
                    Spacer(),
                    const Text(
                      'Statistics for ',
                      style: headerStyle,
                    ),
                    Text(
                        user.name,
                        style: headerNameStyle
                    ),
                    Spacer()
                  ],
                )
            ),
            SizedBox(
                height:100,
                child: Column(
                    children: <Widget>[
                      const Text(
                        'Number of trips made',
                        style: typeStyle,
                      ),
                      Text(
                        (user.trips).length.toString(),
                        style: valueStyle,
                      ),
                      const Text(''),
                      const Text(
                          'Total Distance Traveled (in KM)',
                          style: typeStyle
                      ),
                      Text(
                          DistanceSum(user.trips).toString(),
                          style: valueStyle
                      )
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Notification> createState() => _Notification();
}

class _Notification extends State<Notification> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          child: Text(
            'Notifications',
            style: optionStyle,
          ),
        ),
      ),
    );
  }
}

int DistanceSum(List<Trips> trips){

  int sum = 0;
  for(int i=0;i< trips.length;i++){
    sum += trips[i].distance;
  }
  return sum;
}
