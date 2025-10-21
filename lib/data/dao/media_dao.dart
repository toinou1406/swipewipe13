import 'package:floor/floor.dart';
import 'package:swipe_clean/models/media.dart';

@dao
abstract class MediaDao {
  @Query('SELECT * FROM Media WHERE albumId = :albumId')
  Future<List<Media>> findMediaForAlbum(String albumId);

  @insert
  Future<void> insertMedia(Media media);

  @delete
  Future<void> deleteMedia(Media media);
}
