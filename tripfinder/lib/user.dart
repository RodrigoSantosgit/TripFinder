/// ************************************************
/// ***************** Users ************************
/// ************************************************

import 'package:hive/hive.dart';
import 'package:tripfinder/trips.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class Users extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String profilePic;

  @HiveField(3)
  List<Trips> trips;

  Users(this.name, this.email, this.profilePic, this.trips);
}