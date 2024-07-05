part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class MoviesInitialFetchEvent extends MoviesEvent {}

class FetchMovieDetailsEvent extends MoviesEvent {
  final String movieId;

  FetchMovieDetailsEvent(this.movieId);
}

class FetchRecommendedEvent extends MoviesEvent {
  final String movieId;
  FetchRecommendedEvent(this.movieId);
}
