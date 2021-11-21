import 'package:hive/hive.dart';

/// ************************************************
/// ***************** TRIPS ************************
/// ************************************************

part 'trips.g.dart';

@HiveType(typeId: 1)
class Trips extends HiveObject{

  @HiveField(0)
  int id;

  @HiveField(1)
  int distance;

  @HiveField(2)
  String title;

  @HiveField(3)
  String contentShort;

  @HiveField(4)
  String contentFull;

  @HiveField(5)
  String imageurl;

  @HiveField(6)
  String location;

  Trips(this.id, this.distance, this.title, this.contentShort, this.contentFull, this.imageurl, this.location);
}