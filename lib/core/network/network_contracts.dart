abstract interface class NetworkConnectivitySource {
  Future<bool> get hasNetworkConnection;
  Stream<bool> get onConnectivityChanged;
}

abstract interface class GraphQLHealthCheck {
  Future<bool> checkHealth();
}
