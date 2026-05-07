import 'package:dio/dio.dart';
import 'package:fitness_app/config/network/language_manager.dart';
import 'package:injectable/injectable.dart';


@singleton
class LanguageInterceptor extends Interceptor {
  final LanguageManager _languageManager;
  
  LanguageInterceptor(this._languageManager);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _languageManager.currentLanguage;
    super.onRequest(options, handler);
  }
}