import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipe_clean/models/media.dart';
import 'package:swipe_clean/services/media_service.dart';

class SwipeScreen extends StatefulWidget {
  final List<Media> media;
  final int initialIndex;
  final MediaService mediaService;

  const SwipeScreen(
      {Key? key,
      required this.media,
      required this.initialIndex,
      required this.mediaService})
      : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onSwipe(bool keep) {
    if (keep) {
      // Just move to the next photo
      if (_currentIndex < widget.media.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // Delete the photo and move to the next one
      widget.mediaService.deleteMedia(widget.media[_currentIndex]);
      setState(() {
        widget.media.removeAt(_currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe to Clean'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.media.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final medium = widget.media[index];
          return Dismissible(
            key: Key(medium.id),
            onDismissed: (direction) {
              _onSwipe(direction == DismissDirection.startToEnd);
            },
            child: Center(
              child: Image.file(
                File(medium.path),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
