import 'package:movie_list/core/models/popular_actors_response.dart';

abstract class PopularActorsState {}

class PopularActorsInitial extends PopularActorsState {}

class PopularActorsLoading extends PopularActorsState {}

class PopularActorsLoaded extends PopularActorsState {
  final List<Actor> actors;

  PopularActorsLoaded({required this.actors});
}

class PopularActorsError extends PopularActorsState {
  final String message;

  PopularActorsError({required this.message});
}
