import 'package:flutter/material.dart';

class StorageBar extends StatelessWidget {
  final double totalSpace; // in GB
  final double usedSpace;
  final double freedSpace;

  const StorageBar({
    super.key,
    required this.totalSpace,
    required this.usedSpace,
    required this.freedSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressBar(
          value: usedSpace / totalSpace,
          label: '${usedSpace.toStringAsFixed(1)} GB / ${totalSpace.toStringAsFixed(1)} GB',
          color: Colors.white,
          context: context,
        ),
        const SizedBox(height: 8),
        _buildProgressBar(
          value: freedSpace / totalSpace,
          label: '+${freedSpace.toStringAsFixed(1)} GB freed this month',
          color: Colors.grey[500]!,
          context: context,
        ),
      ],
    );
  }

  Widget _buildProgressBar({
    required double value,
    required String label,
    required Color color,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: const Color(0xFF333333),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 10,
        ),
      ],
    );
  }
}
