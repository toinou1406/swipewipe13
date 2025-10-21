import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_clean/features/photos/data/services/photo_service.dart';
import 'package:swipe_clean/features/photos/presentation/screens/photo_viewer_screen.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final PhotoService _photoService = PhotoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: FutureBuilder<List<AssetPathEntity>>(
        future: _photoService.getAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading albums'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No albums found'));
          }

          final albums = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return GestureDetector(
                onTap: () async {
                  final photos = await album.getAssetListRange(start: 0, end: await album.assetCountAsync);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoViewerScreen(
                        photos: photos,
                        initialIndex: 0,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<AssetEntity>>(
                          future: album.getAssetListRange(start: 0, end: 1),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return AssetEntityImage(
                                snapshot.data!.first,
                                fit: BoxFit.cover,
                              );
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      Text(album.name),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
