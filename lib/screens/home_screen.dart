import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:storage_space/storage_space.dart';
import 'package:myapp/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _totalSpace = 0;
  double _freeSpace = 0;
  double _usedSpace = 0;
  final double _cleanedSpaceThisMonth = 15.2; // Mock data for now

  @override
  void initState() {
    super.initState();
    _initStorageSpace();
  }

  Future<void> _initStorageSpace() async {
    try {
      StorageSpace storageSpace = await getStorageSpace(
        lowOnSpaceThreshold: 0,
        fractionDigits: 2,
      );
      setState(() {
        _totalSpace = storageSpace.totalSize;
        _freeSpace = storageSpace.freeSize;
        _usedSpace = _totalSpace - _freeSpace;
      });
    } catch (e) {
      print('Error getting storage space: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final progressColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? const Color(0xFF333333) : const Color(0xFFE0E0E0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.photo_album),
            onPressed: () => context.go('/albums'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Stockage de l'appareil',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildStorageIndicator(
              'Stockage total',
              _usedSpace,
              _totalSpace,
              '${_usedSpace.toStringAsFixed(2)} Go utilisés sur ${_totalSpace.toStringAsFixed(2)} Go',
              progressColor,
              backgroundColor,
            ),
            const SizedBox(height: 32),
            _buildStorageIndicator(
              'Espace libéré ce mois-ci',
              _cleanedSpaceThisMonth,
              _totalSpace, // Using total space as a reference for now
              '${_cleanedSpaceThisMonth.toStringAsFixed(2)} Go libérés',
              Colors.green,
              backgroundColor,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/swipe'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Commencer le Swipe'),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageIndicator(
    String title,
    double value,
    double total,
    String subtitle,
    Color progressColor,
    Color backgroundColor,
  ) {
    double percent = total > 0 ? value / total : 0;
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        LinearPercentIndicator(
          percent: percent,
          lineHeight: 12.0,
          barRadius: const Radius.circular(6),
          progressColor: progressColor,
          backgroundColor: backgroundColor,
        ),
        const SizedBox(height: 8),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
