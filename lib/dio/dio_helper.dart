import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/',
          receiveDataWhenStatusError: true,
          contentType: 'aplication/json'),
    );
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    // dio.options.headers = {};
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}


// Api key "123c8c6764f14a23939aeae7a3100935"
// https://newsapi.org/v2/everything?q=tesla&from=2021-10-20&sortBy=publishedAt&apiKey=123c8c6764f14a23939aeae7a3100935

// base Url , method , query 