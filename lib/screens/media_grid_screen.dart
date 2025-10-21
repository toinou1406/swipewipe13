import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipe_clean/models/album.dart';
import 'package:swipe_clean/models/media.dart';
import 'package:swipe_clean/screens/swipe_screen.dart';
import 'package:swipe_clean/services/media_service.dart';

class MediaGridScreen extends StatefulWidget {
  final Album album;
  final MediaService mediaService;

  const MediaGridScreen(
      {Key? key, required this.album, required this.mediaService})
      : super(key: key);

  @override
  _MediaGridScreenState createState() => _MediaGridScreenState();
}

class _MediaGridScreenState extends State<MediaGridScreen> {
  late Future<List<Media>> _mediaFuture;

  @override
  void initState() {
    super.initState();
    _mediaFuture = widget.mediaService.getMediaForAlbum(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name),
      ),
      body: FutureBuilder<List<Media>>(
        future: _mediaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No media found.'));
          } else {
            final media = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: media.length,
              itemBuilder: (context, index) {
                final medium = media[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SwipeScreen(
                          media: media,
                          initialIndex: index,
                          mediaService: widget.mediaService,
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    File(medium.path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
