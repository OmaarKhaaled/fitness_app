import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final T? data;

  const BaseState({this.errorMessage, this.isLoading = false, this.data});

  BaseState<T> copyWith({String? errorMessage, bool? isLoading, T? data}) {
    return BaseState<T>(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isError, isLoading, data];
}
