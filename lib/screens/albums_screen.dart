import 'package:flutter/material.dart';
import 'package:sparkle/widgets/album_card.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for albums
    final albums = [
      {'name': 'Favorites', 'coverUrl': 'https://picsum.photos/200/300?random=1'},
      {'name': 'Trips', 'coverUrl': 'https://picsum.photos/200/300?random=2'},
      {'name': 'Family', 'coverUrl': 'https://picsum.photos/200/300?random=3'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0, // To make the cards square
        ),
        itemCount: albums.length + 1, // +1 for the add button
        itemBuilder: (context, index) {
          if (index < albums.length) {
            final album = albums[index];
            return AlbumCard(
              albumName: album['name']!,
              coverUrl: album['coverUrl']!,
            );
          } else {
            return _buildAddAlbumCard();
          }
        },
      ),
    );
  }

  Widget _buildAddAlbumCard() {
    return Tooltip(
      message: 'Available in Premium',
      child: Card(
        color: const Color(0xFF333333).withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF333333)),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Color(0xFF808080),
            size: 50,
          ),
        ),
      ),
    );
  }
}
