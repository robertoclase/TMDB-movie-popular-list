import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/core/bloc/popular_actors_event.dart';
import 'package:movie_list/core/bloc/popular_actors_state.dart';
import 'package:movie_list/core/services/actor_service.dart';

class PopularActorsBloc extends Bloc<PopularActorsEvent, PopularActorsState> {
  final ActorService actorService;

  PopularActorsBloc({required this.actorService}) : super(PopularActorsInitial()) {
    on<LoadPopularActors>(_onLoadPopularActors);
    on<RefreshPopularActors>(_onRefreshPopularActors);
  }

  Future<void> _onLoadPopularActors(
    LoadPopularActors event,
    Emitter<PopularActorsState> emit,
  ) async {
    emit(PopularActorsLoading());
    try {
      final actors = await actorService.getPopularActors();
      emit(PopularActorsLoaded(actors: actors));
    } catch (e) {
      emit(PopularActorsError(message: e.toString()));
    }
  }

  Future<void> _onRefreshPopularActors(
    RefreshPopularActors event,
    Emitter<PopularActorsState> emit,
  ) async {
    try {
      final actors = await actorService.getPopularActors();
      emit(PopularActorsLoaded(actors: actors));
    } catch (e) {
      emit(PopularActorsError(message: e.toString()));
    }
  }
}
