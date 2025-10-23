import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeletionService {
  static const _freedSpaceKey = 'freed_space';

  final ValueNotifier<int> deletedSpaceNotifier = ValueNotifier<int>(0);

  DeletionService() {
    _loadInitialFreedSpace();
  }

  void _loadInitialFreedSpace() async {
    deletedSpaceNotifier.value = await getTotalFreedSpace();
  }

  Future<void> recordDeletion(int bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final monthKey = '${now.year}-${now.month}';

    final currentData = prefs.getStringList(_freedSpaceKey) ?? [];
    currentData.add('$monthKey:$bytes');

    await prefs.setStringList(_freedSpaceKey, currentData);
    deletedSpaceNotifier.value = await getTotalFreedSpace();
  }

  Future<int> getTotalFreedSpace() async {
    final prefs = await SharedPreferences.getInstance();
    final allDeletions = prefs.getStringList(_freedSpaceKey) ?? [];
    int totalBytes = 0;

    for (var entry in allDeletions) {
      final parts = entry.split(':');
      if (parts.length == 2) {
        totalBytes += int.tryParse(parts[1]) ?? 0;
      }
    }
    return totalBytes;
  }
}
