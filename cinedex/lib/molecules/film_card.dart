import 'package:flutter/material.dart';
import '../atoms/cine_text.dart';
import '../atoms/poster_image.dart';
import '../atoms/score_badge.dart';
import '../models/film.dart';

class FilmCard extends StatelessWidget {
  final Film film;

  const FilmCard({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PosterImage(url: film.bannerUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CineText(film.title, size: 20, bold: true),
                if (film.romanisedTitle.isNotEmpty)
                  CineText(film.romanisedTitle, size: 13),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ScoreBadge(score: film.rtScore),
                    const SizedBox(width: 8),
                    CineText('${film.releaseYear}  •  ${film.runningTime} min',
                        size: 13),
                  ],
                ),
                const SizedBox(height: 8),
                CineText('Directed by ${film.director}', size: 13, bold: true),
                const SizedBox(height: 8),
                CineText(film.description, size: 13, maxLines: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
