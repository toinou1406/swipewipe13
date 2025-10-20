
import 'package:floor/floor.dart';

@entity
class Media {
  @primaryKey
  final int? id;
  final String path;
  final String type; // 'photo' or 'video'
  final int? albumId;
  final DateTime? deletedAt;

  Media({
    this.id,
    required this.path,
    required this.type,
    this.albumId,
    this.deletedAt,
  });
}
