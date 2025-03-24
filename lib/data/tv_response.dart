import 'package:movie_app/data/tv_series.dart';

class TvSeriesResponse {
  final int page;
  final List<TvSeries> results;
  final int totalPages;
  final int totalResults;

  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List)
          .map((series) => TvSeries.fromJson(series))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}