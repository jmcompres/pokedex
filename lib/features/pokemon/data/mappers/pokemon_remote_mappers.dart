import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokemon/data/datasources/local/catalog_local_models.dart';

import '../datasources/remote/pokemon_remote_dtos.dart';

extension TypeDtoMapper on TypeDto {
  TypesTableCompanion toCompanion() {
    return TypesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: Value(nameEs),
    );
  }
}

extension TypeEfficacyDtoMapper on TypeEfficacyDto {
  TypeEfficacyTableCompanion toCompanion() {
    return TypeEfficacyTableCompanion(
      attackingTypeId: Value(attackTypeId),
      defendingTypeId: Value(defenseTypeId),
      damageFactor: Value(damageFactor),
    );
  }
}

extension GenerationDtoMapper on GenerationDto {
  GenerationsTableCompanion toCompanion() {
    return GenerationsTableCompanion(
      id: Value(id),
      name: Value(name),
      mainRegion: Value(regionName),
    );
  }
}

extension VersionGroupDtoMapper on VersionGroupDto {
  VersionGroupsTableCompanion toCompanion() {
    return VersionGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      generationId: Value(generationId),
      sortOrder: Value(order),
    );
  }
}

extension EggGroupDtoMapper on EggGroupDto {
  EggGroupsTableCompanion toCompanion() {
    return EggGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: Value(nameEs),
    );
  }
}

extension ReferenceDataDtoMapper on ReferenceDataDto {
  ReferenceData toLocal() {
    return ReferenceData(
      generations: generations.map((e) => e.toCompanion()).toList(),
      types: types.map((e) => e.toCompanion()).toList(),
      typeEfficacy: typeEfficacy.map((e) => e.toCompanion()).toList(),
      versionGroups: versionGroups.map((e) => e.toCompanion()).toList(),
      eggGroups: eggGroups.map((e) => e.toCompanion()).toList(),
    );
  }

  Future<ReferenceData> toLocalAsync() {
    final dto = this;
    return Isolate.run(dto.toLocal);
  }
}

extension SpeciesDtoMapper on SpeciesDto {
  SpeciesTableCompanion toCompanion() {
    return SpeciesTableCompanion(
      id: Value(id),
      name: Value(name),
      generationId: Value(generationId),
      evolutionChainId: Value(evolutionChainId ?? 0),
    );
  }
}

extension PokemonDtoMapper on PokemonDto {
  PokemonTableCompanion toPokemonCompanion({DateTime? updatedAt}) {
    final statsMap = {for (final s in stats) s.name: s.baseStat};

    return PokemonTableCompanion(
      id: Value(id),
      speciesId: Value(species!.id),
      name: Value(name),
      isDefault: Value(isDefault),
      height: Value(height),
      weight: Value(weight),
      hp: Value(statsMap['hp']!),
      attack: Value(statsMap['attack']!),
      defense: Value(statsMap['defense']!),
      specialAttack: Value(statsMap['special-attack']!),
      specialDefense: Value(statsMap['special-defense']!),
      speed: Value(statsMap['speed']!),
      spriteUrl: Value(sprites.spriteUrl),
      spriteShinyUrl: Value(sprites.spriteShinyUrl),
      artworkUrl: Value(sprites.artworkUrl),
      artworkShinyUrl: Value(sprites.artworkShinyUrl),
      updatedAt: Value(updatedAt ?? DateTime.now()),
    );
  }

  SpeciesTableCompanion toSpeciesCompanion() {
    return species!.toCompanion();
  }

  List<PokemonTypesTableCompanion> toTypeCompanions() {
    return types
        .map(
          (t) => PokemonTypesTableCompanion(
            pokemonId: Value(id),
            typeId: Value(t.typeId),
            slot: Value(t.slot),
          ),
        )
        .toList();
  }

  List<PokemonFormsTableCompanion> toFormCompanions() {
    final soloUnaForma = forms.length == 1;

    return forms
        .map(
          (f) => PokemonFormsTableCompanion(
            id: Value(f.id),
            pokemonId: Value(id),
            name: Value(f.name),
            formName: Value(f.formName),
            isDefault: Value(soloUnaForma || f.isDefault),
            isMega: Value(f.isMega),
            isBattleOnly: Value(f.isBattleOnly),
            formOrder: Value(f.formOrder),
            spriteUrl: Value(sprites.spriteUrl),
            spriteShinyUrl: Value(sprites.spriteShinyUrl),
          ),
        )
        .toList();
  }

  List<PokemonFormTypesTableCompanion> toFormTypeCompanions() {
    final formTypes = <PokemonFormTypesTableCompanion>[];
    for (final form in forms) {
      for (final type in types) {
        formTypes.add(
          PokemonFormTypesTableCompanion(
            formId: Value(form.id),
            typeId: Value(type.typeId),
            slot: Value(type.slot),
          ),
        );
      }
    }
    return formTypes;
  }
}

extension PokemonPageMapper on List<PokemonDto> {
  CatalogPage toCatalogPage({DateTime? updatedAt}) {
    final timestamp = updatedAt ?? DateTime.now();

    final uniqueSpecies = <int, SpeciesTableCompanion>{};
    for (final dto in this) {
      uniqueSpecies[dto.species!.id] = dto.toSpeciesCompanion();
    }

    return CatalogPage(
      species: uniqueSpecies.values.toList(),
      pokemon: map((dto) => dto.toPokemonCompanion(updatedAt: timestamp))
          .toList(),
      pokemonTypes: expand((dto) => dto.toTypeCompanions()).toList(),
      forms: expand((dto) => dto.toFormCompanions()).toList(),
      formTypes: expand((dto) => dto.toFormTypeCompanions()).toList(),
    );
  }

  Future<CatalogPage> toCatalogPageAsync({DateTime? updatedAt}) {
    final page = this;
    return Isolate.run(() => page.toCatalogPage(updatedAt: updatedAt));
  }
}
