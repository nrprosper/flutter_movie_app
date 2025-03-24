import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/data/movie_details.dart';
import 'package:movie_app/data/trending_response.dart';
import 'package:movie_app/data/tv_response.dart';

import '../data/movie_response.dart';

class TmdbService {

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  static String? _apiKey;

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.env['API_KEY'];

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.queryParameters['api_key'] = _apiKey;
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        if (e.response?.statusCode == 401) {
          throw Exception('Invalid API key');
        }
        return handler.next(e);
      },
    ));

  }

  Future<TrendingResponse> getTrendingAll({int page = 1}) async {
    final response = await _dio.get(
      'trending/all',
      queryParameters: {'page': page}
    );
    return TrendingResponse.fromJson(response.data);
  }

  Future<MovieResponse> getPopularMovies({int page = 1}) async {
    final response = await _dio.get(
      'movie/popular',
      queryParameters: {'page': page},
    );
    return MovieResponse.fromJson(response.data);
  }

  Future<TvSeriesResponse> getPopularTvSeries({int page = 1}) async {
    final response = await _dio.get(
      'tv/popular',
      queryParameters: {'page': page},
    );
    return TvSeriesResponse.fromJson(response.data);
  }

  Future<TvSeriesResponse> getTopRated({int page = 1}) async {
    final response = await _dio.get(
      'tv/top_rated',
      queryParameters: {'page': page},
    );
    return TvSeriesResponse.fromJson(response.data);
  }

  Future<MovieResponse> getTrendingMovies({String timeWindow = 'week'}) async {
    final response = await _dio.get(
      'trending/movie/$timeWindow',
    );
    return MovieResponse.fromJson(response.data);
  }

  Future<TvSeriesResponse> getAiringToday() async {
    final response = await _dio.get(
      'tv/airing_today',
    );
    return TvSeriesResponse.fromJson(response.data);
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final response = await _dio.get(
      'movie/$movieId',
    );
    return MovieDetails.fromJson(response.data);
  }

  Future<MovieResponse> getRecommendedMovies(int movieId) async {
    final response = await _dio.get(
      'movie/$movieId/recommendations',
    );
    return MovieResponse.fromJson(response.data);
  }



}