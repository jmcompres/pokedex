import 'package:equatable/equatable.dart';

enum DataOrigin {
  remote,
  local,
}

class LastSync extends Equatable {
  const LastSync({required this.at, required this.origin});

  final DateTime at;
  final DataOrigin origin;

  bool isStaleAt(DateTime now, Duration maxAge) =>
      now.difference(at) > maxAge;

  @override
  List<Object?> get props => [at, origin];
}