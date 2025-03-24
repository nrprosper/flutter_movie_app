class TrendingItem {
  final int id;
  final String? title;
  final String? name;
  final String? originalTitle;
  final String? originalName;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final String? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final bool? video;
  final List<String>? originCountry;

  TrendingItem({
    required this.id,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    this.video,
    this.originCountry,
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) {
    return TrendingItem(
      id: json['id'] as int,
      title: json['title'] as String?,
      name: json['name'] as String?,
      originalTitle: json['original_title'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String,
      backdropPath: json['backdrop_path'] as String,
      posterPath: json['poster_path'] as String,
      mediaType: json['media_type'] ?? 'movie',
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] as String,
      genreIds: List<int>.from(json['genre_ids'] as List),
      popularity: (json['popularity'] as num).toDouble(),
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      video: json['video'] as bool?,
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'] as List)
          : null,
    );
  }
}

class TrendingResponse {
  final int page;
  final List<TrendingItem> results;
  final int totalPages;
  final int totalResults;

  TrendingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) {
    return TrendingResponse(
      page: json['page'] as int,
      results: List<TrendingItem>.from(
          (json['results'] as List).map((item) => TrendingItem.fromJson(item))),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
