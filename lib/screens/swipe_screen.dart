
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../services/media_service.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key, required this.category});

  final String category;

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late final MediaService _mediaService;
  late Future<List<AssetEntity>> _mediaFuture;
  final List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  final List<AssetEntity> _keptItems = [];
  final List<AssetEntity> _deletedItems = [];

  @override
  void initState() {
    super.initState();
    _mediaService = MediaService();
    _mediaFuture = _loadMedia();
  }

  Future<List<AssetEntity>> _loadMedia() async {
    final media = await _mediaService.getMedia(widget.category);
    _swipeItems.clear();
    for (var asset in media) {
      _swipeItems.add(SwipeItem(
        content: asset,
        likeAction: () {
          _keptItems.add(asset);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Kept"), duration: Duration(milliseconds: 500)));
        },
        nopeAction: () {
          _deletedItems.add(asset);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("To be deleted"), duration: Duration(milliseconds: 500)));
        },
      ));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe - ${widget.category}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              context.push('/review', extra: _deletedItems);
            },
          )
        ],
      ),
      body: FutureBuilder<List<AssetEntity>>(
        future: _mediaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No media found.'));
          }

          return Stack(
            children: [
              SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final asset = _swipeItems[index].content as AssetEntity;
                  return FutureBuilder<File?>(
                    future: asset.file,
                    builder: (context, fileSnapshot) {
                      if (fileSnapshot.connectionState == ConnectionState.done &&
                          fileSnapshot.data != null) {
                        return Container(
                          alignment: Alignment.center,
                          child: Image.file(
                            fileSnapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All items swiped!")));
                },
                itemChanged: (SwipeItem item, int index) {},
                upSwipeAllowed: false,
                fillSpace: true,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _matchEngine.currentItem?.nope();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.red,
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _matchEngine.currentItem?.like();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.green,
                        ),
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
