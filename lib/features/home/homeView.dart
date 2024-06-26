import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviemax/features/home/trendsSlider.dart';
import 'package:moviemax/features/movies/bloc/movies_bloc.dart';
import 'package:moviemax/features/movies/constants/api_constants.dart';
import 'package:moviemax/shared/colors.dart';
import 'package:moviemax/shared/custom_appbar.dart';

import '../movies/mappers/movie_list_model.dart';
import '../movies/repos/movie_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    final movieRepository = MovieRepository();
    moviesBloc = MoviesBloc(movieRepository)..add(MoviesInitialFetchEvent());
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          icon: 1,
        ),
        backgroundColor: MovieMaxColors.bgColor,
        body: BlocProvider(
          create: (context) => moviesBloc,
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MoviesLoaded) {
                return ListView(
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Trending Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MovieMaxColors.white,
                        ),
                      ),
                    ),
                    TrendsSLider(movies: state.trendingMovies),
                    _buildMovieSection(
                        'Top Rated Movies', state.topRatedMovies),
                    _buildMovieSection('Upcoming Movies', state.upcomingMovies),
                  ],
                );
              } else if (state is MoviesError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _HomeGreetings() {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Good Morning Cherry,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Find your favortite movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection(String title, List<MovieListModel> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MovieMaxColors.white,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Image.network(
                    '${ImgConstants.imgPath}${movie.poster_path}',
                    height: 250,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://x.com/themoviedb/photo',
                        height: 150,
                      );
                    },
                  ),
                  onTap: () {
                    context.go('/home/movieDetails/${movie.id}');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
