
import 'package:floor/floor.dart';

@entity
class Album {
  @primaryKey
  final int? id;
  final String name;
  final String? coverPath;
  final bool isPremium;
  final DateTime createdAt;

  Album({
    this.id,
    required this.name,
    this.coverPath,
    this.isPremium = false,
    required this.createdAt,
  });
}
