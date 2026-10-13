import 'package:flutter/material.dart';
import '../atoms/cine_text.dart';
import '../atoms/live_badge.dart';
import '../models/film.dart';
import '../molecules/film_card.dart';

class FilmShowcase extends StatelessWidget {
  final Film film;
  final int updateCount;

  const FilmShowcase({super.key, required this.film, required this.updateCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LiveBadge(),
          const SizedBox(height: 12),
          FilmCard(film: film),
          const SizedBox(height: 12),
          CineText('Movie #$updateCount  •  new movie every 5 seconds', size: 13),
        ],
      ),
    );
  }
}
