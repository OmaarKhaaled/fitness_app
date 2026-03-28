import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';

Future<BaseResponse<T>> apiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return BaseResponse<T>.success(response);
  } catch (error) {
    return BaseResponse<T>.failure(ExceptionsHandler.handle(error));
  }
}
