import 'package:pokedex/core/errors/failures.dart';

String? _primerTexto(Map<String, dynamic> json, String lista, String campo) {
  final items = json['lista'] as List<dynamic>?;
  if (items == null || items.isEmpty) return null;
  return (items.first as Map<String, dynamic>)[campo] as String?;
}

String? _limpiar(String? texto) =>
    texto?.replaceAll(RegExp(r'\s+'), ' ').trim();

String? _nombreDe(Map<String, dynamic> json, String objeto) =>
    (json[objeto] as Map<String, dynamic>?)?['name'] as String?;

// habilidades

class AbilityDto {
  final int id;
  final String name;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;

  const AbilityDto({
    required this.id,
    required this.name,
    this.nameEs,
    this.effectEn,
    this.effectEs,
  });

  factory AbilityDto.fromJson(Map<String, dynamic> json) {
    return AbilityDto(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEs: _primerTexto(json, 'abilitynames', 'name'),
      effectEn: _primerTexto(json, 'abilityeffecttexts', 'short_effect'),
      //recordando que el efecto en español viene de fuente dieferente;
      effectEs: _limpiar(
        _primerTexto(json, 'abilityflavortexts', 'flavor_text'),
      ),
    );
  }
}

class PokemonAbilityDto {
  final int slot;
  final bool isHidden;
  final AbilityDto ability;

  const PokemonAbilityDto({
    required this.slot,
    required this.isHidden,
    required this.ability,
  });

  factory PokemonAbilityDto.fromJson(Map<String, dynamic> json) {
    return PokemonAbilityDto(
      slot: json['slot'] as int,
      isHidden: json['is_hidden'] as bool,
      ability: AbilityDto.fromJson(json['ability'] as Map<String, dynamic>),
    );
  }
}

// moves

class MoveDto {
  final int id;
  final String name;
  final String? nameEs;
  final int? typeId;
  final int? power;
  final int? accuracy;
  final int? pp;
  final String? damageClass;

  const MoveDto({
    required this.id,
    required this.name,
    this.nameEs,
    this.typeId,
    this.power,
    this.accuracy,
    this.pp,
    this.damageClass,
  });

  factory MoveDto.fromJson(Map<String, dynamic> json) {
    return MoveDto(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEs: _primerTexto(json, 'movenames', 'name'),
      typeId: json['type_id'] as int?,
      power: json['power'] as int?,
      accuracy: json['accuracy'] as int?,
      pp: json['pp'] as int?,
      damageClass: _nombreDe(json, 'movedamageclass'),
    );
  }
}

class PokemonMoveDto {
  final int versionGroupId;
  final String learnMethod;
  final int level;
  final MoveDto move;

  const PokemonMoveDto({
    required this.versionGroupId,
    required this.learnMethod,
    required this.level,
    required this.move,
  });

  factory PokemonMoveDto.fromJson(Map<String, dynamic> json) {
    return PokemonMoveDto(
      versionGroupId: json['version_group_id'] as int,
      learnMethod: _nombreDe(json, 'movelearnmethod') ?? 'unknown',
      level: json['level'] as int? ?? 0,
      move: MoveDto.fromJson(json['move'] as Map<String, dynamic>),
    );
  }
}

// evos

class EvolutionDto {
  //forma de evolucion
  final int id;
  final String trigger;
  final int? minLevel;
  final int? minHappiness;
  final String? timeOfDay;
  final String? item;

  const EvolutionDto({
    required this.id,
    required this.trigger,
    this.minLevel,
    this.minHappiness,
    this.timeOfDay,
    this.item,
  });

  factory EvolutionDto.fromJson(Map<String, dynamic> json) {
    final time = json['time_of_day'] as String?;
    return EvolutionDto(
      id: json['id'] as int,
      trigger: _nombreDe(json, 'evolutiontrigger') ?? 'unknown',
      minLevel: json['min_level'] as int?,
      minHappiness: json['min_happiness'] as int?,
      timeOfDay: (time == null || time.isEmpty) ? null : time,
      item: _nombreDe(json, 'item'),
    );
  }
}

class ChainSpeciesDto {
  //especie de la cadena con formas de llegar a ella (formas de evolucion)
  final int id;
  final String name;
  final int generationId;
  final int evolutionChainId;
  final int? evolvesFromSpeciesId;
  final List<EvolutionDto> evolutions;

  const ChainSpeciesDto({
    required this.id,
    required this.name,
    required this.generationId,
    required this.evolutionChainId,
    this.evolvesFromSpeciesId,
    required this.evolutions,
  });

  factory ChainSpeciesDto.fromJson(Map<String, dynamic> json) {
    return ChainSpeciesDto(
      id: json['id'] as int,
      name: json['name'] as String,
      generationId: json['generation_id'] as int,
      evolutionChainId: json['evolution_chain_id'] as int,
      evolvesFromSpeciesId: json['evolves_from_species_id'] as int?,
      evolutions: (json['pokemonevolutions'] as List<dynamic>? ?? [])
          .map((e) => EvolutionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

//detalle completo

class PokemonDetailDto {
  final int pokemonId;
  final int speciesId;
  final List<PokemonAbilityDto> abilities;
  final List<PokemonMoveDto> moves;
  final List<int> eggGroupIds;
  final List<ChainSpeciesDto> chain;

  const PokemonDetailDto({
    required this.pokemonId,
    required this.speciesId,
    required this.abilities,
    required this.moves,
    required this.eggGroupIds,
    required this.chain,
  });

  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    final species = json['pokemonspecy'] as Map<String, dynamic>? ?? const {};
    final chainNode = species['evolutionChain'] as Map<String, dynamic>?;

    return PokemonDetailDto(
      pokemonId: json['id'] as int,
      speciesId: species['id'] as int? ?? 0,
      abilities: (json['pokemonabilities'] as List<dynamic>? ?? [])
          .map((e) => PokemonAbilityDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      moves: (json['pokemonmoves'] as List<dynamic>? ?? [])
          .map((e) => PokemonMoveDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      eggGroupIds: (species['pokemonegggroups'] as List<dynamic>? ?? [])
          .map((e) => (e as Map<String, dynamic>)['egg_group_id'] as int)
          .toList(),
      chain: (chainNode?['pokemonspecies'] as List<dynamic>? ?? [])
          .map((e) => ChainSpeciesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  void validate() {
    if (pokemonId <= 0) {
      throw ValidationFailure(
        debugMessage: 'Detalle con id inválido: $pokemonId',
      );
    }
    if (speciesId <= 0) {
      throw ValidationFailure(
        debugMessage: 'El detalle de $pokemonId no tiene especie válida',
      );
    }
    if (abilities.isEmpty) {
      throw ValidationFailure(
        debugMessage: 'El detalle de $pokemonId no tiene habilidades',
      );
    }
    final chainIds = chain.map((s) => s.id).toSet();
    if (chain.isNotEmpty && !chainIds.contains(speciesId)) {
      throw ValidationFailure(
        debugMessage: 'La cadena evolutiva de $pokemonId no incluye su especie',
      );
    }
    for (final species in chain) {
      final from = species.evolvesFromSpeciesId;
      if (from != null && !chainIds.contains(from)) {
        throw ValidationFailure(
          debugMessage:
              'La especie ${species.id} evoluciona de $from, '
              'que no está en la cadena',
        );
      }
    }
  }
}
