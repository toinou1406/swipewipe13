import 'package:flutter/material.dart';
import '../services/deletion_service.dart';
import '../widgets/storage_indicator.dart';
import 'swipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DeletionService _deletionService = DeletionService();
  // Dummy data for total storage. In a real app, you would get this from the system.
  final double _totalStorage = 256 * 1024 * 1024 * 1024; // 256 GB
  final double _usedStorage = 128 * 1024 * 1024 * 1024; // 128 GB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StorageIndicator(
              title: 'Stockage Principal',
              value: _usedStorage,
              total: _totalStorage,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            ValueListenableBuilder<int>(
              valueListenable: _deletionService.deletedSpaceNotifier,
              builder: (context, deletedSpace, child) {
                return StorageIndicator(
                  title: 'Espace libéré ce mois-ci',
                  value: deletedSpace.toDouble(),
                  total: 5 * 1024 * 1024 * 1024, // 5 GB goal
                  color: Colors.green,
                );
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.swipe_outlined),
              label: const Text('Commencer le Tri'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SwipeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
