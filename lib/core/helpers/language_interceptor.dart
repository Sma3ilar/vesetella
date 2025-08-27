import 'package:dio/dio.dart';
import 'local_storage.dart';

class LanguageInterceptor extends Interceptor {
  final LocalStorage storage = LocalStorage.instance;

  LanguageInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Always get the current language from storage
    options.queryParameters['lang'] = storage.currentLanguage;
    super.onRequest(options, handler);
  }
}