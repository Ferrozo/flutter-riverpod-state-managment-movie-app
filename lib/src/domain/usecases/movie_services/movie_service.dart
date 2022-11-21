import 'dart:convert';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

class MovieService {
  Future<List<dynamic>> fetchMovies() async {
    await Future.delayed(const Duration(seconds: 1));
    final moviesData = await rootBundle.rootBundle
        .loadString('lib/src/data/datasources/local/movies.json');

    return json.decode(moviesData) as List<dynamic>;
  }
}
