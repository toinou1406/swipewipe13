import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final String label;

  const ProgressBar({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: value,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ],
    );
  }
}
