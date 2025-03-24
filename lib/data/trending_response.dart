import 'package:movie_app/data/tv_series.dart';

import 'media.dart';
import 'movie.dart';

class TrendingResponse {
  final int page;
  final List<Media> results;
  final int totalPages;
  final int totalResults;

  TrendingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) {
    final resultsList = json['results'] as List<dynamic>;
    final mediaList = <Media>[];

    for (final item in resultsList) {
      final mediaType = item['media_type'];
      if (mediaType == 'movie') {
        mediaList.add(Movie.fromJson(item));
      } else if (mediaType == 'tv') {
        mediaList.add(TvSeries.fromJson(item));
      } else {
        throw UnsupportedError('Unsupported media type: $mediaType');
      }
    }

    return TrendingResponse(
      page: json['page'] ?? 1,
      results: mediaList,
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}