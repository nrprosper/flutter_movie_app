import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/common/image_cache_widget.dart';
import 'package:movie_app/components/badge_pill.dart';
import 'package:movie_app/components/recom_movie_card.dart';
import 'package:movie_app/data/movie_details.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = TmdbService().getMovieDetails(widget.movie.id);
    _recommendationFuture = TmdbService().getRecommendedMovies(widget.movie.id).then((response) => response.results);
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
}


Widget _buildMovieDetails(BuildContext context, AsyncSnapshot<MovieDetails> snapshot, Future<List<Movie>> movieRecomms) {
  if (!snapshot.hasData) {
    return _buildDetailsShimmer();
  }

  final details = snapshot.data!;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Hero(
          tag: details.id,
          child: TmdbImage(
              imagePath: details.backdropPath,
              width: double.infinity,
              height: 400.0,
              fit: BoxFit.cover
          )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    details.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600
                    ),
                )),
                BadgePill(text: details.adult ? '18+' : '13+')
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.2,
                    color: MColors.darkGrey
                  )
                )
              ),
              child: Row(
                spacing: 32,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.access_time, size: 14),
                      Text(
                        "152 Minutes",
                        style: TextStyle(
                            color: MColors.grey,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  SelectableText('${details.id}'),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.star, size: 14),
                      Text(
                          '${details.voteAverage.toStringAsFixed(1)}/10',
                          style: TextStyle(
                              color: MColors.grey,
                              fontWeight: FontWeight.w600
                          )
                      )
                    ],
                  )
                ],
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5,
                          color: MColors.darkGrey
                      )
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 32,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                          "Release Date",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600
                          )
                      ),
                      Text(
                        '${details.releaseDate}'
                      )
                    ],
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                              "Genres",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: details.genres.map((genre) {
                              return BadgePill(text: genre.name);
                            }).toList(),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Synopsis",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  SizedBox(height:12),
                  Text(
                    details.overview!,
                      style: TextStyle(
                          fontSize: 14,
                          color: MColors.grey,
                          fontWeight: FontWeight.w500
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              "Recommendation",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<Movie>>(
            future: movieRecomms,
            builder: (context, snapshot) {
              if (snapshot.hasError) return const SizedBox.shrink();

              if (!snapshot.hasData) {
                return _buildRecommendationShimmer();
              }

              final recommendations = snapshot.data!;
              return SizedBox(
                height: 180,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendations.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, index) {
                    final movie = recommendations[index];
                    return RecomMovieCard(movie: movie);
                  },
                ),
              );
            },
          ),
        ],
      ),
      SizedBox(height: 80),
    ],
  );
}

Widget _buildRecommendationShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.grey,
    child: SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, index) => SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 12,
                color: Colors.black26,
              ),
              const SizedBox(height: 4),
              Container(
                width: 80,
                height: 12,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget _buildDetailsShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.grey,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster Shimmer
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 24),

          // Title Shimmer
          Container(
            width: 200,
            height: 28,
            color: Colors.black26,
          ),
          const SizedBox(height: 16),

          // Runtime and Rating Row
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                color: Colors.black26,
              ),
              const SizedBox(width: 16),
              Container(
                width: 100,
                height: 20,
                color: Colors.black26,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Release Date
          Container(
            width: 150,
            height: 18,
            color: Colors.black26,
          ),
          const SizedBox(height: 12),

          // Genres
          Wrap(
            spacing: 8,
            children: List.generate(2, (index) => Container(
              width: 60,
              height: 20,
              color: Colors.black26,
            )),
          ),
          const SizedBox(height: 24),

          // Synopsis Header
          Container(
            width: 80,
            height: 22,
            color: Colors.black26,
          ),
          const SizedBox(height: 12),

          // Synopsis Text Lines
          Column(
            children: List.generate(4, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.infinity,
                height: 16,
                color: Colors.black26,
              ),
            )),
          ),
          const SizedBox(height: 24),

          // Related Movies Header
          Container(
            width: 120,
            height: 22,
            color: Colors.black26,
          ),
          const SizedBox(height: 16),

          // Related Movies List
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) => Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}