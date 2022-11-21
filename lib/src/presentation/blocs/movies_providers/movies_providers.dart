// ignore: library_prefixes
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';

import '../../../domain/repositories/movie_repository/movies_repository.dart';

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
    final moviesList = await MoviesRepository().fetchMovies();

    final movies = moviesList.map((m) => MovieModel.fromJson(m)).toList();
    state = state.copyWith(movies: movies, isLoading: false);
  }

  Future<MovieModel> loadMovie(id) async {
    final movieData = await MoviesRepository().fetchMovie(id);
    final movie = MovieModel.fromJson(movieData);
    return movie;
  }

  filterMovies(filter) async {
    state = state.copyWith(isLoading: true);

    final moviesList = await MoviesRepository().fetchMovies(filter);
    final movies = moviesList.map((e) => MovieModel.fromJson(e)).toList();
    state = state.copyWith(movies: movies, isLoading: false);
  }

  updateMovie(id, movieSourceData) async {
    final movieToJson =
        await MoviesRepository().updateMovie(id, movieSourceData);
    final movie = MovieModel.fromJson(movieToJson);
    final index = state.movies.indexWhere((element) => element.id == movie.id);
    final movies = List<MovieModel>.from(state.movies);
    movies[index] = movie;

    state = state.copyWith(movies: movies, isLoading: false);
  }

  deleteMovie(id) async {
    // final movieToJson = await MoviesRepository().deleteMovie(id);

    final index = state.movies.indexWhere((element) => element.id == id);
    final movies = List<MovieModel>.from(state.movies);
    movies.removeAt(index);
    state = state.copyWith(movies: movies, isLoading: false);
  }
}
