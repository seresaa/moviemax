// lib/repository/movie_repository.dart

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../mappers/movie_list_model.dart';

class MovieRepository {
  final Dio _dio = Dio();

  Future<List<MovieListModel>> fetchTrendingMovies() async {
    final response = await _dio.get(getTrendingUrl());
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<List<MovieListModel>> fetchTopRatedMovies() async {
    final response = await _dio.get(getTopRatedUrl());
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<List<MovieListModel>> fetchUpcomingMovies() async {
    final response = await _dio.get(getUpcomingUrl());
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<MovieListModel> fetchMovieDetails(String movieId) async {
    final response =
        await _dio.get('$baseUrl/3/movie/$movieId?api_key=$myApiKey');
    return MovieListModel.fromJson(response.data);
  }
}
