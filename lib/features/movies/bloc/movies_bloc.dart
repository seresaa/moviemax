// lib/bloc/movies_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../models/movie_list_model.dart';
import '../repos/movie_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  MoviesBloc(this.movieRepository) : super(MoviesInitial()) {
    on<MoviesInitialFetchEvent>(_onMoviesInitialFetch);
    on<FetchMovieDetailsEvent>(_onFetchMovieDetails);
  }

  Future<void> _onMoviesInitialFetch(
      MoviesInitialFetchEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    try {
      final trendingMovies = await movieRepository.fetchTrendingMovies();
      final topRatedMovies = await movieRepository.fetchTopRatedMovies();
      final upcomingMovies = await movieRepository.fetchUpcomingMovies();
      emit(MoviesLoaded(
          trendingMovies: trendingMovies,
          topRatedMovies: topRatedMovies,
          upcomingMovies: upcomingMovies));
    } on DioError catch (exc) {
      emit(MoviesError(exc.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> _onFetchMovieDetails(
      FetchMovieDetailsEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    try {
      final movie = await movieRepository.fetchMovieDetails(event.movieId);
      final recoMovie = await movieRepository.fetchRecommended(event.movieId);
      emit(MovieDetailsLoaded(movie, recoMovie));
    } on DioError catch (exc) {
      emit(MoviesError(exc.message ?? 'An unknown error occurred'));
    }
  }
}
