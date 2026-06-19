import 'package:dio/dio.dart';
import 'package:fitness_app/config/network/language_interceptor.dart';
import '../network/auth_interceptor.dart';
import '../network/pretty_dio_logger_interceptor.dart';
import '../../core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    PrettyDioLoggerInterceptor loggerInterceptor,
    LanguageInterceptor languageInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        // connectTimeout: const Duration(seconds: 30),
        // receiveTimeout: const Duration(seconds: 30),
        // sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(languageInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(loggerInterceptor);
    }
    return dio;
  }
}
