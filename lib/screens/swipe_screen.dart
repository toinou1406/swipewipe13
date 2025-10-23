import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:permission_handler/permission_handler.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  List<Medium> _media = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLoadMedia();
  }

  Future<void> _requestPermissionAndLoadMedia() async {
    if (await Permission.photos.request().isGranted) {
      _loadMedia();
    }
  }

  Future<void> _loadMedia() async {
    try {
      final List<Album> albums = await PhotoGallery.listAlbums(
        mediumType: MediumType.image,
      );
      if (albums.isNotEmpty) {
        final MediaPage mediaPage = await albums.first.listMedia();
        setState(() {
          _media = mediaPage.items;
        });
      }
    } catch (e) {
      print('Failed to load media: $e');
    }
  }

  Future<void> _deleteMedium(Medium medium) async {
    try {
      final file = await medium.getFile();
      await file.delete();
    } catch (e) {
      print('Failed to delete medium: $e');
    }
  }

  void _onSwipe(DismissDirection direction) {
    final mediumToDelete = _media[_currentIndex];
    _deleteMedium(mediumToDelete);
    setState(() {
      _media.removeAt(_currentIndex);
      if (_currentIndex >= _media.length) {
        _currentIndex = _media.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe pour nettoyer'),
      ),
      body: _media.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: _media.asMap().entries.map((entry) {
                int index = entry.key;
                Medium medium = entry.value;
                return Dismissible(
                  key: Key(medium.id),
                  onDismissed: _onSwipe,
                  child: Center(
                    child: FutureBuilder<File>(
                      future: medium.getFile(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
