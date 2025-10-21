import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoService {
  Future<PermissionStatus> requestPermission() async {
    return await Permission.photos.request();
  }

  Future<List<AssetPathEntity>> getAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      return await PhotoManager.getAssetPathList();
    } else {
      return [];
    }
  }

  Future<void> deletePhotos(List<AssetEntity> assets) async {
    final List<String> ids = assets.map((e) => e.id).toList();
    await PhotoManager.editor.deleteWithIds(ids);
  }
}
