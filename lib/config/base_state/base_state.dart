import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isError;
  final bool isLoading;
  final T? data;

  const BaseState({this.isError = false, this.isLoading = false, this.data});

  BaseState<T> copyWith({bool? isError, bool? isLoading, T? data}) {
    return BaseState<T>(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isError, isLoading, data];
}
