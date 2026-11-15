import 'dart:convert';

import 'package:pokedex/core/errors/failures.dart';

class TypeDto {
  final int id;
  final String name;
  final String? nameEs;

  const TypeDto({required this.id, required this.name, this.nameEs});

  factory TypeDto.fromJson(Map<String, dynamic> json) {
    final names = json['typenames'] as List<dynamic>?;
    final String? parsedNameEs = (names != null && names.isNotEmpty)
        ? (names.first as Map<String, dynamic>)['name'] as String?
        : null;

    return TypeDto(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEs: parsedNameEs,
    );
  }
}

class TypeEfficacyDto {
  final int attackTypeId;
  final int defenseTypeId;
  final int damageFactor;

  const TypeEfficacyDto({
    required this.attackTypeId,
    required this.defenseTypeId,
    required this.damageFactor,
  });

  factory TypeEfficacyDto.fromJson(Map<String, dynamic> json) {
    return TypeEfficacyDto(
      attackTypeId: json['damage_type_id'] as int,
      defenseTypeId: json['target_type_id'] as int,
      damageFactor: json['damage_factor'] as int,
    );
  }
}

class GenerationDto {
  final int id;
  final String name;
  final String? regionName;

  const GenerationDto({required this.id, required this.name, this.regionName});

  factory GenerationDto.fromJson(Map<String, dynamic> json) {
    final region = json['region'] as Map<String, dynamic>?;

    return GenerationDto(
      id: json['id'] as int,
      name: json['name'] as String,
      regionName: region?['name'] as String?,
    );
  }
}

class VersionGroupDto {
  final int id;
  final String name;
  final int? generationId;
  final int? order;

  const VersionGroupDto({
    required this.id,
    required this.name,
    this.generationId,
    this.order,
  });

  factory VersionGroupDto.fromJson(Map<String, dynamic> json) {
    return VersionGroupDto(
      id: json['id'] as int,
      name: json['name'] as String,
      generationId: json['generation_id'] as int?,
      order: json['order'] as int?,
    );
  }
}

class EggGroupDto {
  final int id;
  final String name;
  final String? nameEs;

  const EggGroupDto({required this.id, required this.name, this.nameEs});

  factory EggGroupDto.fromJson(Map<String, dynamic> json) {
    final names = json['egggroupnames'] as List<dynamic>?;
    final String? parsedNameEs = (names != null && names.isNotEmpty)
        ? (names.first as Map<String, dynamic>)['name'] as String?
        : null;

    return EggGroupDto(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEs: parsedNameEs,
    );
  }
}

class ReferenceDataDto {
  final List<TypeDto> types;
  final List<TypeEfficacyDto> typeEfficacy;
  final List<GenerationDto> generations;
  final List<VersionGroupDto> versionGroups;
  final List<EggGroupDto> eggGroups;

  const ReferenceDataDto({
    required this.types,
    required this.typeEfficacy,
    required this.generations,
    required this.versionGroups,
    required this.eggGroups,
  });

  factory ReferenceDataDto.fromJson(Map<String, dynamic> json) {
    return ReferenceDataDto(
      types: (json['type'] as List<dynamic>? ?? [])
          .map((e) => TypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeEfficacy: (json['typeefficacy'] as List<dynamic>? ?? [])
          .map((e) => TypeEfficacyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      generations: (json['generation'] as List<dynamic>? ?? [])
          .map((e) => GenerationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      versionGroups: (json['versiongroup'] as List<dynamic>? ?? [])
          .map((e) => VersionGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      eggGroups: (json['egggroup'] as List<dynamic>? ?? [])
          .map((e) => EggGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SpeciesDto {
  final int id;
  final String name;
  final int generationId;
  final int? evolutionChainId;

  const SpeciesDto({
    required this.id,
    required this.name,
    required this.generationId,
    this.evolutionChainId,
  });

  factory SpeciesDto.fromJson(Map<String, dynamic> json) {
    return SpeciesDto(
      id: json['id'] as int,
      name: json['name'] as String,
      generationId: json['generation_id'] as int,
      evolutionChainId: json['evolution_chain_id'] as int?,
    );
  }
}

class PokemonFormDto {
  final int id;
  final String name;
  final String? formName;
  final bool isDefault;
  final bool isMega;
  final bool isBattleOnly;
  final int? formOrder;

  const PokemonFormDto({
    required this.id,
    required this.name,
    this.formName,
    required this.isDefault,
    required this.isMega,
    required this.isBattleOnly,
    this.formOrder,
  });

  factory PokemonFormDto.fromJson(Map<String, dynamic> json) {
    final formName = json['form_name'] as String?;

    return PokemonFormDto(
      id: json['id'] as int,
      name: json['name'] as String,
      formName: (formName == null || formName.isEmpty) ? null : formName,
      isDefault: json['is_default'] as bool,
      isMega: json['is_mega'] as bool,
      isBattleOnly: json['is_battle_only'] as bool,
      formOrder: json['form_order'] as int?,
    );
  }
}

class PokemonTypeSlotDto {
  final int slot;
  final int typeId;

  const PokemonTypeSlotDto({required this.slot, required this.typeId});

  factory PokemonTypeSlotDto.fromJson(Map<String, dynamic> json) {
    return PokemonTypeSlotDto(
      slot: json['slot'] as int,
      typeId: json['type_id'] as int,
    );
  }
}

class PokemonStatDto {
  final int baseStat;
  final String name;

  const PokemonStatDto({required this.baseStat, required this.name});

  factory PokemonStatDto.fromJson(Map<String, dynamic> json) {
    return PokemonStatDto(
      baseStat: json['base_stat'] as int,
      name: (json['stat'] as Map<String, dynamic>)['name'] as String,
    );
  }
}

class PokemonSpritesDto {
  final String? spriteUrl;
  final String? spriteShinyUrl;
  final String? artworkUrl;
  final String? artworkShinyUrl;

  const PokemonSpritesDto({
    this.spriteUrl,
    this.spriteShinyUrl,
    this.artworkUrl,
    this.artworkShinyUrl,
  });

  factory PokemonSpritesDto.fromSpritesNode(List<dynamic>? spritesNode) {
    if (spritesNode == null || spritesNode.isEmpty) {
      return const PokemonSpritesDto();
    }

    final firstNode = spritesNode.first as Map<String, dynamic>;
    final spritesData = firstNode['sprites'];
    if (spritesData == null) {
      return const PokemonSpritesDto();
    }

    final Map<String, dynamic> spritesMap;
    if (spritesData is String) {
      spritesMap = jsonDecode(spritesData) as Map<String, dynamic>;
    } else if (spritesData is Map<String, dynamic>) {
      spritesMap = spritesData;
    } else {
      return const PokemonSpritesDto();
    }

    final other = spritesMap['other'] as Map<String, dynamic>?;
    final officialArtwork = other?['official-artwork'] as Map<String, dynamic>?;

    return PokemonSpritesDto(
      spriteUrl: spritesMap['front_default'] as String?,
      spriteShinyUrl: spritesMap['front_shiny'] as String?,
      artworkUrl: officialArtwork?['front_default'] as String?,
      artworkShinyUrl: officialArtwork?['front_shiny'] as String?,
    );
  }
}

class PokemonDto {
  final int id;
  final String name;
  final bool isDefault;
  final int? height;
  final int? weight;
  final SpeciesDto? species;
  final List<PokemonFormDto> forms;
  final List<PokemonTypeSlotDto> types;
  final List<PokemonStatDto> stats;
  final PokemonSpritesDto sprites;

  const PokemonDto({
    required this.id,
    required this.name,
    required this.isDefault,
    this.height,
    this.weight,
    this.species,
    required this.forms,
    required this.types,
    required this.stats,
    required this.sprites,
  });

  String? get formName => forms.isNotEmpty ? forms.first.formName : null;

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(
      id: (json['id'] as int?) ?? 0,
      name: json['name'] as String,
      isDefault: json['is_default'] as bool,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      species: json['pokemonspecy'] != null
          ? SpeciesDto.fromJson(json['pokemonspecy'] as Map<String, dynamic>)
          : null,
      forms: (json['pokemonforms'] as List<dynamic>? ?? [])
          .map((e) => PokemonFormDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['pokemontypes'] as List<dynamic>? ?? [])
          .map((e) => PokemonTypeSlotDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['pokemonstats'] as List<dynamic>? ?? [])
          .map((e) => PokemonStatDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      sprites: PokemonSpritesDto.fromSpritesNode(
        json['pokemonsprites'] as List<dynamic>?,
      ),
    );
  }

  static const Set<String> requiredStats = {
    'hp',
    'attack',
    'defense',
    'special-attack',
    'special-defense',
    'speed',
  };

  void validate() {
    if (id <= 0) {
      throw ValidationFailure(debugMessage: 'ID de Pokémon inválido: $id');
    }
    if (species == null || species!.id <= 0) {
      throw ValidationFailure(
        debugMessage: 'El Pokémon $id no tiene especie válida',
      );
    }
    if (types.isEmpty) {
      throw ValidationFailure(debugMessage: 'El Pokémon $id no tiene tipos');
    }
    if (stats.length < 6) {
      throw ValidationFailure(
        debugMessage: 'El Pokémon $id tiene menos de 6 stats (${stats.length})',
      );
    }
    final statNames = stats.map((s) => s.name).toSet();
    if (!statNames.containsAll(requiredStats)) {
      throw ValidationFailure(
        debugMessage: 'El Pokémon $id no contiene los 6 stats requeridos',
      );
    }
  }

  static void validatePage(List<PokemonDto> page) {
    for (final pokemon in page) {
      pokemon.validate();
    }
  }
}
