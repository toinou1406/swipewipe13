
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:myapp/models/album.dart';
import 'package:myapp/models/album_dao.dart';
import 'package:myapp/models/media.dart';
import 'package:myapp/models/media_dao.dart';
import 'package:myapp/models/type_converter.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Album, Media])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  AlbumDao get albumDao;
  MediaDao get mediaDao;
}
