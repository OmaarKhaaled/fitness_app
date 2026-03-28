import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/core/constants/error_constants.dart';
import 'package:fitness_app/core/extensions/extentions.dart';

class ApiException extends AppException {
  ApiException(super.message, {super.code});

  factory ApiException.fromJson({
    required Map<String, dynamic> json,
    required int? statusCode,
  }) {
    return ApiException(getAllErrorMessage(json), code: statusCode);
  }

  static String getAllErrorMessage(Map<String, dynamic> errors) {
    if (errors.isNullOrEmpty()) return ErrorsConstant.defaultError;

    final errorMessage = errors.entries
        .map((entry) {
          final key = entry.key;
          final value = entry.value;
          return "$key: ${value.join(', ')}";
        })
        .join('\n');
    return errorMessage;
  }
}
