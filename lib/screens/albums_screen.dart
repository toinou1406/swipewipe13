import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<Album> _albums = [];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLoadAlbums();
  }

  Future<void> _requestPermissionAndLoadAlbums() async {
    if (await Permission.photos.request().isGranted) {
      _loadAlbums();
    }
  }

  Future<void> _loadAlbums() async {
    try {
      final List<Album> albums = await PhotoGallery.listAlbums(
        mediumType: MediumType.image,
      );
      setState(() {
        _albums = albums;
      });
    } catch (e) {
      print('Failed to load albums: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: _albums.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _albums.length,
              itemBuilder: (context, index) {
                final album = _albums[index];
                return GestureDetector(
                  onTap: () => context.go('/albums/${album.id}'),
                  child: Column(
                    children: [
                      FutureBuilder<Medium>(
                        future: album.listMedia().then((media) => media.items.first),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return FutureBuilder<File>(
                              future: snapshot.data!.getFile(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.file(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    height: 150,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Text(album.name ?? 'Unnamed Album'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
