import 'media.dart';

class TvSeries extends Media {
  final String name;
  final String originalName;
  final String? firstAirDate;
  final List<String> originCountry;

  TvSeries({
    required super.adult,
    super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    super.mediaType,
    required super.voteAverage,
    required super.voteCount,
    required this.name,
    required this.originalName,
    this.firstAirDate,
    required this.originCountry,
  });

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'],
      originalLanguage: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      firstAirDate: json['first_air_date'],
      originCountry: List<String>.from(json['origin_country'] ?? []),
    );
  }
}