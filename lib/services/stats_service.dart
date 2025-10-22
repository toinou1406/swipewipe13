import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const String _deletedPhotosKey = 'deleted_photos';
  static const String _storageSavedKey = 'storage_saved';
  static const String _lastVisitedAlbumKey = 'last_visited_album';
  static const String _monthlyStorageSavedKey = 'monthly_storage_saved';

  Future<void> addDeletedPhotos(int count, int size) async {
    final prefs = await SharedPreferences.getInstance();
    final currentDeletedPhotos = await getDeletedPhotos();
    final currentStorageSaved = await getStorageSaved();
    await prefs.setInt(_deletedPhotosKey, currentDeletedPhotos + count);
    await prefs.setInt(_storageSavedKey, currentStorageSaved + size);

    final month = DateTime.now().month.toString();
    final monthlyStorageSaved = await getMonthlyStorageSaved();
    await prefs.setInt(_monthlyStorageSavedKey, (monthlyStorageSaved[month] ?? 0) + size);
  }

  Future<int> getDeletedPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_deletedPhotosKey) ?? 0;
  }

  Future<int> getStorageSaved() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_storageSavedKey) ?? 0;
  }

  Future<void> setLastVisitedAlbum(String albumName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastVisitedAlbumKey, albumName);
  }

  Future<String?> getLastVisitedAlbum() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastVisitedAlbumKey);
  }

  Future<Map<String, int>> getMonthlyStorageSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final month = DateTime.now().month.toString();
    final value = prefs.getInt(_monthlyStorageSavedKey) ?? 0;
    return {month: value};
  }

  // Methods to get total and used storage. These are placeholders and should be implemented with a suitable package.
  Future<double> getTotalStorage() async {
    // Placeholder: returns a fixed value
    return 256.0; // GB
  }

  Future<double> getUsedStorage() async {
    // Placeholder: returns a fixed value
    return 100.0; // GB
  }
}
