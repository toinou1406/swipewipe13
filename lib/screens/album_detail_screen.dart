import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

class AlbumDetailScreen extends StatefulWidget {
  final String albumId;

  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  List<Medium> _media = [];

  @override
  void initState() {
    super.initState();
    _loadAlbumMedia();
  }

  Future<void> _loadAlbumMedia() async {
    try {
      final Album album = (await PhotoGallery.listAlbums(
        mediumType: MediumType.image,
      ))
          .firstWhere((album) => album.id == widget.albumId);

      final MediaPage mediaPage = await album.listMedia();
      setState(() {
        _media = mediaPage.items;
      });
    } catch (e) {
      print('Failed to load album media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: _media.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _media.length,
              itemBuilder: (context, index) {
                final medium = _media[index];
                return FutureBuilder<File>(
                  future: medium.getFile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.file(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            ),
    );
  }
}
