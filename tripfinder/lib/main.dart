/// Flutter code sample for BottomNavigationBar
// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripfinder/authentication_service.dart';
import 'package:tripfinder/profile.dart';
import 'package:tripfinder/signinpage.dart';
import 'package:tripfinder/trippage.dart';
import 'package:tripfinder/trips.dart';
import 'package:tripfinder/user.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(TripsAdapter());
  Hive.registerAdapter(UsersAdapter());

  await Hive.openBox<Trips>('trips');
  await Hive.openBox<Users>('users');

  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
        ],
      child: const MaterialApp(
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null){
      return MyNavBar();
    }
    return SignInPage();
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
    const Stat(),
    const Profile(),
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

  late List<Trips> lTrips;

  getTrips() {
    var box = Boxes.getTrips();
    /*box.clear();
    var box2 = Boxes.getUsers();
    box2.clear();*/
    lTrips = box.values.toList();
  }

    static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    static const TextStyle contentStyle =
    TextStyle(fontSize: 15, color: Colors.grey);

    static const TextStyle tripTitleStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);

    @override
    initState() {
      getTrips();
      super.initState();
    }
    Widget build(BuildContext context){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                  children: const [
                    Text('Nearby Trips', style: optionStyle),
                    Spacer(),
                    //Text('Aveiro', style: tripTitleStyle),
                    LocationButton(),
                  ]
              ),
              Container(
                height: 350,
                child: ListView.builder(
                  itemCount: lTrips.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TripPage(trip: lTrips[index]),
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
                                            image: NetworkImage(lTrips[index].imageurl))),
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
                                              lTrips[index].title,
                                              textAlign: TextAlign.left,
                                              style: tripTitleStyle
                                          ),
                                          //The content
                                          Text(
                                              lTrips[index].contentShort,
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
            ],
          ),
        ),
      );
    }
  }


class Stat extends StatefulWidget {
  const Stat({Key? key}) : super(key: key);

  @override
  State<Stat> createState() => _Stat();
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

  late final Users _currentUser;

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
    super.initState();
  }
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
                    const Spacer(),
                    const Text(
                      'Statistics for ',
                      style: headerStyle,
                    ),
                    Text(
                        _currentUser.name,
                        style: headerNameStyle
                    ),
                    const Spacer()
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
                        (_currentUser.trips).length.toString(),
                        style: valueStyle,
                      ),
                      const Text(''),
                      const Text(
                          'Total Distance Traveled (in KM)',
                          style: typeStyle
                      ),
                      Text(
                          distanceSum(_currentUser.trips).toString(),
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

int distanceSum(List<Trips> trips){

  int sum = 0;
  for(int i=0;i< trips.length;i++){
    sum += trips[i].distance;
  }
  return sum;
}

class LocationButton extends StatefulWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LocationButtonState extends State<LocationButton> {
  String dropdownValue = 'Aveiro';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 15,
      style: const TextStyle(fontSize: 18, color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Todos', 'Aveiro', 'Porto']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}