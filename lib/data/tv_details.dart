import 'package:movie_app/data/production_spoken_language.dart';
import 'package:movie_app/data/tv/created_by.dart';
import 'package:movie_app/data/tv/episode.dart';
import 'package:movie_app/data/tv/network.dart';
import 'package:movie_app/data/tv/season.dart';

import 'genre.dart';
import 'media.dart';

class TvDetails extends Media {
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final Episode? lastEpisodeToAir;
  final Episode? nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalName;
  final List<Network> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;

  TvDetails({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    super.mediaType,
    required super.voteAverage,
    required super.voteCount,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalName,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
  });

  factory TvDetails.fromJson(Map<String, dynamic> json) {
    return TvDetails(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genres'] as List<dynamic>)
          .map<int>((g) => (g as Map<String, dynamic>)['id'] as int)
          .toList(),
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String? ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      createdBy: (json['created_by'] as List<dynamic>?)
          ?.map((cb) => CreatedBy.fromJson(cb as Map<String, dynamic>))
          .toList() ??
          [],
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map<int>((rt) => rt as int)
          .toList() ??
          [],
      firstAirDate: json['first_air_date'] as String,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((g) => Genre.fromJson(g as Map<String, dynamic>))
          .toList() ??
          [],
      homepage: json['homepage'] as String? ?? '',
      inProduction: json['in_production'] as bool? ?? false,
      languages: (json['languages'] as List<dynamic>?)
          ?.map<String>((l) => l as String)
          .toList() ??
          [],
      lastAirDate: json['last_air_date'] as String? ?? '',
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? Episode.fromJson(json['last_episode_to_air'] as Map<String, dynamic>)
          : null,
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? Episode.fromJson(json['next_episode_to_air'] as Map<String, dynamic>)
          : null,
      networks: (json['networks'] as List<dynamic>?)
          ?.map((n) => Network.fromJson(n as Map<String, dynamic>))
          .toList() ??
          [],
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map<String>((oc) => oc as String)
          .toList() ??
          [],
      originalName: json['original_name'] as String? ?? '',
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((pc) => Network.fromJson(pc as Map<String, dynamic>))
          .toList() ??
          [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((pc) => ProductionCountry.fromJson(pc as Map<String, dynamic>))
          .toList() ??
          [],
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((s) => Season.fromJson(s as Map<String, dynamic>))
          .toList() ??
          [],
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((sl) => SpokenLanguage.fromJson(sl as Map<String, dynamic>))
          .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );
  }
}
