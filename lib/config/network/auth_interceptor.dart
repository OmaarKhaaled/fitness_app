import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/api_constants.dart';
import '../../core/constants/cache_constants.dart';
import '../base_response/base_response.dart';
import '../cache_modules/secure_storege_module.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  AuthInterceptor(this._secureStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final String ourHost = Uri.parse(ApiConstants.baseUrl).host;

      // Check if the request is going to our domain
      // If path is absolute, check its host; otherwise check baseUrl
      bool isLocalRequest = false;
      if (options.path.startsWith('http')) {
        isLocalRequest = Uri.parse(options.path).host == ourHost;
      } else {
        isLocalRequest = options.baseUrl.contains(ourHost);
      }

      if (isLocalRequest) {
        final tokenResponse = await _secureStorageService.getAuthTokens();

        tokenResponse.when(
          initial: () => handler.next(options),
          loading: () {},
          success: (token) {
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
              options.headers[CacheConstants.token] = token;
            }
            handler.next(options);
          },
          failure: (error) {
            handler.next(options);
          },
        );
      } else {
        // Skip authentication for external APIs like TheMealDB
        handler.next(options);
      }
    } catch (e) {
      debugPrint('AuthInterceptor error: $e');
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _clearExpiredToken();
      // _sessionManager.notifySessionExpired(
      //   message: 'Your session has expired. Please login again.',
      // );
      if (kDebugMode) {
        log('401 Unauthorized - Session expired');
      }

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Session expired',
          response: err.response,
          type: DioExceptionType.badResponse,
        ),
      );
    }
    handler.next(err);
  }

  /// Clear expired token from storage using SecureStorageService methods
  Future<void> _clearExpiredToken() async {
    try {
      await _secureStorageService.clearAuthTokens();
      await _secureStorageService.writeBool(StorageKeys.isLoggedIn, false);

      if (kDebugMode) {
        log('Auth tokens cleared due to session expiration');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Failed to clear expired token', error: e);
      }
    }
  }
}
