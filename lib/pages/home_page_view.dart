import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/core/bloc/popular_movies_bloc.dart';
import 'package:movie_list/core/bloc/popular_movies_event.dart';
import 'package:movie_list/core/bloc/popular_movies_state.dart';
import 'package:movie_list/core/bloc/popular_actors_bloc.dart';
import 'package:movie_list/core/bloc/popular_actors_event.dart';
import 'package:movie_list/core/bloc/popular_actors_state.dart';
import 'package:movie_list/core/models/movies_list_popular_response.dart';
import 'package:movie_list/core/models/popular_actors_response.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB Movies'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Películas Populares'),
            _buildPopularMoviesList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Actores Populares'),
            _buildPopularActorsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPopularMoviesList() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PopularMoviesLoaded) {
          return SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return _buildMovieCard(state.movies[index]);
              },
            ),
          );
        } else if (state is PopularMoviesError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PopularMoviesBloc>().add(LoadPopularMovies());
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(
          height: 200,
          child: Center(child: Text('Cargando películas...')),
        );
      },
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: movie.posterPath != null
                ? Image.network(
                    movie.fullPosterPath,
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 50),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        width: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 200,
                    width: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, size: 50),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularActorsList() {
    return BlocBuilder<PopularActorsBloc, PopularActorsState>(
      builder: (context, state) {
        if (state is PopularActorsLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PopularActorsLoaded) {
          return SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.actors.length,
              itemBuilder: (context, index) {
                return _buildActorCard(state.actors[index]);
              },
            ),
          );
        } else if (state is PopularActorsError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PopularActorsBloc>().add(LoadPopularActors());
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(
          height: 200,
          child: Center(child: Text('Cargando actores...')),
        );
      },
    );
  }

  Widget _buildActorCard(Actor actor) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: actor.profilePath != null
                ? Image.network(
                    actor.fullProfilePath,
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, size: 50),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        width: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 200,
                    width: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 50),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            actor.knownForDepartment,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
