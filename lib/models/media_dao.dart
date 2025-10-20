
import 'package:floor/floor.dart';
import 'package:myapp/models/media.dart';

@dao
abstract class MediaDao {
  @Query('SELECT * FROM Media')
  Future<List<Media>> findAllMedia();

  @insert
  Future<void> insertMedia(Media media);
}
