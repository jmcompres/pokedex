import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimulateApiOutageNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setSimulated(bool value) {
    if (!kDebugMode) {
      state = false;
      return;
    }
    state = value;
  }

  void toggle() => setSimulated(!state);
}

final simulateApiOutageProvider =
    NotifierProvider<SimulateApiOutageNotifier, bool>(
      SimulateApiOutageNotifier.new,
    );
