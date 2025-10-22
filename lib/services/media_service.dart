
import 'package:photo_manager/photo_manager.dart';

class MediaService {
  Future<List<AssetPathEntity>> getAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      return await PhotoManager.getAssetPathList(
        type: RequestType.all,
      );
    } else {
      // Handle the case where permission is not granted
      return [];
    }
  }

  Future<List<AssetEntity>> getMediaFromAlbum(String albumId) async {
    final AssetPathEntity album = (await PhotoManager.getAssetPathList(
      type: RequestType.all,
      filterOption: FilterOptionGroup(
        imageOption: const FilterOption(needTitle: true),
        videoOption: const FilterOption(needTitle: true),
        audioOption: const FilterOption(needTitle: true),
      ),
    ))
        .firstWhere((element) => element.id == albumId);
    return await album.getAssetListRange(
      start: 0,
      end: (await album.assetCountAsync),
    );
  }

  Future<List<AssetEntity>> getMedia(String category) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      RequestType type;
      switch (category) {
        case 'screenshots':
        // There is no direct way to get screenshots, so we filter by name
          final allImages = await PhotoManager.getAssetPathList(type: RequestType.image);
          List<AssetEntity> screenshots = [];
          for (var album in allImages) {
            final assets = await album.getAssetListRange(start: 0, end: await album.assetCountAsync);
            screenshots.addAll(assets.where((asset) => asset.title?.toLowerCase().contains('screenshot') ?? false));
          }
          return screenshots;
        case 'videos':
          type = RequestType.video;
          break;
        default:
          type = RequestType.image;
      }
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: type);
      List<AssetEntity> media = [];
      for (var album in albums) {
        media.addAll(await album.getAssetListRange(start: 0, end: await album.assetCountAsync));
      }
      return media;
    } else {
      return [];
    }
  }
  Future<String> deleteMedia(List<AssetEntity> assets) async {
    final List<String> ids = assets.map((e) => e.id).toList();
    final List<String> result = await PhotoManager.editor.deleteWithIds(ids);
    return '${result.length} items deleted';
  }


}
