import '../errors/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';

@freezed
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse.initial() = BaseInitial<T>;
  const factory BaseResponse.loading() = BaseLoading<T>;
  const factory BaseResponse.success(T data) = BaseSuccess<T>;
  const factory BaseResponse.failure(AppException exception) = BaseFailure<T>;
}