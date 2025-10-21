import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:sparkle/main.dart';
import 'package:sparkle/screens/albums_screen.dart';

class SparkleScreen extends StatefulWidget {
  const SparkleScreen({super.key});

  @override
  State<SparkleScreen> createState() => _SparkleScreenState();
}

class _SparkleScreenState extends State<SparkleScreen> {
  late CameraController _cameraController;
  late PageController _pageController;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    _pageController = PageController();
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildCameraPreview(),
              const AlbumsScreen(),
            ],
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return CameraPreview(_cameraController);
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: ValueListenableBuilder<int>(
        valueListenable: _currentPage,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: value == 0 ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  Icons.photo_album,
                  color: value == 1 ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
