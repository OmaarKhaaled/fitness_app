import 'package:dio/dio.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/config/errors/local_exception.dart';
import 'package:fitness_app/core/constants/error_constants.dart';
import 'api_exception.dart';

class ExceptionsHandler {
  static AppException handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is LocalException) {
      return _handleLocalException(error);
    } else {
      return ApiException(ErrorsConstant.defaultError);
    }
  }
}

AppException _handleDioError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout => ApiException(
      error.message ?? ErrorsConstant.connectionTimeoutError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.sendTimeout => ApiException(
      error.message ?? ErrorsConstant.sendTimeoutError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.receiveTimeout => ApiException(
      error.message ?? ErrorsConstant.receiveTimeoutError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.badResponse => _handleBadResponse(error),
    DioExceptionType.connectionError => ApiException(
      error.message ?? ErrorsConstant.noInternetError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.cancel => ApiException(
      error.message ?? ErrorsConstant.cancelError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.badCertificate => ApiException(
      error.message ?? ErrorsConstant.badCertificateError,
      code: error.response?.statusCode,
    ),
    DioExceptionType.unknown => ApiException(
      error.message ?? ErrorsConstant.defaultError,
      code: error.response?.statusCode,
    ),
  };
}

AppException _handleBadResponse(DioException error) {
  return ApiException.fromJson(
    json: error.response?.data,
    statusCode: error.response?.statusCode,
  );
}

AppException _handleLocalException(LocalException error) {
  return switch (error) {
    CacheException(:final message) => CacheException(message),
  };
}
