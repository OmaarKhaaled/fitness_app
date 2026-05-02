import 'app_exception.dart';
import '../../core/constants/error_constants.dart';
import '../../core/extensions/extentions.dart';

class ApiException extends AppException {
  ApiException(super.message, {super.code});

  factory ApiException.fromJson({
    required Map<String, dynamic> json,
    required int? statusCode,
  }) {
    return ApiException(getAllErrorMessage(json), code: statusCode);
  }

  static String getAllErrorMessage(Map<String, dynamic> json) {
    if (json.isNullOrEmpty()) return ErrorsConstant.defaultError;

    if (json.containsKey('message') && json['message'] is String) {
      return json['message'];
    }

    final errorMessage = json.entries
        .map((entry) {
          final value = entry.value;
          if (value is List) {
            return value.join(', ');
          }
          return value.toString();
        })
        .where((element) => element.isNotEmpty)
        .join('\n');

    return errorMessage.isEmpty ? ErrorsConstant.defaultError : errorMessage;
  }
}
