import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String albumName;
  final String? coverUrl;

  const AlbumCard({super.key, required this.albumName, this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        // Handle double tap to edit album name
      },
      child: Card(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF333333)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (coverUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  coverUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Center(
                child: Icon(
                  Icons.photo_album,
                  color: Color(0xFF808080),
                  size: 50,
                ),
              ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                albumName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
