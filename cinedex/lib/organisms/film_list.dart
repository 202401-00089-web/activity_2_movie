import 'package:flutter/material.dart';
import '../models/film.dart';
import '../molecules/film_tile.dart';

class FilmList extends StatelessWidget {
  final List<Film> films;

  const FilmList({super.key, required this.films});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: films.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) => FilmTile(film: films[index]),
    );
  }
}
