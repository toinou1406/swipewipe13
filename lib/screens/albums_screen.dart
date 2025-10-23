import 'package:flutter/material.dart';
import './album_detail_screen.dart';

class Album {
  final String name;
  final IconData icon;

  Album({required this.name, required this.icon});
}

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  final List<Album> _albums = [
    Album(name: 'Favoris', icon: Icons.favorite_border),
    Album(name: 'Archives', icon: Icons.archive_outlined),
    Album(name: 'À trier plus tard', icon: Icons.lightbulb_outline),
  ];

  void _renameAlbum(Album album) {
    final controller = TextEditingController(text: album.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Renommer l'album'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Annuler')),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = _albums.indexOf(album);
                  _albums[index] = Album(name: controller.text, icon: album.icon);
                });
                Navigator.of(context).pop();
              },
              child: Text('Renommer'),
            ),
          ],
        );
      },
    );
  }

  void _viewAlbum(Album album) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlbumDetailScreen(albumName: album.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Albums'),
      ),
      body: ListView.builder(
        itemCount: _albums.length,
        itemBuilder: (context, index) {
          final album = _albums[index];
          return ListTile(
            leading: Icon(album.icon, size: 32),
            title: Text(album.name, style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _viewAlbum(album),
            onLongPress: () => _renameAlbum(album),
          );
        },
      ),
    );
  }
}
