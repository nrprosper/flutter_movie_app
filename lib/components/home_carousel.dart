import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/data/tv_series.dart';
import 'package:shimmer/shimmer.dart';
import '../common/image_cache_widget.dart';
import '../services/tmdb_service.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  late  Future<List<TvSeries>> _airingTodayFuture;

  @override
  void initState() {
    super.initState();
    _airingTodayFuture = TmdbService().getTopRated().then((response) => response.results);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _airingTodayFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error loading trending movies: ${snapshot.error}'),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 240,
                child: _buildCarousel(snapshot),
              )
            ],
          );
        }
    );
  }

  Widget _buildCarousel(AsyncSnapshot<List<TvSeries>> snapshot) {
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
          items: List.generate(5, (index) => Text("Loading")),
        ),
      );
    }

    final movies = snapshot.data!;
    return CarouselSlider(
        options: CarouselOptions(
          height: 240.0,
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 15),
          aspectRatio: 20 / 9,
          enableInfiniteScroll: true,
          viewportFraction: 1,
        ),
        items: movies.map((movie) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Hero(
                    tag: movie.id,
                    child: TmdbImage(
                      imagePath: movie.posterPath,
                      width: double.infinity,
                      height: double.infinity,
                    )
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
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        movie.originalName,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );

        }).toList(),
    );
  }

}
