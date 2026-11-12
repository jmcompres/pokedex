import 'package:equatable/equatable.dart';

sealed class Result<T, E> extends Equatable {
  const Result();
}

final class Ok<T, E> extends Result<T, E> {
  const Ok(this.value);
  final T value;

  @override
  List<Object?> get props => [value];
}

final class Err<T, E> extends Result<T, E> {
  const Err(this.error);
  final E error;

  @override
  List<Object?> get props => [error];
}