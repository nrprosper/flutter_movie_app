import 'package:flutter/material.dart';
import 'package:movie_app/common/details_shimmer.dart';
import 'package:movie_app/common/image_cache_widget.dart';
import 'package:movie_app/components/movie_item_details.dart';
import 'package:movie_app/components/recom_movie_card.dart';
import 'package:movie_app/components/recommendation.dart';
import 'package:movie_app/data/tv_details.dart';
import 'package:movie_app/data/tv_series.dart';

import '../services/tmdb_service.dart';

class TvDetailsScreen extends StatefulWidget {
  final TvSeries tv;
  const TvDetailsScreen({super.key, required this.tv});

  @override
  State<TvDetailsScreen> createState() => _TvDetailsScreenState();
}

class _TvDetailsScreenState extends State<TvDetailsScreen> {
  late final Future<TvDetails> _tvDetailsFuture;
  late final Future<List<TvSeries>> _tvRecommsFuture;

  @override
  void initState() {
    super.initState();
    _tvDetailsFuture = TmdbService().getTvDetails(widget.tv.id);
    _tvRecommsFuture = TmdbService().getTvRecommendations(widget.tv.id).then((response) => response.results);
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
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: _tvDetailsFuture,
              builder: (context, snapshot){
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Error loading tv details: ${snapshot.error}'),
                    ),
                  );
                }
                return _buildTvDetails(snapshot);
              }
          ),
        ),
      ),
    );
  }


  Widget _buildTvDetails(AsyncSnapshot<TvDetails> snapshot) {
    if (!snapshot.hasData) {
      return DetailsShimmer();
    }

    final details = snapshot.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
            tag: details.id,
            child: TmdbImage(
                imagePath: details.backdropPath ?? details.posterPath,
                width: double.infinity,
                height: 400.0,
                fit: BoxFit.cover
            )
        ),
        MovieItemDetails(
            title: details.originalName,
            genres: details.genres,
            originCountry: details.originCountry,
            releaseDate: details.firstAirDate,
            voteAverage: details.voteAverage,
            overview: details.overview!,
            isAdult: details.adult,
            isMovie: false,
        ),
        Recommendation<TvSeries>(
            future: _tvRecommsFuture,
            title: "Recommendation",
            itemBuilder: (context, tv) => RecomMovieCard(tv: tv)
        ),
        SizedBox(height: 20),
      ],
    );
  }

}
