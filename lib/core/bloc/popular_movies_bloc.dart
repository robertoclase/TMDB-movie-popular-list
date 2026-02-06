import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/core/bloc/popular_movies_event.dart';
import 'package:movie_list/core/bloc/popular_movies_state.dart';
import 'package:movie_list/core/services/movie_service.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieService movieService;

  PopularMoviesBloc({required this.movieService}) : super(PopularMoviesInitial()) {
    on<LoadPopularMovies>(_onLoadPopularMovies);
    on<RefreshPopularMovies>(_onRefreshPopularMovies);
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    try {
      final movies = await movieService.getList(MovieListType.popular);
      emit(PopularMoviesLoaded(movies: movies));
    } catch (e) {
      emit(PopularMoviesError(message: e.toString()));
    }
  }

  Future<void> _onRefreshPopularMovies(
    RefreshPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    try {
      final movies = await movieService.getList(MovieListType.popular);
      emit(PopularMoviesLoaded(movies: movies));
    } catch (e) {
      emit(PopularMoviesError(message: e.toString()));
    }
  }
}
