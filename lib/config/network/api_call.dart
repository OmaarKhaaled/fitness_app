import 'package:fitness_app/config/services/app_logger.dart';

import '../base_response/base_response.dart';
import '../errors/exception_handler.dart';

Future<BaseResponse<T>> apiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return BaseResponse<T>.success(response);
  } catch (error) {
    appLogger.e(error.toString());
    return BaseResponse<T>.failure(ExceptionsHandler.handle(error));
  }
}
