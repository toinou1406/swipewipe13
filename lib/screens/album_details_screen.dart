import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:go_router/go_router.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final AssetPathEntity album;

  const AlbumDetailsScreen({super.key, required this.album});

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  List<AssetEntity> _media = [];

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    final List<AssetEntity> media = await widget.album.getAssetListPaged(page: 0, size: 1000);
    setState(() {
      _media = media;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name),
      ),
      body: _media.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _media.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<Uint8List?>(
                  future: _media[index].thumbnailData,
                  builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      return GestureDetector(
                        onTap: () => context.go('/media', extra: _media[index]),
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
    );
  }
}
