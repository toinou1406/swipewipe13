import 'package:floor/floor.dart';
import 'package:sparkle/models/album.dart';

@dao
abstract class AlbumDao {
  @Query('SELECT * FROM Album')
  Future<List<Album>> findAllAlbums();

  @insert
  Future<void> insertAlbum(Album album);

  @update
  Future<void> updateAlbum(Album album);

  @delete
  Future<void> deleteAlbum(Album album);
}
