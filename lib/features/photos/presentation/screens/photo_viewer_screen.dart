import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_clean/features/photos/data/services/photo_service.dart';

class PhotoViewerScreen extends StatefulWidget {
  final List<AssetEntity> photos;
  final int initialIndex;

  const PhotoViewerScreen({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late int currentIndex;
  final List<AssetEntity> _photosToDelete = [];
  final PhotoService _photoService = PhotoService();
  double _dragPosition = 0.0;
  AssetEntity? _lastSwipedPhoto;
  bool _lastSwipeWasDelete = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _handleSwipe(bool keep) {
    _lastSwipedPhoto = widget.photos[currentIndex];
    _lastSwipeWasDelete = !keep;

    if (!keep) {
      _photosToDelete.add(widget.photos[currentIndex]);
    }

    if (currentIndex < widget.photos.length - 1) {
      setState(() {
        currentIndex++;
        _dragPosition = 0.0;
      });
    } else {
      _showDeleteConfirmation();
    }
  }

  void _undoLastSwipe() {
    if (_lastSwipedPhoto != null) {
      setState(() {
        if (currentIndex > 0) {
          currentIndex--;
        }
        if (_lastSwipeWasDelete) {
          _photosToDelete.remove(_lastSwipedPhoto);
        }
        _lastSwipedPhoto = null;
        _dragPosition = 0.0;
      });
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('You have marked ${_photosToDelete.length} photos for deletion. Do you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _photoService.deletePhotos(_photosToDelete);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe to Clean'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _lastSwipedPhoto != null ? _undoLastSwipe : null,
            tooltip: 'Undo Last Swipe',
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _dragPosition += details.delta.dx;
          });
        },
        onHorizontalDragEnd: (details) {
          if (_dragPosition.abs() > 100) {
            if (_dragPosition > 0) {
              _handleSwipe(true); // Keep
            } else {
              _handleSwipe(false); // Delete
            }
          } else {
            setState(() {
              _dragPosition = 0.0;
            });
          }
        },
        child: Stack(
          children: [
            Center(
              child: AssetEntityImage(
                widget.photos[currentIndex],
                fit: BoxFit.contain,
              ),
            ),
            if (_dragPosition != 0)
              Positioned.fill(
                child: Container(
                  color: _dragPosition > 0 ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                  child: Icon(
                    _dragPosition > 0 ? Icons.check : Icons.delete,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
