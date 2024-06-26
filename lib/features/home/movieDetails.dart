import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviemax/features/movies/bloc/movies_bloc.dart';
import 'package:moviemax/features/movies/constants/api_constants.dart';
import 'package:moviemax/features/movies/repos/movie_repository.dart';
import 'package:moviemax/shared/colors.dart';
import 'package:moviemax/shared/custom_appbar.dart';
import 'package:intl/intl.dart';
import '../movies/mappers/movie_list_model.dart';

class MovieDetails extends StatefulWidget {
  final String movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late final MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    final movieRepository = MovieRepository();
    moviesBloc = MoviesBloc(movieRepository);
    moviesBloc.add(FetchMovieDetailsEvent(widget.movieId));
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieMaxColors.bgColor,
      appBar: MyAppBar(
        icon: 2,
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Stack(children: [
        BlocProvider(
          create: (context) => moviesBloc,
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieDetailsLoaded) {
                return ListView(
                  children: [
                    _buildMovieSection(state.movie),
                    _buildSynopsisSection(state.movie),
                  ],
                );
              } else if (state is MoviesError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildMovieSection(MovieListModel movie) {
    String genres = movie.genres?.map((genre) => genre.name).join(', ') ?? ' ';
    String releaseYear = movie.release_date != null
        ? DateFormat('yyyy').format(movie.release_date!)
        : '';

    return Stack(
      children: [
        Container(
          height: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                '${ImgConstants.imgPath}${movie.backdrop_path}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width / 4,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Image.network(
                  '${ImgConstants.imgPath}${movie.poster_path}',
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 380,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${movie.vote_average?.toStringAsFixed(1) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    genres,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.circle, color: Colors.white, size: 5),
                  SizedBox(width: 16),
                  Text(
                    releaseYear,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSynopsisSection(MovieListModel movie) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            movie.overview,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
