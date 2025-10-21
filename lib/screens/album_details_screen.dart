import 'package:flutter/material.dart';
import 'package:sparkle/models/album.dart';
import 'package:sparkle/widgets/media_card.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailsScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.name),
      ),
      body: PageView.builder(
        itemCount: album.media.length,
        itemBuilder: (context, index) {
          return MediaCard(media: album.media[index]);
        },
      ),
    );
  }
}
