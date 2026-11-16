import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract final class PokemonImageCache {
  static const _key = 'pokemonImages';

  static final instance = CacheManager(
    Config(
      _key,
      maxNrOfCacheObjects: 400,
      stalePeriod: const Duration(days: 30),
    ),
  );

  static void configureMemoryCache() {
    PaintingBinding.instance.imageCache
      ..maximumSize = 300
      ..maximumSizeBytes = 50 * 1024 * 1024;
  }
}
