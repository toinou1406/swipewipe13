import 'package:floor/floor.dart';
import 'package:sparkle/models/media.dart';

@dao
abstract class MediaDao {
  @Query('SELECT * FROM Media WHERE album_id IS NULL AND deleted_at IS NULL ORDER BY id DESC')
  Future<List<Media>> findUnsortedMedia();

  @Query('SELECT * FROM Media WHERE album_id = :albumId')
  Future<List<Media>> findMediaByAlbum(int albumId);

  @insert
  Future<void> insertMedia(Media media);

  @update
  Future<void> updateMedia(Media media);

  @delete
  Future<void> deleteMedia(Media media);
}
