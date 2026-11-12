import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

extension TypeRowMapper on TypeRow {
  PokemonType toEntity() => PokemonType(id: id, name: name, nameEs: nameEs);
}

extension PokemonWithTypesMapper on PokemonWithTypes {
  Pokemon toEntity() => Pokemon(
    id: pokemon.id,
    speciesId: pokemon.speciesId,
    name: pokemon.name,
    speciesName: species.name,
    isDefault: pokemon.isDefault,
    types: List<PokemonType>.unmodifiable(
      types.map((type) => type.toEntity()),
    ),
    baseStats: BaseStats(
        hp: pokemon.hp,
        attack: pokemon.attack,
        defense: pokemon.defense,
        specialAttack: pokemon.specialAttack,
        specialDefense: pokemon.specialDefense,
        speed: pokemon.speed,
    ),
    images: PokemonImages(
      artworkUrl: pokemon.artworkUrl,
      artworkShinyUrl: pokemon.artworkShinyUrl,
      spriteUrl: pokemon.spriteUrl,
      spriteShinyUrl: pokemon.spriteShinyUrl,
      localArtworkPath: pokemon.artworkLocalPath,
    )
  );
}