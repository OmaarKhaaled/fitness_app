  import 'package:dio/dio.dart';
  import 'package:flutter/material.dart';
  import 'package:injectable/injectable.dart';

  import '../../core/constants/cache_constants.dart';
  import '../base_response/base_response.dart';
  import '../cache_modules/secure_storege_module.dart';

  /// SRP violations [TokenService] Multiple responsibilities
  /// Issues:
  ///        Manages token operations (get, save, clear)
  ///        Manages user data operations (getUserData, saveUserData)
  ///        Manages login state (isLoggedIn, saveLoginData)
  ///        Provides status reporting (getTokenStatus)

  @injectable
  class TokenService {
    final SecureStorageService _secureStorageService;
    final Dio _dio;

    TokenService(this._secureStorageService, this._dio);

    /// Get the current authentication token using SecureStorageService extension
    Future<BaseResponse<String?>> getToken() async {
      return await _secureStorageService.getAuthTokens();
    }

    /// Save authentication token using SecureStorageService extension
    Future<BaseResponse<bool>> saveToken(String token) async {
      return await _secureStorageService.saveAuthTokens(accessToken: token);
    }

    /// Clear authentication token using SecureStorageService extension
    Future<BaseResponse<bool>> clearToken() async {
      return await _secureStorageService.clearAuthTokens();
    }

    /// Check if user is currently logged in
    Future<BaseResponse<bool>> isLoggedIn() async {
      final tokenResponse = await _secureStorageService.getAuthTokens();
      final isLoggedInResponse = await _secureStorageService.readBool(
        StorageKeys.isLoggedIn,
      );

      return tokenResponse.when(
        initial: () => const BaseResponse.initial(),
        loading: () => const BaseResponse.loading(),
        success: (token) {
          return isLoggedInResponse.when(
            initial: () => const BaseResponse.initial(),
            loading: () => const BaseResponse.loading(),
            success: (isLoggedIn) {
              final hasValidToken = token != null && token.isNotEmpty;
              final isUserLoggedIn = isLoggedIn == true;
              return BaseResponse.success(hasValidToken && isUserLoggedIn);
            },
            failure: (error) => BaseResponse.failure(error),
          );
        },
        failure: (error) => BaseResponse.failure(error),
      );
    }

    /// Get stored user data
    Future<BaseResponse<Map<String, dynamic>?>> getUserData() async {
      return await _secureStorageService.readJson(StorageKeys.userModel);
    }

    /// Save user data to storage
    Future<BaseResponse<bool>> saveUserData(Map<String, dynamic> userData) async {
      return await _secureStorageService.writeJson(
        StorageKeys.userModel,
        userData,
      );
    }

    /// Clear all authentication data (logout) - uses SecureStorageService methods
    Future<BaseResponse<bool>> clearAuthData() async {
      final results = await Future.wait([
        _secureStorageService.clearAuthTokens(), // Use extension method
        _secureStorageService.writeBool(StorageKeys.isLoggedIn, false),
        _secureStorageService.delete(StorageKeys.userModel),
      ]);

      for (final result in results) {
        final failure = result.when(
          initial: () => null,
          loading: () => null,
          success: (_) => null,
          failure: (f) => f,
        );
        if (failure != null) {
          return BaseResponse.failure(failure);
        }
      }

      return const BaseResponse.success(true);
    }

    /// Save complete login data (token + user data + login status)
    /// This is the main method to use after successful login
    Future<BaseResponse<bool>> saveLoginData({
      required String token,
      required Map<String, dynamic> userData,
    }) async {
      final results = await Future.wait([
        _secureStorageService.saveAuthTokens(accessToken: token),
        // Use extension method
        _secureStorageService.writeBool(StorageKeys.isLoggedIn, true),
        _secureStorageService.writeJson(StorageKeys.userModel, userData),
      ]);

      for (final result in results) {
        final failure = result.when(
          initial: () => null,
          loading: () => null,
          success: (_) => null,
          failure: (f) => f,
        );
        if (failure != null) {
          return BaseResponse.failure(failure);
        }
      }

      return const BaseResponse.success(true);
    }

    /// Check if token is valid (exists and not empty)
    Future<BaseResponse<bool>> isTokenValid() async {
      final tokenResponse = await getToken(); // Uses extension method internally

      return tokenResponse.when(
        initial: () => const BaseResponse.success(false),
        loading: () => const BaseResponse.success(false),
        success: (token) {
          if (token == null || token.isEmpty) {
            return const BaseResponse.success(false);
          }

          // You can add JWT token expiration checking here
          // For now, just check if token exists
          return const BaseResponse.success(true);
        },
        failure: (error) => const BaseResponse.success(false),
      );
    }

    /// Check token status and return detailed information
    Future<Map<String, dynamic>> getTokenStatus() async {
      final tokenResponse = await getToken();
      final isLoggedInResponse = await isLoggedIn();
      final isValidResponse = await isTokenValid();

      return {
        'hasToken': tokenResponse.when(
          initial: () => false,
          loading: () => false,
          success: (token) => token != null && token.isNotEmpty,
          failure: (_) => false,
        ),
        'isLoggedIn': isLoggedInResponse.when(
          initial: () => false,
          loading: () => false,
          success: (loggedIn) => loggedIn,
          failure: (_) => false,
        ),
        'isValid': isValidResponse.when(
          initial: () => false,
          loading: () => false,
          success: (valid) => valid,
          failure: (_) => false,
        ),
        'token': tokenResponse.when(
          initial: () => null,
          loading: () => null,
          success: (token) => token,
          failure: (_) => null,
        ),
      };
    }

    Future<BaseResponse<bool>> refreshToken(String newToken) async {
      debugPrint('🔄 Refreshing token with new value...');

      final result = await saveToken(newToken);

      result.when(
        initial: () => debugPrint('⏳ Token refresh initial state'),
        loading: () => debugPrint('⏳ Token refresh in progress...'),
        success: (_) {
          // Also update Dio headers so the new token is used immediately
          _dio.options.headers['Authorization'] = 'Bearer $newToken';
          _dio.options.headers['TOKEN'] = newToken;
          debugPrint('✅ Token refreshed and headers updated successfully');
        },
        failure: (error) => debugPrint('❌ Failed to refresh token: ${error.message}'),
      );

      return result;
    }

  }
