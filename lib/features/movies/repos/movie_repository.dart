import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants/api_constants.dart';
import '../models/movie_list_model.dart';

class MovieRepository {
  final Dio _dio = Dio();

  Future<List<MovieListModel>> fetchTrendingMovies() async {
    final response = await _dio.get(
        '${dotenv.env['BASE_URL']}/3/trending/movie/day?api_key=${dotenv.env['API_KEY']}');
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<List<MovieListModel>> fetchTopRatedMovies() async {
    final response = await _dio.get(
        '${dotenv.env['BASE_URL']}/3/movie/top_rated?api_key=${dotenv.env['API_KEY']}');
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<List<MovieListModel>> fetchUpcomingMovies() async {
    final response = await _dio.get(
        '${dotenv.env['BASE_URL']}/3/movie/upcoming?api_key=${dotenv.env['API_KEY']}');
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }

  Future<MovieListModel> fetchMovieDetails(String movieId) async {
    final response = await _dio.get(
        '${dotenv.env['BASE_URL']}/3/movie/$movieId?api_key=${dotenv.env['API_KEY']}');
    return MovieListModel.fromJson(response.data);
  }

  Future<List<MovieListModel>> fetchRecommended(String movieId) async {
    final response = await _dio.get(
        '${dotenv.env['BASE_URL']}/3/movie/${movieId}/recommendations?api_key=${dotenv.env['API_KEY']}');
    return (response.data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  }
}
