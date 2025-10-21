import 'package:floor/floor.dart';

@entity
class Album {
  @primaryKey(autoGenerate: true)
  final int? id;

  final String name;

  @ColumnInfo(name: 'cover_path')
  final String? coverPath;

  @ColumnInfo(name: 'is_premium')
  final bool isPremium;

  @ColumnInfo(name: 'created_at')
  final DateTime createdAt;

  Album({
    this.id,
    required this.name,
    this.coverPath,
    this.isPremium = false,
    required this.createdAt,
  });
}
