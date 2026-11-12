import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String? debugMessage;
  const Failure({this.debugMessage});

  @override
  List<Object?> get props => const [];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.debugMessage});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.debugMessage});
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({super.debugMessage, this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

class GraphQLFailure extends Failure {
  const GraphQLFailure({super.debugMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({super.debugMessage});
}

class RateLimitFailure extends Failure {
  const RateLimitFailure({super.debugMessage});
}
