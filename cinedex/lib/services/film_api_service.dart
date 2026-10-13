import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/film.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class FilmApiService {
  static const _baseUrl = 'https://ghibliapi.vercel.app';
  static const _timeout = Duration(seconds: 10);

  // One place for: request + timeout + status code check + JSON decode.
  Future<dynamic> _get(String path) async {
    final http.Response response;
    try {
      response = await http.get(Uri.parse('$_baseUrl$path')).timeout(_timeout);
    } on TimeoutException {
      throw ApiException('The request timed out. Please try again.');
    } catch (_) {
      throw ApiException('No internet connection.');
    }

    if (response.statusCode != 200) {
      throw ApiException('Server error (${response.statusCode}).');
    }

    try {
      return jsonDecode(response.body);
    } catch (_) {
      throw ApiException('Could not read the server response.');
    }
  }

  // SCREEN 1 (Future): the whole movie library, fetched once.
  Future<List<Film>> fetchFilms() async {
    final json = await _get('/films');
    try {
      return (json as List)
          .map((e) => Film.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw ApiException('Could not read the movie list.');
    }
  }

  Future<Film> fetchFilm(String id) async {
    final json = await _get('/films/$id');
    try {
      return Film.fromJson(json as Map<String, dynamic>);
    } catch (_) {
      throw ApiException('Could not read the movie data.');
    }
  }

  // SCREEN 2 (Stream): a different random movie every few seconds.
  // A failed fetch uses addError, so the stream keeps going afterwards.
  Stream<Film> nowShowingStream({Duration every = const Duration(seconds: 5)}) {
    late StreamController<Film> controller;
    Timer? timer;
    final random = Random();
    List<String> ids = [];
    String? lastId;

    Future<void> tick() async {
      try {
        if (ids.isEmpty) {
          final films = await fetchFilms();
          ids = films.map((f) => f.id).toList();
        }
        if (ids.isEmpty) throw ApiException('No movies available.');

        var id = ids[random.nextInt(ids.length)];
        while (ids.length > 1 && id == lastId) {
          id = ids[random.nextInt(ids.length)];
        }
        final film = await fetchFilm(id);
        lastId = id;
        if (!controller.isClosed) controller.add(film);
      } catch (e) {
        if (!controller.isClosed) controller.addError(e);
      }
    }

    controller = StreamController<Film>(
      onListen: () {
        tick();
        timer = Timer.periodic(every, (_) => tick());
      },
      onCancel: () {
        timer?.cancel();
        controller.close();
      },
    );
    return controller.stream;
  }
}
