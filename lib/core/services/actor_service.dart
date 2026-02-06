import 'dart:convert';

import 'package:movie_list/core/models/popular_actors_response.dart';
import 'package:http/http.dart' as http;

class ActorService {
  final String _apiBaseUrl = "https://api.themoviedb.org/3/person";
  
  final String _apiKey = "f52455191bdf4f07b1e601ef89258db2";

  Future<List<Actor>> getPopularActors() async {
    var response = await http.get(
      Uri.parse("$_apiBaseUrl/popular?api_key=$_apiKey&language=es-ES"),
    );
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var actorsList = PopularActorsResponse.fromJson(
          json.decode(response.body),
        ).results;
        return actorsList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al obtener los actores: $e");
    }
  }
}
