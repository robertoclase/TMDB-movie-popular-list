import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/core/bloc/popular_movies_bloc.dart';
import 'package:movie_list/core/bloc/popular_movies_event.dart';
import 'package:movie_list/core/bloc/popular_actors_bloc.dart';
import 'package:movie_list/core/bloc/popular_actors_event.dart';
import 'package:movie_list/core/services/movie_service.dart';
import 'package:movie_list/core/services/actor_service.dart';
import 'package:movie_list/pages/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PopularMoviesBloc(
              movieService: MovieService(),
            )..add(LoadPopularMovies()),
          ),
          BlocProvider(
            create: (context) => PopularActorsBloc(
              actorService: ActorService(),
            )..add(LoadPopularActors()),
          ),
        ],
        child: const HomePageView(),
      ),
    );
  }
}