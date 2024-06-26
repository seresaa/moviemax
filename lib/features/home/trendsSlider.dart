import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:moviemax/features/movies/mappers/movie_list_model.dart';
import 'package:moviemax/features/movies/constants/api_constants.dart';

class TrendsSLider extends StatefulWidget {
  final List<MovieListModel> movies;
  const TrendsSLider({super.key, required this.movies});

  @override
  State<TrendsSLider> createState() => _TrendsSLiderState();
}

class _TrendsSLiderState extends State<TrendsSLider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: widget.movies.length,
          itemBuilder: (context, index, _) {
            final movie = widget.movies[index];
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '${ImgConstants.imgPath}${movie.poster_path}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                context.go('/home/movieDetails/${movie.id}');
              },
            );
          },
          options: CarouselOptions(
              height: 325,
              autoPlay: true,
              viewportFraction: 0.50,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enlargeCenterPage: true,
              pageSnapping: true)),
    );
  }
}
