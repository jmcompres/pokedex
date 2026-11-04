// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dao.dart';

// ignore_for_file: type=lint
mixin _$PokemonDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenerationsTableTable get generationsTable =>
      attachedDatabase.generationsTable;
  $SpeciesTableTable get speciesTable => attachedDatabase.speciesTable;
  $PokemonTableTable get pokemonTable => attachedDatabase.pokemonTable;
  $PokemonFormsTableTable get pokemonFormsTable =>
      attachedDatabase.pokemonFormsTable;
  $TypesTableTable get typesTable => attachedDatabase.typesTable;
  $PokemonFormTypesTableTable get pokemonFormTypesTable =>
      attachedDatabase.pokemonFormTypesTable;
  $PokemonTypesTableTable get pokemonTypesTable =>
      attachedDatabase.pokemonTypesTable;
  $TypeEfficacyTableTable get typeEfficacyTable =>
      attachedDatabase.typeEfficacyTable;
  $VersionGroupsTableTable get versionGroupsTable =>
      attachedDatabase.versionGroupsTable;
  $EggGroupsTableTable get eggGroupsTable => attachedDatabase.eggGroupsTable;
  $SyncMetadataTableTable get syncMetadataTable =>
      attachedDatabase.syncMetadataTable;
  PokemonDaoManager get managers => PokemonDaoManager(this);
}

class PokemonDaoManager {
  final _$PokemonDaoMixin _db;
  PokemonDaoManager(this._db);
  $$GenerationsTableTableTableManager get generationsTable =>
      $$GenerationsTableTableTableManager(
        _db.attachedDatabase,
        _db.generationsTable,
      );
  $$SpeciesTableTableTableManager get speciesTable =>
      $$SpeciesTableTableTableManager(_db.attachedDatabase, _db.speciesTable);
  $$PokemonTableTableTableManager get pokemonTable =>
      $$PokemonTableTableTableManager(_db.attachedDatabase, _db.pokemonTable);
  $$PokemonFormsTableTableTableManager get pokemonFormsTable =>
      $$PokemonFormsTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonFormsTable,
      );
  $$TypesTableTableTableManager get typesTable =>
      $$TypesTableTableTableManager(_db.attachedDatabase, _db.typesTable);
  $$PokemonFormTypesTableTableTableManager get pokemonFormTypesTable =>
      $$PokemonFormTypesTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonFormTypesTable,
      );
  $$PokemonTypesTableTableTableManager get pokemonTypesTable =>
      $$PokemonTypesTableTableTableManager(
        _db.attachedDatabase,
        _db.pokemonTypesTable,
      );
  $$TypeEfficacyTableTableTableManager get typeEfficacyTable =>
      $$TypeEfficacyTableTableTableManager(
        _db.attachedDatabase,
        _db.typeEfficacyTable,
      );
  $$VersionGroupsTableTableTableManager get versionGroupsTable =>
      $$VersionGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.versionGroupsTable,
      );
  $$EggGroupsTableTableTableManager get eggGroupsTable =>
      $$EggGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.eggGroupsTable,
      );
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(
        _db.attachedDatabase,
        _db.syncMetadataTable,
      );
}
