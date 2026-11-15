import 'dart:async';

import 'network_contracts.dart';
import 'service_availability.dart';

typedef OnServiceReconnected = Future<void> Function();

class ServiceAvailabilityMonitor {
  ServiceAvailabilityMonitor({
    required this.connectivitySource,
    required this.healthCheck,
    this.offlineDebounceDuration = const Duration(milliseconds: 1500),
    this.onReconnected,
  });

  final NetworkConnectivitySource connectivitySource;
  final GraphQLHealthCheck healthCheck;
  final Duration offlineDebounceDuration;
  final OnServiceReconnected? onReconnected;

  final StreamController<ServiceAvailability> _controller =
      StreamController<ServiceAvailability>.broadcast();

  StreamSubscription<bool>? _connectivitySubscription;
  Timer? _offlineDebounceTimer;

  ServiceAvailability _currentStatus = ServiceAvailability.verifying;
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _wasOffline = false;
  int _checkGeneration = 0;

  ServiceAvailability get currentStatus => _currentStatus;

  Stream<ServiceAvailability> get statusStream => _controller.stream;

  Future<void> initialize() async {
    if (_isInitialized || _isDisposed) return;
    _isInitialized = true;

    _connectivitySubscription = connectivitySource.onConnectivityChanged.listen(
      _onNetworkChanged,
      onError: (_) {
        if (!_isDisposed) {
          unawaited(_verifyEndpointHealth());
        }
      },
    );

    final hasNetwork = await _safeCheckNetworkConnection();
    if (_isDisposed) return;

    if (!hasNetwork) {
      _checkGeneration++;
      _emitStatus(ServiceAvailability.offline);
    } else {
      await _verifyEndpointHealth();
    }
  }

  Future<ServiceAvailability> recheck() async {
    if (_isDisposed) return _currentStatus;

    _cancelOfflineDebounce();
    final hasNetwork = await _safeCheckNetworkConnection();
    if (_isDisposed) return _currentStatus;

    if (!hasNetwork) {
      _checkGeneration++;
      _emitStatus(ServiceAvailability.offline);
      return _currentStatus;
    }

    await _verifyEndpointHealth();
    return _currentStatus;
  }

  Future<bool> _safeCheckNetworkConnection() async {
    try {
      return await connectivitySource.hasNetworkConnection;
    } catch (_) {
      return true;
    }
  }

  void _onNetworkChanged(bool hasNetwork) {
    if (_isDisposed) return;

    if (!hasNetwork) {
      _handleNetworkLost();
    } else {
      _handleNetworkRestored();
    }
  }

  void _handleNetworkLost() {
    if (_currentStatus == ServiceAvailability.offline ||
        (_offlineDebounceTimer?.isActive ?? false)) {
      return;
    }

    _checkGeneration++;

    _offlineDebounceTimer = Timer(offlineDebounceDuration, () {
      if (_isDisposed) return;
      _emitStatus(ServiceAvailability.offline);
    });
  }

  void _handleNetworkRestored() {
    final hadPendingDebounce = _offlineDebounceTimer?.isActive ?? false;
    _cancelOfflineDebounce();

    if (hadPendingDebounce &&
        (_currentStatus == ServiceAvailability.online ||
            _currentStatus == ServiceAvailability.serviceUnavailable)) {
      return;
    }

    if (!hadPendingDebounce &&
        _currentStatus == ServiceAvailability.verifying) {
      return;
    }

    unawaited(_verifyEndpointHealth());
  }

  Future<void> _verifyEndpointHealth() async {
    final generation = ++_checkGeneration;
    _emitStatus(ServiceAvailability.verifying);

    bool isHealthy;
    try {
      isHealthy = await healthCheck.checkHealth();
    } catch (_) {
      isHealthy = false;
    }

    if (_isDisposed || generation != _checkGeneration) return;

    if (isHealthy) {
      _emitStatus(ServiceAvailability.online);
    } else {
      _emitStatus(ServiceAvailability.serviceUnavailable);
    }
  }

  void _emitStatus(ServiceAvailability newStatus) {
    if (_isDisposed || _currentStatus == newStatus) return;

    if (newStatus == ServiceAvailability.offline) {
      _wasOffline = true;
    }

    final shouldTriggerAutoSync =
        newStatus == ServiceAvailability.online && _wasOffline;

    if (newStatus == ServiceAvailability.online) {
      _wasOffline = false;
    }

    _currentStatus = newStatus;
    if (!_controller.isClosed) {
      _controller.add(newStatus);
    }

    if (shouldTriggerAutoSync && onReconnected != null) {
      unawaited(_safeTriggerReconnectSync());
    }
  }

  Future<void> _safeTriggerReconnectSync() async {
    try {
      await onReconnected?.call();
    } catch (_) {}
  }

  void _cancelOfflineDebounce() {
    _offlineDebounceTimer?.cancel();
    _offlineDebounceTimer = null;
  }

  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;
    _checkGeneration++;
    _cancelOfflineDebounce();
    await _connectivitySubscription?.cancel();
    await _controller.close();
  }
}
