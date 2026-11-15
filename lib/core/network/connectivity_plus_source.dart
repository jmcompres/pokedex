import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_contracts.dart';

class ConnectivityPlusSource implements NetworkConnectivitySource {
  final Connectivity _connectivity;

  ConnectivityPlusSource({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get hasNetworkConnection async {
    final results = await _connectivity.checkConnectivity();
    return _hasActiveInterface(results);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged
        .map(_hasActiveInterface)
        .distinct();
  }

  bool _hasActiveInterface(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;
    return results.any((result) => result != ConnectivityResult.none);
  }
}
