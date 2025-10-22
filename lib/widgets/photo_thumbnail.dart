import 'package:flutter/material.dart';

class PhotoThumbnail extends StatelessWidget {
  const PhotoThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800], // Placeholder
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.white24,
        ),
      ),
    );
  }
}
