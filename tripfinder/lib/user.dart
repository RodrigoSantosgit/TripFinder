/// ************************************************
/// ***************** Users ************************
/// ************************************************

import 'package:tripfinder/trips.dart';

class Users {
  int id;
  String name, email, password, profilePic;
  List<Trips> trips;
  Users(this.id, this.name, this.email, this.password, this.profilePic, this.trips);
}