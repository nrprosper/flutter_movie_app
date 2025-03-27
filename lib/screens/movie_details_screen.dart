import 'package:flutter/material.dart';
import 'package:movie_app/common/details_shimmer.dart';
import 'package:movie_app/common/image_cache_widget.dart';
import 'package:movie_app/components/movie_item_details.dart';
import 'package:movie_app/components/recom_movie_card.dart';
import 'package:movie_app/components/recommendation.dart';
import 'package:movie_app/data/movie_details.dart';
import 'package:movie_app/screens/video_play_screen.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:movie_app/services/vidsrc_service.dart';

import '../data/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  late final Future<MovieDetails> _movieDetailsFuture;
  late final Future<List<Movie>> _recommendationFuture;
  late final Future<bool> _videoAvailabilityFuture;

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = TmdbService().getMovieDetails(widget.movie.id);
    _recommendationFuture = TmdbService().getRecommendedMovies(widget.movie.id).then((response) => response.results);
    _videoAvailabilityFuture = VidSrcService().isVideoAvailable(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(Icons.favorite)
          )
        ],
      ),
      body: SafeArea(
        top: false,
        // bottom: false,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _movieDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Error loading movie details: ${snapshot.error}'),
                  ),
                );
              }
              return _buildMovieDetails(context, snapshot, _recommendationFuture);
            }
        ))
    ),
    );
  }

  Widget _buildHeroImageWithPlayButton(MovieDetails details) {
    return FutureBuilder<bool>(
      future: _videoAvailabilityFuture,
      builder: (context, snapshot) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: details.id,
              child: TmdbImage(
                imagePath: details.backdropPath ?? details.posterPath,
                width: double.infinity,
                height: 400.0,
                fit: BoxFit.cover,
              ),
            ),
            if (snapshot.hasData && snapshot.data!)
              _buildVideoPlayButton(context),
          ],
        );
      },
    );
  }

  Widget _buildVideoPlayButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoPlayScreen(id: widget.movie.id))
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            size: 64,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, AsyncSnapshot<MovieDetails> snapshot, Future<List<Movie>> movieRecomms) {
    if (!snapshot.hasData) {
      return DetailsShimmer();
    }

    final details = snapshot.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroImageWithPlayButton(details),
        MovieItemDetails(
            title: details.title,
            genres: details.genres,
            originCountry: details.originCountry!,
            releaseDate: details.releaseDate!,
            voteAverage: details.voteAverage,
            overview: details.overview!,
            isAdult: details.adult,
            isMovie: true
        ),
        Recommendation(
            future: movieRecomms,
            title: "Recommendation",
            itemBuilder: (context, movie) => RecomMovieCard(movie: movie)
        ),
        SizedBox(height: 20),
      ],
    );
  }

}