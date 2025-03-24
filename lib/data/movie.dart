import 'media.dart';

class Movie extends Media {
  final String originalTitle;
  final String title;
  final String? releaseDate;
  final bool video;

  Movie({
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
    required this.originalTitle,
    required this.title,
    this.releaseDate,
    required this.video,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'],
      originalLanguage: json['original_language'] ?? 'en',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      originalTitle: json['original_title'] ?? '',
      title: json['title'] ?? '',
      releaseDate: json['release_date'],
      video: json['video'] ?? false,
    );
  }

}