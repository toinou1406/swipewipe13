import 'package:flutter/material.dart';

class StorageBar extends StatelessWidget {
  final double totalSpace;
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
    final double usedPercentage = usedSpace / totalSpace;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Storage'),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: usedPercentage,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${usedSpace.toStringAsFixed(1)} GB of ${totalSpace.toStringAsFixed(0)} GB used'),
            Text('${freedSpace.toStringAsFixed(1)} GB freed'),
          ],
        ),
      ],
    );
  }
}
