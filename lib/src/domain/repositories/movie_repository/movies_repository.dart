// ignore_for_file: use_rethrow_when_possible
// ignore: library_prefixes
import 'dart:convert';

import 'package:dio/dio.dart';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

class MoviesRepository {
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://637ae6c010a6f23f7f9abf67.mockapi.io',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
    ),
  );

  Future<List<dynamic>> fetchMovies([filter = '']) async {
    await Future.delayed(const Duration(seconds: 1));
    final moviesData = await _dio.get('/movies?Title=$filter');

    return moviesData.data;
  }

  Future<dynamic> fetchMovie(id) async {
    final moviesData = await _dio.get('/movies/$id');
    return moviesData.data;
  }

  Future<List<dynamic>> fetchLocalMovies() async {
    await Future.delayed(const Duration(seconds: 1));
    final moviesData = await rootBundle.rootBundle
        .loadString('lib/src/data/datasources/local/movies.json');

    return json.decode(moviesData) as List<dynamic>;
  }

  updateMovie(id, movieDataSource) async {
    try {
      final response = await _dio.put(
        '/movies/$id',
        data: movieDataSource,
      );

      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e.toString();
    }
  }

  deleteMovie(id) async {
    try {
      final response = await _dio.delete('/movies/$id');
      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e.toString();
    }
  }
}
