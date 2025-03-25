abstract class Media {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? overview;
  final double popularity;
  final String posterPath;
  final String? mediaType;
  final double voteAverage;
  final int voteCount;

  Media({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.overview,
    required this.popularity,
    required this.posterPath,
    this.mediaType,
    required this.voteAverage,
    required this.voteCount,
  });
}