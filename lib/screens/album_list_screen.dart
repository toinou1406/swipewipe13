import 'package:flutter/material.dart';
import 'package:swipe_clean/models/album.dart';
import 'package:swipe_clean/services/media_service.dart';
import 'package:swipe_clean/screens/media_grid_screen.dart';

class AlbumListScreen extends StatefulWidget {
  final MediaService mediaService;

  const AlbumListScreen({Key? key, required this.mediaService}) : super(key: key);

  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late Future<List<Album>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    _albumsFuture = widget.mediaService.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: FutureBuilder<List<Album>>(
        future: _albumsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No albums found.'));
          } else {
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.name),
                  subtitle: Text('${album.count} items'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaGridScreen(
                          album: album,
                          mediaService: widget.mediaService,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
