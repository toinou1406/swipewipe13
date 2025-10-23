import 'package:flutter/material.dart';

class StorageIndicator extends StatelessWidget {
  final String title;
  final double value;
  final double total;
  final Color color;

  const StorageIndicator({
    super.key,
    required this.title,
    required this.value,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
          backgroundColor: color.withAlpha(51),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(value / 1024 / 1024).toStringAsFixed(2)} MB'),
            Text('${(total / 1024 / 1024).toStringAsFixed(2)} MB'),
          ],
        )
      ],
    );
  }
}
