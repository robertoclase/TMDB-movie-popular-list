import 'dart:convert';

import 'package:movie_list/core/interfaces/movies_list_interface.dart';
import 'package:movie_list/core/models/movies_list_popular_response.dart';
import 'package:http/http.dart' as http;

enum MovieListType {
  popular("popular"),
  topRated("top_rated"),
  nowPlaying("now_playing"),
  upcoming("upcoming");

  final String value;
  const MovieListType(this.value);
}

class MovieService implements MoviesListInterface {
  final String _apiBaseUrl = "https://api.themoviedb.org/3/movie";
  
  final String _apiKey = "f52455191bdf4f07b1e601ef89258db2";

  @override
  Future<List<Movie>> getList(MovieListType listType) async {
    var response = await http.get(
      Uri.parse("$_apiBaseUrl/${listType.value}?api_key=$_apiKey&language=es-ES"),
    );
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var moviesList = MovieListPopularResponse.fromJson(
          json.decode(response.body),
        ).results;
        return moviesList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al obtener las películas: $e");
    }
  }
}
