enum ServiceAvailability {
  verifying,
  online,
  offline,
  serviceUnavailable;

  bool get isApiAccessible => this == ServiceAvailability.online;
  bool get hasNetworkConnection => this != ServiceAvailability.offline;
}
