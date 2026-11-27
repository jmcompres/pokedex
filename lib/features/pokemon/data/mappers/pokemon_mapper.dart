import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';
import 'package:pokedex/features/pokemon/domain/entities/base_stats.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_images.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

extension TypeRowMapper on TypeRow {
  PokemonType toEntity() => PokemonType(id: id, name: name, nameEs: nameEs);
}

extension PokemonRowImagesMapper on PokemonRow {
  PokemonImages toImages() => PokemonImages(
    artworkUrl: artworkUrl,
    artworkShinyUrl: artworkShinyUrl,
    spriteUrl: spriteUrl,
    spriteShinyUrl: spriteShinyUrl,
    localArtworkPath: artworkLocalPath,
  );
}

extension PokemonWithTypesMapper on PokemonWithTypes {
  Pokemon toEntity() => Pokemon(
    id: pokemon.id,
    speciesId: pokemon.speciesId,
    name: pokemon.name,
    speciesName: species.name,
    isDefault: pokemon.isDefault,
    types: List<PokemonType>.unmodifiable(types.map((type) => type.toEntity())),
    baseStats: BaseStats(
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      specialAttack: pokemon.specialAttack,
      specialDefense: pokemon.specialDefense,
      speed: pokemon.speed,
    ),
    images: pokemon.toImages(),
  );
}

extension PokemonDetailLocalMapper on PokemonDetailLocal {
  PokemonDetail toEntity() => PokemonDetail(
    pokemon: PokemonWithTypes(pokemon, species, types).toEntity(),
    height: pokemon.height,
    weight: pokemon.weight,
    abilities: List.unmodifiable([
      for (final a in abilities)
        PokemonAbility(
          id: a.ability.id,
          name: a.ability.name,
          nameEs: a.ability.nameEs,
          effectEn: a.ability.effectEn,
          effectEs: a.ability.effectEs,
          slot: a.link.slot,
          isHidden: a.link.isHidden,
        ),
    ]),
    moves: List.unmodifiable([
      for (final m in moves)
        PokemonMove(
          id: m.move.id,
          name: m.move.name,
          nameEs: m.move.nameEs,
          typeId: m.move.typeId,
          power: m.move.power,
          accuracy: m.move.accuracy,
          pp: m.move.pp,
          damageClass: m.move.damageClass,
          versionGroupId: m.link.versionGroupId,
          learnMethod: m.link.learnMethod,
          level: m.link.levelLearned,
        ),
    ]),
    evolutionChain: List.unmodifiable([
      for (final s in chainSpecies) EvolutionSpecies(id: s.id, name: s.name),
    ]),
    evolutions: List.unmodifiable([
      for (final e in evolutions)
        EvolutionStep(
          fromSpeciesId: e.fromSpeciesId,
          toSpeciesId: e.toSpeciesId,
          trigger: e.triggerName,
          minLevel: e.minLevel,
          item: e.item,
          minHappiness: e.minHappiness,
          timeOfDay: e.timeOfDay,
        ),
    ]),
    eggGroups: List.unmodifiable([
      for (final g in eggGroups)
        EggGroup(id: g.id, name: g.name, nameEs: g.nameEs),
    ]),
    varieties: List.unmodifiable([
      for (final v in varieties)
        PokemonVariety(
          id: v.id,
          name: v.name,
          isDefault: v.isDefault,
          images: v.toImages(),
        ),
    ]),
    versionGroups: List.unmodifiable([
      for (final vg in versionGroups) VersionGroup(id: vg.id, name: vg.name),
    ]),
    lastSyncedAt: sync?.lastSuccessAt,
  );
}
