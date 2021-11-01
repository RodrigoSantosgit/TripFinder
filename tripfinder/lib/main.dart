/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:flutter/material.dart';
import 'package:tripfinder/trips.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(title: 'Home'),
    Stat(title: 'Stats'),
    Notification(title: 'Notification'),
    Profile(title: 'Profile'),
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
    Trips(1, "Moliceiros", "content1", "https://i2.wp.com/www.portugalnummapa.com/wp-content/uploads/2015/02/moliceiros-na-ria-de-aveiro-e1424799989448.jpg?fit=700%2C498&ssl=1", "link1"),
    Trips(2, "Salinas", "content2", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Aveiro-Marais_salants-1967_07_29_29.jpg/1200px-Aveiro-Marais_salants-1967_07_29_29.jpg", "link2"),
    Trips(3, "Gastronomia", "content3", "https://media-cdn.tripadvisor.com/media/photo-s/0d/43/90/9b/polvo-a-lagareiro.jpg", "link3")
  ];

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle contentStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);

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
                              image: NetworkImage(lTrips[0].imageurl))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 10.0),
                      child: Container(
                        child: Column(
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
                              lTrips[0].content,
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
                              image: NetworkImage(lTrips[1].imageurl))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 10.0),
                      child: Container(
                        child: Column(
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
                              lTrips[1].content,
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
                      padding: const EdgeInsets.only(right: 8.0, top: 10.0),
                      child: Container(
                        child: Column(
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
                              lTrips[2].content,
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
  const Stat({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Stat> createState() => _Stat();
}

class _Stat extends State<Stat> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          child: Text(
            'Stat Page',
            style: optionStyle,
          ),
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