
import 'package:floor/floor.dart';
import 'package:swipe_clean/models/media.dart';

@dao
abstract class MediaDao {
  @Query('SELECT * FROM Media WHERE albumId IS NULL AND deletedAt IS NULL ORDER BY id DESC')
  Future<List<Media>> findUnsortedMedia();

  @Query('SELECT * FROM Media WHERE albumId = :albumId AND deletedAt IS NULL')
  Future<List<Media>> findMediaByAlbum(int albumId);

  @insert
  Future<void> insertMedia(Media media);

  @update
  Future<void> updateMedia(Media media);

  @Query('SELECT * FROM Media ORDER BY id DESC LIMIT 1')
  Future<Media?> findLastMedia();
}
