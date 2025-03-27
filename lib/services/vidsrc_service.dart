
import 'package:dio/dio.dart';

class VidSrcService {

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://player.vidsrc.co/embed/',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  ));

  Future<bool> isVideoAvailable(int movieId) async {
    final response = await _dio.get('movie/$movieId');
    return response.statusCode == 200;
  }

}