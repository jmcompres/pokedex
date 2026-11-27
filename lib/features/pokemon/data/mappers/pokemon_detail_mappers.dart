import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote/pokemon_detail_dtos.dart';

extension AbilityDtoMapper on AbilityDto {
  AbilitiesTableCompanion toCompanion() => AbilitiesTableCompanion(
    id: Value(id),
    name: Value(name),
    nameEs: Value(nameEs),
    effectEn: Value(effectEn),
    effectEs: Value(effectEs),
  );
}

extension MoveDtoMapper on MoveDto {
  MovesTableCompanion toCompanion() => MovesTableCompanion(
    id: Value(id),
    name: Value(name),
    nameEs: Value(nameEs),
    typeId: Value(typeId),
    power: Value(power),
    accuracy: Value(accuracy),
    pp: Value(pp),
    damageClass: Value(damageClass),
  );
}

extension ChainSpeciesDtoMapper on ChainSpeciesDto {
  SpeciesTableCompanion toCompanion() => SpeciesTableCompanion(
    id: Value(id),
    name: Value(name),
    generationId: Value(generationId),
    evolutionChainId: Value(evolutionChainId),
  );

  //formas de llegar a esta especie desde la anterior
  List<EvolutionsTableCompanion> toEvolutionCompanions() {
    final from = evolvesFromSpeciesId;
    if (from == null) return const [];
    return [
      for (final evo_morph in evolutions)
        EvolutionsTableCompanion(
          id: Value(evo_morph.id),
          fromSpeciesId: Value(from),
          toSpeciesId: Value(id),
          triggerName: Value(evo_morph.trigger),
          minLevel: Value(evo_morph.minLevel),
          item: Value(evo_morph.item),
          minHappiness: Value(evo_morph.minHappiness),
          timeOfDay: Value(evo_morph.timeOfDay),
        ),
    ];
  }
}

extension PokemonDetailDtoMapper on PokemonDetailDto {
  PokemonDetailWrite toDetailWrite() {
    //ya que un movimiento puede llegar repetido por learning method o por juego
    final moves = <int, MovesTableCompanion>{
      for (final m in this.moves) m.move.id: m.move.toCompanion(),
    };

    final pokemonMoves = <String, PokemonMovesTableCompanion>{
      for (final m in this.moves)
        '${m.versionGroupId}|${m.learnMethod}|${m.move.id}|${m.level}':
            PokemonMovesTableCompanion(
              pokemonId: Value(pokemonId),
              versionGroupId: Value(m.versionGroupId),
              learnMethod: Value(m.learnMethod),
              moveId: Value(m.move.id),
              levelLearned: Value(m.level),
            ),
    };

    return PokemonDetailWrite(
      pokemonId: pokemonId,
      speciesId: speciesId,
      abilities: [for (final a in abilities) a.ability.toCompanion()],
      pokemonAbilities: [
        for (final a in abilities)
          PokemonAbilitiesTableCompanion(
            pokemonId: Value(pokemonId),
            abilityId: Value(a.ability.id),
            slot: Value(a.slot),
            isHidden: Value(a.isHidden),
          ),
      ],
      moves: moves.values.toList(),
      pokemonMoves: pokemonMoves.values.toList(),
      chainSpecies: [for (final s in chain) s.toCompanion()],
      evolutions: [for (final s in chain) ...s.toEvolutionCompanions()],
      speciesEggGroups: [
        for (final eggGroupId in eggGroupIds.toSet())
          SpeciesEggGroupsTableCompanion(
            speciesId: Value(speciesId),
            eggGroupId: Value(eggGroupId),
          ),
      ],
    );
  }
}
