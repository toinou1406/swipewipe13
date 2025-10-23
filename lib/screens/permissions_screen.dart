
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatelessWidget {
  final VoidCallback onPermissionGranted;

  const PermissionsScreen({super.key, required this.onPermissionGranted});

  Future<void> _requestPermission(BuildContext context) async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      onPermissionGranted();
    } else if (status.isPermanentlyDenied) {
      // The user opted to never ask again
      // Open app settings
      openAppSettings();
    } else {
      // The user denied, but not permanently
      // You can show a dialog explaining why you need the permission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('L'accès aux photos est nécessaire pour utiliser cette fonctionnalité.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.photo_library_outlined,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                'Accès à votre galerie photos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Pour vous aider à trier, gérer et nettoyer votre galerie, notre application a besoin d\'un accès à vos photos.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _requestPermission(context),
                child: const Text('Autoriser l'accès'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
