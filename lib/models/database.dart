import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sparkle/models/album.dart';
import 'package:sparkle/models/album_dao.dart';
import 'package:sparkle/models/media.dart';
import 'package:sparkle/models/media_dao.dart';
import 'package:sparkle/models/type_converters.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Album, Media])
abstract class AppDatabase extends FloorDatabase {
  AlbumDao get albumDao;
  MediaDao get mediaDao;
}
