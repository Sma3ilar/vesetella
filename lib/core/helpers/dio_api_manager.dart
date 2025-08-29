import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/app_constants.dart';
import 'language_interceptor.dart';

class DioApiManager {
  DioApiManager({
    String baseUrl = AppConstants.baseUrl,
    List<Interceptor> interceptors = const [],
  }) {
    _initDio(baseUrl, interceptors);
  }

  static const String logTag = 'DioApiManager';

  late Dio dio;

  _initDio(String baseUrl, List<Interceptor> interceptors) {
    dio =
        Dio(
            BaseOptions(
              baseUrl: baseUrl,
              headers: {"Accept": 'application/json'},
              // queryParameters: {"lang": "ar"},
              receiveDataWhenStatusError: true,
              contentType: Headers.jsonContentType,
            ),
          )
          ..interceptors.addAll(interceptors)
          // ..interceptors.add(LanguageInterceptor())
          ..interceptors.add(
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              compact: false,
              logPrint: (object) => debugPrint(object.toString()),
            ),
          );
  }
}
