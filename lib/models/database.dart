
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:swipe_clean/models/album.dart';
import 'package:swipe_clean/models/album_dao.dart';
import 'package:swipe_clean/models/media.dart';
import 'package:swipe_clean/models/media_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Album, Media])
abstract class AppDatabase extends FloorDatabase {
  AlbumDao get albumDao;
  MediaDao get mediaDao;
}
