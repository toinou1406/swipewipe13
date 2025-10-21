import 'dart:io';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:swipe_clean/models/album.dart' as local_album;
import 'package:swipe_clean/models/media.dart' as local_media;
import 'package:swipe_clean/data/app_database.dart';
import 'package:swipe_clean/services/file_service.dart';

class MediaService {
  final AppDatabase _database;
  final FileService _fileService;

  MediaService(this._database, this._fileService);

  Future<void> syncAlbums() async {
    List<Album> albums = await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
    );

    for (var album in albums) {
      final localAlbum = local_album.Album(
        id: album.id,
        name: album.name ?? "Unnamed Album",
        count: album.count,
      );
      await _database.albumDao.insertAlbum(localAlbum);
    }
  }

  Future<List<local_album.Album>> getAlbums() {
    return _database.albumDao.findAllAlbums();
  }

  Future<void> syncMediaForAlbum(String albumId) async {
    MediaPage mediaPage = await PhotoGallery.getAlbum(albumId: albumId).listMedia();

    for (var medium in mediaPage.items) {
      final file = await medium.getFile();
      final localMedia = local_media.Media(
        id: medium.id,
        albumId: albumId,
        path: file.path,
        type: medium.mediumType.toString(),
        creationDate: medium.creationDate ?? DateTime.now(),
      );
      await _database.mediaDao.insertMedia(localMedia);
    }
  }

  Future<List<local_media.Media>> getMediaForAlbum(String albumId) {
    return _database.mediaDao.findMediaForAlbum(albumId);
  }

  Future<void> deleteMedia(local_media.Media media) async {
    final file = File(media.path);
    await _fileService.moveToTrash(file);
    await _database.mediaDao.deleteMedia(media);
  }
}
