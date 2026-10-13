import 'package:flutter/material.dart';
import '../models/film.dart';
import '../molecules/loading_message.dart';
import '../molecules/status_message.dart';
import '../organisms/film_list.dart';
import '../services/film_api_service.dart';
import '../templates/screen_template.dart';

// SCREEN 1: FutureBuilder
class FilmListPage extends StatefulWidget {
  const FilmListPage({super.key});

  @override
  State<FilmListPage> createState() => _FilmListPageState();
}

class _FilmListPageState extends State<FilmListPage> {
  final _service = FilmApiService();
  late Future<List<Film>> _filmsFuture;

  @override
  void initState() {
    super.initState();
    _filmsFuture = _service.fetchFilms(); // created ONCE, not in build()
  }

  void _retry() {
    setState(() {
      _filmsFuture = _service.fetchFilms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Movie Library',
      body: FutureBuilder<List<Film>>(
        future: _filmsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingMessage('Rolling the film reels...');
          }
          if (snapshot.hasError) {
            final error = snapshot.error;
            return StatusMessage(
              icon: Icons.wifi_off,
              message: error is ApiException
                  ? error.message
                  : 'Something went wrong.',
              actionLabel: 'Retry',
              onAction: _retry,
            );
          }
          final films = snapshot.data ?? [];
          if (films.isEmpty) {
            return const StatusMessage(
              icon: Icons.movie_filter,
              message: 'No movies found.',
            );
          }
          return FilmList(films: films);
        },
      ),
    );
  }
}
