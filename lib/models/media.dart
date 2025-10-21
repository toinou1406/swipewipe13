import 'package:floor/floor.dart';

@entity
class Media {
  @primaryKey
  final String id;
  final String albumId;
  final String path;
  final String type;
  final DateTime creationDate;

  Media({
    required this.id,
    required this.albumId,
    required this.path,
    required this.type,
    required this.creationDate,
  });
}
