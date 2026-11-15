import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_plus_source.dart';
import 'graphql_health_check.dart';
import 'graphql_service.dart';
import 'network_contracts.dart';
import 'service_availability.dart';
import 'service_availability_monitor.dart';

final networkConnectivitySourceProvider = Provider<NetworkConnectivitySource>((
  ref,
) {
  return ConnectivityPlusSource();
});

final graphQLHealthCheckProvider = Provider<GraphQLHealthCheck>((ref) {
  return PokeApiGraphQLHealthCheck(ref.watch(graphqlServiceProvider));
});

final serviceAvailabilityMonitorProvider = Provider<ServiceAvailabilityMonitor>(
  (ref) {
    final monitor = ServiceAvailabilityMonitor(
      connectivitySource: ref.watch(networkConnectivitySourceProvider),
      healthCheck: ref.watch(graphQLHealthCheckProvider),
    );

    unawaited(monitor.initialize());

    ref.onDispose(() {
      unawaited(monitor.dispose());
    });

    return monitor;
  },
);

final serviceAvailabilityStreamProvider = StreamProvider<ServiceAvailability>((
  ref,
) {
  final monitor = ref.watch(serviceAvailabilityMonitorProvider);
  final controller = StreamController<ServiceAvailability>();

  controller.add(monitor.currentStatus);
  final subscription = monitor.statusStream.listen(controller.add);

  ref.onDispose(() {
    unawaited(subscription.cancel());
    unawaited(controller.close());
  });

  return controller.stream;
});

final serviceAvailabilityProvider = Provider<ServiceAvailability>((ref) {
  final asyncStatus = ref.watch(serviceAvailabilityStreamProvider);
  final monitor = ref.watch(serviceAvailabilityMonitorProvider);
  return asyncStatus.value ?? monitor.currentStatus;
});
