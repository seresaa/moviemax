import 'package:flutter/material.dart';
import 'package:moviemax/features/home/movieDetails.dart';
import 'package:moviemax/features/splash_screen/splash_screen.dart';
import '../features/home/homeView.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    routes: [
    GoRoute(
        name: 'SplashScreen',
        path: '/',
        builder: (context, state) => SplashScreen()),
    GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) {
          return HomeView();
        },
        routes: [
          GoRoute(
            name: 'movieDetails',
            path: 'movieDetails/:movieId',
            builder: (context, state) {
              final movieId = state.pathParameters['movieId']!;
              return MovieDetails(movieId: movieId);
            },
          ),
        ]),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
