import 'package:flutter/material.dart';
import 'package:movie_app/components/tabs/GridShimmer.dart';
import 'package:movie_app/components/tabs/movie_item.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/movie.dart';
import '../../services/tmdb_service.dart';

class MoviesTab extends StatefulWidget {
  const MoviesTab({super.key});

  @override
  State<MoviesTab> createState() => _MoviesTabState();

}

class _MoviesTabState extends State<MoviesTab> {
  late final Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = TmdbService().getPopularMovies().then((response) => response.results);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: FutureBuilder(
          future: _moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Error loading movies: ${snapshot.error}'),
                ),
              );
            }
            return _buildMovies(snapshot);
          }
      ),
    );
  }
}


Widget _buildMovies(AsyncSnapshot<List<Movie>> snapshot) {
  if(!snapshot.hasData) {
    return Gridshimmer();
  }

  final movies = snapshot.data!;
  return GridView.builder(
    // Your actual movie grid implementation
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      mainAxisSpacing: 24,
      crossAxisSpacing: 18,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) => MovieItem(movie: movies[index]),
  );
}

