
import 'package:floor/floor.dart';

@entity
class Album {
  @primaryKey
  final String id;

  final String name;

  final int count;

  Album(this.id, this.name, this.count);
}
