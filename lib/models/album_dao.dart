
import 'package:floor/floor.dart';
import 'package:myapp/models/album.dart';

@dao
abstract class AlbumDao {
  @Query('SELECT * FROM Album')
  Future<List<Album>> findAllAlbums();

  @insert
  Future<void> insertAlbum(Album album);
}
