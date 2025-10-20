
import 'package:floor/floor.dart';

@entity
class Media {
  @primaryKey
  final String id;

  final String albumId;

  final DateTime creationDate;

  final String? path;

  Media(this.id, this.albumId, this.creationDate, this.path);
}
