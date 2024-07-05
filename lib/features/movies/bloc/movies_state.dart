// lib/bloc/movies_state.dart

part of 'movies_bloc.dart';

@immutable
abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieListModel> trendingMovies;
  final List<MovieListModel> topRatedMovies;
  final List<MovieListModel> upcomingMovies;

  const MoviesLoaded(
      {required this.trendingMovies,
      required this.topRatedMovies,
      required this.upcomingMovies});

  @override
  List<Object> get props => [trendingMovies, topRatedMovies, upcomingMovies];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailsLoaded extends MoviesState {
  final MovieListModel movie;
   final List<MovieListModel> recommendedMovies;

  const MovieDetailsLoaded(this.movie, this.recommendedMovies);

  @override
  List<Object> get props => [movie, recommendedMovies];
  
}

