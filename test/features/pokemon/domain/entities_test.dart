import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';

BaseStats stats(List<int> s) => BaseStats(
  hp: s[0],
  attack: s[1],
  defense: s[2],
  specialAttack: s[3],
  specialDefense: s[4],
  speed: s[5],
);

void main() {
  group('BaseStats', () {
    test('total suma los 6 stats', () {
      expect(stats([78, 84, 78, 109, 85, 100]).total, 534); // Charizard
      expect(stats([35, 55, 40, 50, 50, 90]).total, 320); // Pikachu
    });

    test('dos BaseStats con los mismos valores son iguales', () {
      expect(stats([1, 2, 3, 4, 5, 6]), stats([1, 2, 3, 4, 5, 6]));
      expect(stats([1, 2, 3, 4, 5, 6]), isNot(stats([1, 2, 3, 4, 5, 7])));
    });
  });

  group('PokemonImages', () {
    test('preferredUrl usa el artwork y, si falta, el sprite (RF-DET-01)', () {
      const ambas = PokemonImages(artworkUrl: 'art.png', spriteUrl: 's.png');
      const soloSprite = PokemonImages(spriteUrl: 's.png');
      const ninguna = PokemonImages();

      expect(ambas.preferredUrl, 'art.png');
      expect(soloSprite.preferredUrl, 's.png');
      expect(ninguna.preferredUrl, isNull);
    });

    test('hasShiny solo si existe algún recurso shiny (RF-DET-09)', () {
      expect(const PokemonImages(spriteShinyUrl: 'x.png').hasShiny, isTrue);
      expect(const PokemonImages(artworkUrl: 'a.png').hasShiny, isFalse);
    });
  });

  group('Pokemon', () {
    test('nationalDexNumber es el id de la especie', () {
      final raichuAlola = Pokemon(
        id: 10100,
        speciesId: 26,
        name: 'raichu-alola',
        speciesName: 'raichu',
        isDefault: false,
        types: const [],
        baseStats: stats([60, 85, 50, 95, 85, 110]),
        images: const PokemonImages(),
      );

      expect(raichuAlola.nationalDexNumber, 26);
    });
  });
}
