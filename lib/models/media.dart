import 'package:floor/floor.dart';

@entity
class Media {
  @primaryKey(autoGenerate: true)
  final int? id;

  final String path;

  final String type; // 'photo' or 'video'

  @ColumnInfo(name: 'album_id')
  final int? albumId;

  @ColumnInfo(name: 'deleted_at')
  final DateTime? deletedAt;

  Media({
    this.id,
    required this.path,
    required this.type,
    this.albumId,
    this.deletedAt,
  });
}
