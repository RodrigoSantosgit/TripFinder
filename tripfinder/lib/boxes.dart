import 'package:hive/hive.dart';
import 'package:tripfinder/trips.dart';
import 'package:tripfinder/user.dart';

class Boxes{
  static Box<Users> getUsers() =>
      Hive.box<Users>('users');
  static Box<Trips> getTrips() =>
      Hive.box<Trips>('trips');
}