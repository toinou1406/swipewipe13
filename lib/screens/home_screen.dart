
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storage_space/storage_space.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _totalSpace;
  double? _freeSpace;

  @override
  void initState() {
    super.initState();
    _initStorageSpace();
  }

  Future<void> _initStorageSpace() async {
    StorageSpace storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: 0,
      fractionDigits: 2,
    );
    setState(() {
      _totalSpace = double.tryParse(storageSpace.totalSize);
      _freeSpace = double.tryParse(storageSpace.freeSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwipeClean'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_totalSpace != null && _freeSpace != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device Storage',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_totalSpace! - _freeSpace!) / _totalSpace!,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(_totalSpace! - _freeSpace!).toStringAsFixed(2)} GB used of ${_totalSpace!.toStringAsFixed(2)} GB',
                  ),
                ],
              )
            else
              const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 32),
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: <Widget>[
                  _buildCategoryCard(
                    context,
                    'Screenshots',
                    Icons.screenshot,
                    () => context.go('/swipe/screenshots'),
                  ),
                  _buildCategoryCard(
                    context,
                    'Videos',
                    Icons.videocam,
                    () => context.go('/swipe/videos'),
                  ),
                  _buildCategoryCard(
                    context,
                    'All Photos',
                    Icons.photo,
                    () => context.go('/swipe/all'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
