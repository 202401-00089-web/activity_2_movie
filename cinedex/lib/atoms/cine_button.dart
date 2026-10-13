import 'package:flutter/material.dart';

class CineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CineButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      label: Text(label),
    );
  }
}
