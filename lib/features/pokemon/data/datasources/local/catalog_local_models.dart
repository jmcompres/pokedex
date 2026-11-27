import 'package:pokedex/core/database/app_database.dart';

class PokemonWithTypes {
  PokemonWithTypes(this.pokemon, this.species, this.types);

  final PokemonRow pokemon;
  final SpeciesRow species;
  final List<TypeRow> types;
}

class ReferenceData {
  const ReferenceData({
    required this.generations,
    required this.types,
    required this.typeEfficacy,
    required this.versionGroups,
    required this.eggGroups,
  });

  final List<GenerationsTableCompanion> generations;
  final List<TypesTableCompanion> types;
  final List<TypeEfficacyTableCompanion> typeEfficacy;
  final List<VersionGroupsTableCompanion> versionGroups;
  final List<EggGroupsTableCompanion> eggGroups;
}

class CatalogPage {
  const CatalogPage({
    required this.species,
    required this.pokemon,
    required this.pokemonTypes,
    required this.forms,
    required this.formTypes,
  });

  final List<SpeciesTableCompanion> species;
  final List<PokemonTableCompanion> pokemon;
  final List<PokemonTypesTableCompanion> pokemonTypes;
  final List<PokemonFormsTableCompanion> forms;
  final List<PokemonFormTypesTableCompanion> formTypes;
}

//escritura de dtalles
class PokemonDetailWrite {
  const PokemonDetailWrite({
    required this.pokemonId,
    required this.speciesId,
    required this.abilities,
    required this.pokemonAbilities,
    required this.moves,
    required this.pokemonMoves,
    required this.chainSpecies,
    required this.evolutions,
    required this.speciesEggGroups,
  });

  final int pokemonId;
  final int speciesId;
  final List<AbilitiesTableCompanion> abilities;
  final List<PokemonAbilitiesTableCompanion> pokemonAbilities;
  final List<MovesTableCompanion> moves;
  final List<PokemonMovesTableCompanion> pokemonMoves;
  final List<SpeciesTableCompanion> chainSpecies;
  final List<EvolutionsTableCompanion> evolutions;
  final List<SpeciesEggGroupsTableCompanion> speciesEggGroups;
}

//lectura de dtealles
typedef AbilityEntry = ({PokemonAbilityRow link, AbilityRow ability});
typedef MoveEntry = ({PokemonMoveRow link, MoveRow move});

class PokemonDetailLocal {
  const PokemonDetailLocal({
    required this.pokemon,
    required this.species,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.chainSpecies,
    required this.evolutions,
    required this.eggGroups,
    required this.varieties,
    required this.versionGroups,
    required this.sync,
  });

  final PokemonRow pokemon;
  final SpeciesRow species;
  final List<TypeRow> types;
  final List<AbilityEntry> abilities;
  final List<MoveEntry> moves;
  final List<SpeciesRow> chainSpecies;
  final List<EvolutionRow> evolutions;
  final List<EggGroupRow> eggGroups;
  final List<PokemonRow> varieties;
  final List<VersionGroupRow> versionGroups;
  final SyncMetadataRow? sync;
}
