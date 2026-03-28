import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';

@Freezed()
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse.success(T data) = Success<T>;

  const factory BaseResponse.failure(AppException exception) = Failure<T>;
}
