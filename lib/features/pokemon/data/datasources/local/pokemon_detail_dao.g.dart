// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_dao.dart';

// ignore_for_file: type=lint
mixin _$PokemonDetailDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenerationsTableTable get generationsTable =>
      attachedDatabase.generationsTable;
  $SpeciesTableTable get speciesTable => attachedDatabase.speciesTable;
  $PokemonTableTable get pokemonTable => attachedDatabase.pokemonTable;
  $TypesTableTable get typesTable => attachedDatabase.typesTable;
  $PokemonTypesTableTable get pokemonTypesTable =>
      attachedDatabase.pokemonTypesTable;
  $AbilitiesTableTable get abilitiesTable => attachedDatabase.abilitiesTable;
  $PokemonAbilitiesTableTable get pokemonAbilitiesTable =>
      attachedDatabase.pokemonAbilitiesTable;
  $MovesTableTable get movesTable => attachedDatabase.movesTable;
  $VersionGroupsTableTable get versionGroupsTable =>
      attachedDatabase.versionGroupsTable;
  $PokemonMovesTableTable get pokemonMovesTable =>
      attachedDatabase.pokemonMovesTable;
  $EvolutionsTableTable get evolutionsTable => attachedDatabase.evolutionsTable;
  $EggGroupsTableTable get eggGroupsTable => attachedDatabase.eggGroupsTable;
  $SpeciesEggGroupsTableTable get speciesEggGroupsTable =>
      attachedDatabase.speciesEggGroupsTable;
  $SyncMetadataTableTable get syncMetadataTable =>
      attachedDatabase.syncMetadataTable;
  PokemonDetailDaoManager get managers => PokemonDetailDaoManager(this);
}

class PokemonDetailDaoManager {
  final _$PokemonDetailDaoMixin _db;
  PokemonDetailDaoManager(this._db);
  $$GenerationsTableTableTableManager get generationsTable =>
      $$GenerationsTableTableTableManager(
        _db.attachedDatabase,
        _db.generationsTable,
      );
  $$SpeciesTableTableTableManager get speciesTable =>
      $$SpeciesTableTableTableManager(_db.attachedDatabase, _db.speciesTable);
  $$PokemonTableTableTableManager get pokemonTable =>
      $$PokemonTableTableTableManager(_db.attachedDatabase, _db.pokemonTable);
  $$TypesTableTableTableManager get typesTable =>
      $$TypesTableTableTableManager(_db.attachedDatabase, _db.typesTable);
  $$PokemonTypesTableTableTableManager get pokemonTypesTable =>
      $$PokemonTypesTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonTypesTable,
      );
  $$AbilitiesTableTableTableManager get abilitiesTable =>
      $$AbilitiesTableTableTableManager(
        _db.attachedDatabase,
        _db.abilitiesTable,
      );
  $$PokemonAbilitiesTableTableTableManager get pokemonAbilitiesTable =>
      $$PokemonAbilitiesTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonAbilitiesTable,
      );
  $$MovesTableTableTableManager get movesTable =>
      $$MovesTableTableTableManager(_db.attachedDatabase, _db.movesTable);
  $$VersionGroupsTableTableTableManager get versionGroupsTable =>
      $$VersionGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.versionGroupsTable,
      );
  $$PokemonMovesTableTableTableManager get pokemonMovesTable =>
      $$PokemonMovesTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonMovesTable,
      );
  $$EvolutionsTableTableTableManager get evolutionsTable =>
      $$EvolutionsTableTableTableManager(
        _db.attachedDatabase,
        _db.evolutionsTable,
      );
  $$EggGroupsTableTableTableManager get eggGroupsTable =>
      $$EggGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.eggGroupsTable,
      );
  $$SpeciesEggGroupsTableTableTableManager get speciesEggGroupsTable =>
      $$SpeciesEggGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.speciesEggGroupsTable,
      );
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(
        _db.attachedDatabase,
        _db.syncMetadataTable,
      );
}
