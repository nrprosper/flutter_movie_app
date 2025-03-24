import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/data/media.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../common/image_cache_widget.dart';
import '../data/movie.dart';
import '../services/tmdb_service.dart';

class TrendingFeature extends StatefulWidget {
  const TrendingFeature({super.key});

  @override
  State<TrendingFeature> createState() => _TrendingFeatureState();
}

class _TrendingFeatureState extends State<TrendingFeature> {
  late Future<List<Movie>> _trendingMoviesFuture;
  late Future<List<Media>> _trendingAll;

  @override
  void initState() {
    super.initState();
    _trendingMoviesFuture = TmdbService().getTrendingMovies().then((response) => response.results);
    _trendingAll = TmdbService().getTrendingAll().then((response) => response.results);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _trendingMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error loading trending movies: ${snapshot.error}'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                "Trending Movies",
                style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 440.0,
              child: _buildCarousel(snapshot),
            )
          ],
        );
      },
    );
  }

  Widget _buildCarousel(AsyncSnapshot<List<Movie>> snapshot) {
    if (!snapshot.hasData) {
      return Shimmer.fromColors(
        baseColor: Colors.black26,
        highlightColor: Colors.black12,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 440.0,
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
          ),
          items: List.generate(5, (index) => _buildShimmerItem()),
        ),
      );
    }

    final movies = snapshot.data!;
    return CarouselSlider(
      options: CarouselOptions(
        height: 440.0,
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: movies.map((movie) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie,)))
            },
            child: Stack(
              children: [
                TmdbImage(
                  imagePath: movie.posterPath,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${movie.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 24,
                        child: ColoredBox(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 100,
                        height: 16,
                        child: ColoredBox(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}