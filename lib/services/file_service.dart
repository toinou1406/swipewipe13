import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<Directory> get _trashDirectory async {
    final appDir = await getApplicationDocumentsDirectory();
    final trashDir = Directory('${appDir.path}/trash');
    if (!await trashDir.exists()) {
      await trashDir.create();
    }
    return trashDir;
  }

  Future<File> moveToTrash(File file) async {
    final trashDir = await _trashDirectory;
    final newPath = '${trashDir.path}/${file.path.split('/').last}';
    return file.rename(newPath);
  }
}
