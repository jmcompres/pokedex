import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/network/service_availability.dart';

class ImageRetryTick extends Notifier<int> {
  @override
  int build() {
    ref.listen(serviceAvailabilityProvider, (anterior, actual) {
      final volvio =
          anterior != ServiceAvailability.online &&
          actual == ServiceAvailability.online;
      if (volvio) state++;
    });
    return 0;
  }
}

final imageRetryRickProvider = NotifierProvider<ImageRetryTick, int>(
  ImageRetryTick.new,
);
