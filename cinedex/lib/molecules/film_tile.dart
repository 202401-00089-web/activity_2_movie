import 'package:flutter/material.dart';
import '../atoms/cine_text.dart';
import '../atoms/poster_image.dart';
import '../atoms/score_badge.dart';
import '../models/film.dart';

class FilmTile extends StatelessWidget {
  final Film film;

  const FilmTile({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: PosterImage(url: film.posterUrl, width: 56, height: 84),
      ),
      title: CineText(film.title, bold: true, maxLines: 2),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: CineText(
          '${film.releaseYear}  •  ${film.director}  •  ${film.runningTime} min',
          size: 13,
          maxLines: 2,
        ),
      ),
      trailing: ScoreBadge(score: film.rtScore),
    );
  }
}
