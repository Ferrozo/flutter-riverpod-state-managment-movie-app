// ignore: library_prefixes
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';

import '../../../domain/usecases/movie_services/movie_service.dart';

part 'movies_providers.freezed.dart';

@freezed
abstract class MovieState with _$MovieState {
  const factory MovieState({
    @Default([]) List<MovieModel> movies,
    @Default(true) bool isLoading,
  }) = _MovieState;

  const MovieState._();
}

final moviesProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) => MovieNotifier());

class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier() : super(const MovieState()) {
    loadMovies();
  }

  loadMovies() async {
    state = state.copyWith(isLoading: true);
    final moviesList = await MovieService().fetchMovies();

    final movies = moviesList.map((m) => MovieModel.fromJson(m)).toList();
    state = state.copyWith(movies: movies, isLoading: false);
  }

  filterMovies(filter) async {
    state = state.copyWith(isLoading: true);

    final moviesList = await MovieService().fetchMovies();
    final movies = moviesList
        .map((movie) => MovieModel.fromJson(movie))
        .toList()
        .where((movie) =>
            movie.title!.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    state = state.copyWith(movies: movies, isLoading: false);
  }
}
