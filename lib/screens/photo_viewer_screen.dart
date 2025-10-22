
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_clean/services/media_service.dart';

class PhotoViewerScreen extends StatefulWidget {
  final String albumId;
  final String albumName;

  const PhotoViewerScreen({
    super.key,
    required this.albumId,
    required this.albumName,
  });

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  final MediaService _mediaService = MediaService();
  Future<List<AssetEntity>>? _mediaFuture;

  @override
  void initState() {
    super.initState();
    _mediaFuture = _mediaService.getMediaFromAlbum(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumName),
      ),
      body: FutureBuilder<List<AssetEntity>>(
        future: _mediaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No media found in this album.'));
          }

          final media = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: media.length,
            itemBuilder: (context, index) {
              final asset = media[index];
              return FutureBuilder<File?>(
                future: asset.file, // This is a convenience getter
                builder: (context, fileSnapshot) {
                  if (fileSnapshot.connectionState == ConnectionState.done &&
                      fileSnapshot.data != null) {
                    return Image.file(
                      fileSnapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
          );
        },
      ),
    );
  }
}
