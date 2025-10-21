import 'package:flutter/material.dart';
import 'package:sparkle/models/database.dart';
import 'package:sparkle/widgets/album_card.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final albums = Database().albums;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return AlbumCard(album: albums[index]);
        },
      ),
    );
  }
}
