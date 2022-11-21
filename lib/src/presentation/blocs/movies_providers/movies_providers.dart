import 'dart:convert';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';

part 'movies_providers.freezed.dart';

@freezed
abstract class MovieState with _$MovieState {
  const factory MovieState({
    @Default([]) List<MovieModel> movies,
  }) = _MovieState;

  const MovieState._();
}

final moviesProviders =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) => MovieNotifier());

class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier() : super(MovieState()) {
    loadMovies();
  }

  loadMovies() async {
    final moviesData = await rootBundle.rootBundle
        .loadString('lib/src/data/datasources/local/movies.json');
    final moviesList = json.decode(moviesData) as List<dynamic>;

    final movies = moviesList.map((m) => MovieModel.fromJson(m)).toList();
    state = state.copyWith(movies: movies);
  }

  filterMovies(filter) async {
    final moviesData = await rootBundle.rootBundle
        .loadString('lib/src/data/datasources/local/movies.json');
    final moviesList = json.decode(moviesData) as List<dynamic>;
    final movies = moviesList
        .map((m) => MovieModel.fromJson(m))
        .toList()
        .where((movie) =>
            movie.title!.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    state = state.copyWith(movies: movies);
  }
}
