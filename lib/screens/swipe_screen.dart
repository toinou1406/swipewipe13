import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_gallery/photo_gallery.dart';
import '../services/deletion_service.dart';
import '../enums/swipe_direction.dart';

class SwipeScreen extends StatefulWidget {
  final bool isFromAlbum;

  const SwipeScreen({super.key, this.isFromAlbum = false});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> with TickerProviderStateMixin {
  final DeletionService _deletionService = DeletionService();
  List<Medium> _media = [];
  final List<Medium> _previousMedia = [];
  bool _isLoading = true;

  // Animation & Gesture state
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.addListener(() => setState(() {}));
    _loadMedia();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMedia() async {
    setState(() => _isLoading = true);
    try {
      final allAlbum = await PhotoGallery.listAlbums(mediumType: MediumType.image);
      if (allAlbum.isNotEmpty) {
        final mediaPage = await allAlbum.first.listMedia();
        setState(() => _media = mediaPage.items..shuffle()); // Shuffle for variety
      } 
    } catch (e) {
      debugPrint('Failed to load media: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onPanStart(DragStartDetails details) {
    _animationController.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final velocity = details.velocity.pixelsPerSecond;

    if (velocity.dx.abs() > 800 || _dragOffset.dx.abs() > screenWidth * 0.5) {
      _triggerSwipe(_dragOffset.dx > 0 ? SwipeDirection.right : SwipeDirection.left);
    } else if (velocity.dy.abs() > 800) {
       _triggerSwipe(_dragOffset.dy > 0 ? SwipeDirection.down : SwipeDirection.up);
    } else {
      _resetCardPosition();
    }
  }

  void _triggerSwipe(SwipeDirection direction) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = direction == SwipeDirection.left ? -screenWidth : (direction == SwipeDirection.right ? screenWidth : 0);
    final targetY = direction == SwipeDirection.up ? -500.0 : (direction == SwipeDirection.down ? 500.0 : 0);

    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(targetX, targetY),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward().whenComplete(() {
      _performAction(direction);
    });
  }

  void _resetCardPosition() {
     _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward().whenComplete(() => _dragOffset = Offset.zero);
  }

  void _performAction(SwipeDirection direction) {
    if (_media.isEmpty) return;

    HapticFeedback.lightImpact();
    final medium = _media.first;
    _previousMedia.add(medium);

    setState(() {
      _media.removeAt(0);
      _dragOffset = Offset.zero;
      _animationController.reset();
    });

    switch (direction) {
      case SwipeDirection.left:
        _deletePhoto(medium);
        break;
      case SwipeDirection.right: // Pass
        break;
      case SwipeDirection.up: 
        _undo();
        break;
      case SwipeDirection.down:
        _showAlbumSelection(medium);
        break;
    }
  }
  
  void _deletePhoto(Medium medium) async {
    try {
      final file = await medium.getFile();
      final size = await file.length();
      await file.delete();
      _deletionService.recordDeletion(size);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Photo supprimée définitivement.'), duration: Duration(seconds: 2)));
    } catch (e) {
      debugPrint("Failed to delete photo: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de la suppression.'), backgroundColor: Colors.red));
    }
  }

  void _showAlbumSelection(Medium medium) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Ajouter à un album', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ListTile(leading: const Icon(Icons.favorite_border), title: const Text('Favoris'), onTap: () => _addToAlbum(medium, 'Favoris')),
              ListTile(leading: const Icon(Icons.archive_outlined), title: const Text('Archives'), onTap: () => _addToAlbum(medium, 'Archives')),
              ListTile(leading: const Icon(Icons.lightbulb_outline), title: const Text('À trier'), onTap: () => _addToAlbum(medium, 'À trier')),
            ],
          ),
        );
      },
    );
  }

  void _addToAlbum(Medium medium, String albumName) {
    Navigator.of(context).pop(); // Close the bottom sheet
    debugPrint('Adding photo ${medium.id} to album $albumName');
    // In the next step, we will implement the actual logic here.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Photo ajoutée à $albumName.')));
  }

  void _undo() {
     if (_previousMedia.isEmpty) return;
    final lastMedium = _previousMedia.removeLast();
    setState(() {
      _media.insert(0, lastMedium);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dernière action annulée.'), duration: Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => Navigator.of(context).pop()),
        title: Text(widget.isFromAlbum ? 'Ajouter à l'album' : 'Trier les photos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _undo,
        tooltip: 'Annuler la dernière action',
        child: const Icon(Icons.undo),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_media.isEmpty) return const Center(child: Text('Toutes les photos ont été triées !'));
    
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardStack(),
        _buildTopCard(),
        _buildFeedbackIcons(),
      ],
    );
  }

  Widget _buildFeedbackIcons() {
    double opacity = (_dragOffset.distance / 100).clamp(0.0, 1.0);
    Widget icon = const SizedBox.shrink();

    if (_dragOffset.dx.abs() > _dragOffset.dy.abs()) {
      icon = _dragOffset.dx > 0 
        ? const Icon(Icons.check_circle_outline, color: Colors.green, size: 100)
        : const Icon(Icons.cancel_outlined, color: Colors.red, size: 100);
    } else {
      icon = _dragOffset.dy > 0
        ? const Icon(Icons.archive_outlined, color: Colors.orange, size: 100)
        : const Icon(Icons.undo, color: Colors.blue, size: 100);
    }

    return Center(
      child: Opacity(
        opacity: opacity,
        child: icon,
      ),
    );
  }

  Widget _buildCardStack() {
    if (_media.length < 2) return const SizedBox.shrink();
    return Center(
      child: FutureBuilder<File>(
        future: _media[1].getFile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          return Transform.scale(
            scale: 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.file(snapshot.data!, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.9 * 0.9),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopCard() {
    if (_media.isEmpty) return const SizedBox.shrink();
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _animationController.isAnimating ? _slideAnimation.value : _dragOffset,
        child: Center(
          child: FutureBuilder<File>(
            future: _media.first.getFile(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(snapshot.data!, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
