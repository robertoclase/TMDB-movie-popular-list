import 'package:movie_list/core/models/movies_list_popular_response.dart';
import 'package:movie_list/core/services/movie_service.dart';

abstract class MoviesListInterface {
  Future<List<Movie>> getList(MovieListType listType);
}
