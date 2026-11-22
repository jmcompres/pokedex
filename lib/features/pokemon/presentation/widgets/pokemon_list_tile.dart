import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/images/image_retry_provider.dart';
import 'package:pokedex/core/images/pokemon_image_cache.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/type_chip.dart';

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({super.key, required this.pokemon, this.onTap});

  final Pokemon pokemon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = _displayName(pokemon.speciesName);
    final number = pokemon.nationalDexNumber;
    final types = [for (final t in pokemon.types) t.nameEs ?? t.name];

    return Semantics(
      label: '$name, número $number, tipo ${types.join(' y ')}',
      button: onTap != null,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: const BoxConstraints(minHeight: 90),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE2E4E9)),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D252D3D),
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              const Positioned(
                top: -38,
                right: -36,
                child: SizedBox.square(
                  dimension: 110,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: Color(0xFFF6F7FA), width: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 18, 10),
                child: Row(
                  children: [
                    _PokemonImage(url: pokemon.images.preferredUrl),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#${number.toString().padLeft(4, '0')}',
                            style: const TextStyle(
                              color: Color(0xFF6D7688),
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            name,
                            style: const TextStyle(
                              color: Color(0xFF222731),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.25,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final type in pokemon.types)
                                TypeChip(type: type),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PokemonImage extends ConsumerWidget {
  const _PokemonImage({required this.url});

  final String? url;

  static const _box = 68.0;
  static const _image = 64.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = this.url;
    final retryTick = ref.watch(imageRetryRickProvider);
    final decodeSize = (_image * MediaQuery.devicePixelRatioOf(context))
        .round();

    return Container(
      width: _box,
      height: _box,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FA),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: url == null
          ? _imageFallback
          : CachedNetworkImage(
              key: ValueKey(retryTick),
              imageUrl: url,
              cacheManager: PokemonImageCache.instance,
              width: _image,
              height: _image,
              fit: BoxFit.contain,
              memCacheWidth: decodeSize,
              placeholder: (context, url) => _imageLoading,
              errorWidget: (context, url, error) => _imageFallback,
            ),
    );
  }
}

const _imageLoading = Icon(
  Icons.image_outlined,
  size: 26,
  color: Color(0xFF98A1B1),
);

const _imageFallback = Icon(
  Icons.catching_pokemon,
  size: 42,
  color: Color(0xFF818A9A),
);

String _displayName(String raw) => raw
    .split('-')
    .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
    .join(' ');
