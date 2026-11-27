import 'package:equatable/equatable.dart';

import 'pokemon.dart';
import 'pokemon_images.dart';

class PokemonAbility extends Equatable {
  const PokemonAbility({
    required this.id,
    required this.name,
    this.nameEs,
    this.effectEn,
    this.effectEs,
    required this.slot,
    required this.isHidden,
  });

  final int id;
  final String name;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;
  final int slot;
  final bool isHidden;

  @override
  List<Object?> get props => [
    id,
    name,
    nameEs,
    effectEn,
    effectEs,
    slot,
    isHidden,
  ];
}

class PokemonMove extends Equatable {
  const PokemonMove({
    required this.id,
    required this.name,
    this.nameEs,
    this.typeId,
    this.power,
    this.accuracy,
    this.pp,
    this.damageClass,
    required this.versionGroupId,
    required this.learnMethod,
    required this.level,
  });

  final int id;
  final String name;
  final String? nameEs;
  final int? typeId;
  final int? power;
  final int? accuracy;
  final int? pp;
  final String? damageClass;
  final int versionGroupId;
  final String learnMethod;
  final int level;

  @override
  List<Object?> get props => [
    id,
    name,
    nameEs,
    typeId,
    power,
    accuracy,
    pp,
    damageClass,
    versionGroupId,
    learnMethod,
    level,
  ];
}

class EvolutionSpecies extends Equatable {
  const EvolutionSpecies({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class EvolutionStep extends Equatable {
  const EvolutionStep({
    required this.fromSpeciesId,
    required this.toSpeciesId,
    required this.trigger,
    this.minLevel,
    this.item,
    this.minHappiness,
    this.timeOfDay,
  });

  final int fromSpeciesId;
  final int toSpeciesId;
  final String trigger;
  final int? minLevel;
  final String? item;
  final int? minHappiness;
  final String? timeOfDay;

  @override
  List<Object?> get props => [
    fromSpeciesId,
    toSpeciesId,
    trigger,
    minLevel,
    item,
    minHappiness,
    timeOfDay,
  ];
}

class EggGroup extends Equatable {
  const EggGroup({required this.id, required this.name, this.nameEs});

  final int id;
  final String name;
  final String? nameEs;

  @override
  List<Object?> get props => [id, name, nameEs];
}

class VersionGroup extends Equatable {
  const VersionGroup({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class PokemonVariety extends Equatable {
  const PokemonVariety({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.images,
  });

  final int id;
  final String name;
  final bool isDefault;
  final PokemonImages images;

  @override
  List<Object?> get props => [id, name, isDefault, images];
}

class PokemonDetail extends Equatable {
  const PokemonDetail({
    required this.pokemon,
    this.height,
    this.weight,
    required this.abilities,
    required this.moves,
    required this.evolutionChain,
    required this.evolutions,
    required this.eggGroups,
    required this.varieties,
    required this.versionGroups,
    this.lastSyncedAt,
  });

  final Pokemon pokemon;
  final int? height;
  final int? weight;
  final List<PokemonAbility> abilities;
  final List<PokemonMove> moves;
  final List<EvolutionSpecies> evolutionChain;
  final List<EvolutionStep> evolutions;
  final List<EggGroup> eggGroups;
  final List<PokemonVariety> varieties;
  final List<VersionGroup> versionGroups;
  final DateTime? lastSyncedAt;

  bool get isDownloaded => lastSyncedAt != null;

  @override
  List<Object?> get props => [
    pokemon,
    height,
    weight,
    abilities,
    moves,
    evolutionChain,
    evolutions,
    eggGroups,
    varieties,
    versionGroups,
    lastSyncedAt,
  ];
}
