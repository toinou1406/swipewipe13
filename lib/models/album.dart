import 'package:floor/floor.dart';

@entity
class Album {
  @primaryKey
  final String id;
  final String name;
  final int count;

  Album({required this.id, required this.name, required this.count});
}
