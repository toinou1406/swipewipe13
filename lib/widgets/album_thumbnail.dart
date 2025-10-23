import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

class AlbumThumbnail extends StatelessWidget {
  final Album album;

  const AlbumThumbnail({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MediaPage>(
      future: album.listMedia(take: 1),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
          final medium = snapshot.data!.items.first;
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FutureBuilder<dynamic>(
                future: medium.getThumbnail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.memory(
                      snapshot.data,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Container(color: Colors.grey[200]);
                  }
                }),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(Icons.photo_album_outlined, color: Colors.grey, size: 40),
          );
        }
      },
    );
  }
}
