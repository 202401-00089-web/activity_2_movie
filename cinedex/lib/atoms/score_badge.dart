import 'package:flutter/material.dart';

// Rotten Tomatoes score: green when 75+, orange otherwise.
class ScoreBadge extends StatelessWidget {
  final int score;

  const ScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: score >= 75 ? Colors.green.shade700 : Colors.orange.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '🍅 $score%',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
