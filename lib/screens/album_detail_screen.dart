import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import './swipe_screen.dart';

class AlbumDetailScreen extends StatefulWidget {
  final String albumName;

  const AlbumDetailScreen({super.key, required this.albumName});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  List<Medium> _media = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbumMedia();
  }

  Future<void> _loadAlbumMedia() async {
    setState(() => _isLoading = true);
    try {
      final albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
      final album = albums.firstWhere((a) => a.name == widget.albumName, orElse: () => albums.first);
      
      final mediaPage = await album.listMedia();
      setState(() {
        _media = mediaPage.items;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load album media: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumName),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _media.length,
              itemBuilder: (context, index) {
                return FutureBuilder<File>(
                  future: _media[index].getFile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridTile(
                        child: Image.file(snapshot.data!, fit: BoxFit.cover),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SwipeScreen(isFromAlbum: true),
            ),
          );
        },
        label: const Text('Ajouter des photos'),
        icon: const Icon(Icons.add_photo_alternate_outlined),
      ),
    );
  }
}
