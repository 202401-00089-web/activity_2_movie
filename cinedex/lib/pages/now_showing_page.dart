import 'package:flutter/material.dart';
import '../models/film.dart';
import '../molecules/loading_message.dart';
import '../molecules/status_message.dart';
import '../organisms/film_showcase.dart';
import '../services/film_api_service.dart';
import '../templates/screen_template.dart';

// SCREEN 2: StreamBuilder
class NowShowingPage extends StatefulWidget {
  const NowShowingPage({super.key});

  @override
  State<NowShowingPage> createState() => _NowShowingPageState();
}

class _NowShowingPageState extends State<NowShowingPage> {
  final _service = FilmApiService();
  late Stream<Film> _filmStream;
  int _updates = 0;

  @override
  void initState() {
    super.initState();
    _startStream();
  }

  void _startStream() {
    _updates = 0;
    _filmStream = _service.nowShowingStream().map((film) {
      _updates++;
      return film;
    });
  }

  void _retry() {
    setState(_startStream); // new stream; the old one is cancelled
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Now Showing',
      body: StreamBuilder<Film>(
        stream: _filmStream,
        builder: (context, snapshot) {
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
          if (!snapshot.hasData) {
            return const LoadingMessage('Waiting for the next feature...');
          }
          return FilmShowcase(film: snapshot.data!, updateCount: _updates);
        },
      ),
    );
  }
}
