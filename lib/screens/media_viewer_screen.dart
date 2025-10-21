import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaViewerScreen extends StatelessWidget {
  final AssetEntity media;

  const MediaViewerScreen({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<Uint8List?>(
          future: media.originBytes,
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
              return Image.memory(snapshot.data!);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
