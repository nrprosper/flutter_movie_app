import 'package:movie_app/data/production_spoken_language.dart';

import 'genre.dart';
import 'movie/collection.dart';
import 'movie/production_company.dart';

class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final Collection? belongsToCollection;
  final int? budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String? status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetails({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    required this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    required this.spokenLanguages,
    this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      belongsToCollection: json['belongs_to_collection'] != null
          ? Collection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json['budget'],
      genres: (json['genres'] as List)
          .map((genre) => Genre.fromJson(genre))
          .toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'])
          : null,
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity']?.toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: (json['production_companies'] as List)
          .map((company) => ProductionCompany.fromJson(company))
          .toList(),
      productionCountries: (json['production_countries'] as List)
          .map((country) => ProductionCountry.fromJson(country))
          .toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List)
          .map((lang) => SpokenLanguage.fromJson(lang))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'] ?? false,
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }
}