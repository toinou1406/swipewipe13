import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AssetEntity> _media = [];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndFetchMedia();
  }

  Future<void> _requestPermissionAndFetchMedia() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
      if (paths.isNotEmpty) {
        final AssetPathEntity path = paths.first;
        final List<AssetEntity> media = await path.getAssetListPaged(page: 0, size: 100);
        setState(() {
          _media = media;
        });
      }
    } else {
      // Handle permission denial
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sparkle'),
      ),
      body: _media.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _media.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<Uint8List?>(
                  future: _media[index].thumbnailData,
                  builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      return GestureDetector(
                        onTap: () => context.go('/media', extra: _media[index]),
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
    );
  }
}
