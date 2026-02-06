import 'package:movie_list/core/models/movies_list_popular_response.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;

  PopularMoviesLoaded({required this.movies});
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError({required this.message});
}
