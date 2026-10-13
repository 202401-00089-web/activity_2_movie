import 'package:flutter/material.dart';

class LiveBadge extends StatelessWidget {
  const LiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: Colors.red, size: 12),
        SizedBox(width: 6),
        Text('NOW SHOWING', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
