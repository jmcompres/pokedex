// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GenerationsTableTable extends GenerationsTable
    with TableInfo<$GenerationsTableTable, GenerationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenerationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainRegionMeta = const VerificationMeta(
    'mainRegion',
  );
  @override
  late final GeneratedColumn<String> mainRegion = GeneratedColumn<String>(
    'main_region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, mainRegion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generation';
  @override
  VerificationContext validateIntegrity(
    Insertable<GenerationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('main_region')) {
      context.handle(
        _mainRegionMeta,
        mainRegion.isAcceptableOrUnknown(data['main_region']!, _mainRegionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GenerationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenerationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mainRegion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_region'],
      ),
    );
  }

  @override
  $GenerationsTableTable createAlias(String alias) {
    return $GenerationsTableTable(attachedDatabase, alias);
  }
}

class GenerationRow extends DataClass implements Insertable<GenerationRow> {
  final int id;
  final String name;
  final String? mainRegion;
  const GenerationRow({required this.id, required this.name, this.mainRegion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || mainRegion != null) {
      map['main_region'] = Variable<String>(mainRegion);
    }
    return map;
  }

  GenerationsTableCompanion toCompanion(bool nullToAbsent) {
    return GenerationsTableCompanion(
      id: Value(id),
      name: Value(name),
      mainRegion: mainRegion == null && nullToAbsent
          ? const Value.absent()
          : Value(mainRegion),
    );
  }

  factory GenerationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenerationRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mainRegion: serializer.fromJson<String?>(json['mainRegion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'mainRegion': serializer.toJson<String?>(mainRegion),
    };
  }

  GenerationRow copyWith({
    int? id,
    String? name,
    Value<String?> mainRegion = const Value.absent(),
  }) => GenerationRow(
    id: id ?? this.id,
    name: name ?? this.name,
    mainRegion: mainRegion.present ? mainRegion.value : this.mainRegion,
  );
  GenerationRow copyWithCompanion(GenerationsTableCompanion data) {
    return GenerationRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mainRegion: data.mainRegion.present
          ? data.mainRegion.value
          : this.mainRegion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GenerationRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mainRegion: $mainRegion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, mainRegion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenerationRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.mainRegion == this.mainRegion);
}

class GenerationsTableCompanion extends UpdateCompanion<GenerationRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> mainRegion;
  const GenerationsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mainRegion = const Value.absent(),
  });
  GenerationsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.mainRegion = const Value.absent(),
  }) : name = Value(name);
  static Insertable<GenerationRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? mainRegion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mainRegion != null) 'main_region': mainRegion,
    });
  }

  GenerationsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? mainRegion,
  }) {
    return GenerationsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mainRegion: mainRegion ?? this.mainRegion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mainRegion.present) {
      map['main_region'] = Variable<String>(mainRegion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenerationsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mainRegion: $mainRegion')
          ..write(')'))
        .toString();
  }
}

class $SpeciesTableTable extends SpeciesTable
    with TableInfo<$SpeciesTableTable, SpeciesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES generation (id)',
    ),
  );
  static const VerificationMeta _evolutionChainIdMeta = const VerificationMeta(
    'evolutionChainId',
  );
  @override
  late final GeneratedColumn<int> evolutionChainId = GeneratedColumn<int>(
    'evolution_chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    generationId,
    evolutionChainId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generationIdMeta);
    }
    if (data.containsKey('evolution_chain_id')) {
      context.handle(
        _evolutionChainIdMeta,
        evolutionChainId.isAcceptableOrUnknown(
          data['evolution_chain_id']!,
          _evolutionChainIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evolutionChainIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      )!,
      evolutionChainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_chain_id'],
      )!,
    );
  }

  @override
  $SpeciesTableTable createAlias(String alias) {
    return $SpeciesTableTable(attachedDatabase, alias);
  }
}

class SpeciesRow extends DataClass implements Insertable<SpeciesRow> {
  final int id;
  final String name;
  final int generationId;
  final int evolutionChainId;
  const SpeciesRow({
    required this.id,
    required this.name,
    required this.generationId,
    required this.evolutionChainId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['generation_id'] = Variable<int>(generationId);
    map['evolution_chain_id'] = Variable<int>(evolutionChainId);
    return map;
  }

  SpeciesTableCompanion toCompanion(bool nullToAbsent) {
    return SpeciesTableCompanion(
      id: Value(id),
      name: Value(name),
      generationId: Value(generationId),
      evolutionChainId: Value(evolutionChainId),
    );
  }

  factory SpeciesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      generationId: serializer.fromJson<int>(json['generationId']),
      evolutionChainId: serializer.fromJson<int>(json['evolutionChainId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'generationId': serializer.toJson<int>(generationId),
      'evolutionChainId': serializer.toJson<int>(evolutionChainId),
    };
  }

  SpeciesRow copyWith({
    int? id,
    String? name,
    int? generationId,
    int? evolutionChainId,
  }) => SpeciesRow(
    id: id ?? this.id,
    name: name ?? this.name,
    generationId: generationId ?? this.generationId,
    evolutionChainId: evolutionChainId ?? this.evolutionChainId,
  );
  SpeciesRow copyWithCompanion(SpeciesTableCompanion data) {
    return SpeciesRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      evolutionChainId: data.evolutionChainId.present
          ? data.evolutionChainId.value
          : this.evolutionChainId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('evolutionChainId: $evolutionChainId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, generationId, evolutionChainId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.generationId == this.generationId &&
          other.evolutionChainId == this.evolutionChainId);
}

class SpeciesTableCompanion extends UpdateCompanion<SpeciesRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> generationId;
  final Value<int> evolutionChainId;
  const SpeciesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.generationId = const Value.absent(),
    this.evolutionChainId = const Value.absent(),
  });
  SpeciesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int generationId,
    required int evolutionChainId,
  }) : name = Value(name),
       generationId = Value(generationId),
       evolutionChainId = Value(evolutionChainId);
  static Insertable<SpeciesRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? generationId,
    Expression<int>? evolutionChainId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (generationId != null) 'generation_id': generationId,
      if (evolutionChainId != null) 'evolution_chain_id': evolutionChainId,
    });
  }

  SpeciesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? generationId,
    Value<int>? evolutionChainId,
  }) {
    return SpeciesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      generationId: generationId ?? this.generationId,
      evolutionChainId: evolutionChainId ?? this.evolutionChainId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (evolutionChainId.present) {
      map['evolution_chain_id'] = Variable<int>(evolutionChainId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('evolutionChainId: $evolutionChainId')
          ..write(')'))
        .toString();
  }
}

class $PokemonTableTable extends PokemonTable
    with TableInfo<$PokemonTableTable, PokemonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<int> hp = GeneratedColumn<int>(
    'hp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attackMeta = const VerificationMeta('attack');
  @override
  late final GeneratedColumn<int> attack = GeneratedColumn<int>(
    'attack',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defenseMeta = const VerificationMeta(
    'defense',
  );
  @override
  late final GeneratedColumn<int> defense = GeneratedColumn<int>(
    'defense',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialAttackMeta = const VerificationMeta(
    'specialAttack',
  );
  @override
  late final GeneratedColumn<int> specialAttack = GeneratedColumn<int>(
    'special_attack',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialDefenseMeta = const VerificationMeta(
    'specialDefense',
  );
  @override
  late final GeneratedColumn<int> specialDefense = GeneratedColumn<int>(
    'special_defense',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<int> speed = GeneratedColumn<int>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseStatTotalMeta = const VerificationMeta(
    'baseStatTotal',
  );
  @override
  late final GeneratedColumn<int> baseStatTotal = GeneratedColumn<int>(
    'base_stat_total',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      hp + attack + defense + specialAttack + specialDefense + speed,
      true,
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteUrlMeta = const VerificationMeta(
    'spriteUrl',
  );
  @override
  late final GeneratedColumn<String> spriteUrl = GeneratedColumn<String>(
    'sprite_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteShinyUrlMeta = const VerificationMeta(
    'spriteShinyUrl',
  );
  @override
  late final GeneratedColumn<String> spriteShinyUrl = GeneratedColumn<String>(
    'sprite_shiny_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkUrlMeta = const VerificationMeta(
    'artworkUrl',
  );
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
    'artwork_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkShinyUrlMeta = const VerificationMeta(
    'artworkShinyUrl',
  );
  @override
  late final GeneratedColumn<String> artworkShinyUrl = GeneratedColumn<String>(
    'artwork_shiny_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkLocalPathMeta = const VerificationMeta(
    'artworkLocalPath',
  );
  @override
  late final GeneratedColumn<String> artworkLocalPath = GeneratedColumn<String>(
    'artwork_local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    name,
    isDefault,
    height,
    weight,
    hp,
    attack,
    defense,
    specialAttack,
    specialDefense,
    speed,
    baseStatTotal,
    spriteUrl,
    spriteShinyUrl,
    artworkUrl,
    artworkShinyUrl,
    artworkLocalPath,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
    } else if (isInserting) {
      context.missing(_hpMeta);
    }
    if (data.containsKey('attack')) {
      context.handle(
        _attackMeta,
        attack.isAcceptableOrUnknown(data['attack']!, _attackMeta),
      );
    } else if (isInserting) {
      context.missing(_attackMeta);
    }
    if (data.containsKey('defense')) {
      context.handle(
        _defenseMeta,
        defense.isAcceptableOrUnknown(data['defense']!, _defenseMeta),
      );
    } else if (isInserting) {
      context.missing(_defenseMeta);
    }
    if (data.containsKey('special_attack')) {
      context.handle(
        _specialAttackMeta,
        specialAttack.isAcceptableOrUnknown(
          data['special_attack']!,
          _specialAttackMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialAttackMeta);
    }
    if (data.containsKey('special_defense')) {
      context.handle(
        _specialDefenseMeta,
        specialDefense.isAcceptableOrUnknown(
          data['special_defense']!,
          _specialDefenseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialDefenseMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('base_stat_total')) {
      context.handle(
        _baseStatTotalMeta,
        baseStatTotal.isAcceptableOrUnknown(
          data['base_stat_total']!,
          _baseStatTotalMeta,
        ),
      );
    }
    if (data.containsKey('sprite_url')) {
      context.handle(
        _spriteUrlMeta,
        spriteUrl.isAcceptableOrUnknown(data['sprite_url']!, _spriteUrlMeta),
      );
    }
    if (data.containsKey('sprite_shiny_url')) {
      context.handle(
        _spriteShinyUrlMeta,
        spriteShinyUrl.isAcceptableOrUnknown(
          data['sprite_shiny_url']!,
          _spriteShinyUrlMeta,
        ),
      );
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
        _artworkUrlMeta,
        artworkUrl.isAcceptableOrUnknown(data['artwork_url']!, _artworkUrlMeta),
      );
    }
    if (data.containsKey('artwork_shiny_url')) {
      context.handle(
        _artworkShinyUrlMeta,
        artworkShinyUrl.isAcceptableOrUnknown(
          data['artwork_shiny_url']!,
          _artworkShinyUrlMeta,
        ),
      );
    }
    if (data.containsKey('artwork_local_path')) {
      context.handle(
        _artworkLocalPathMeta,
        artworkLocalPath.isAcceptableOrUnknown(
          data['artwork_local_path']!,
          _artworkLocalPathMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      hp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hp'],
      )!,
      attack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attack'],
      )!,
      defense: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defense'],
      )!,
      specialAttack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}special_attack'],
      )!,
      specialDefense: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}special_defense'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}speed'],
      )!,
      baseStatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat_total'],
      )!,
      spriteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_url'],
      ),
      spriteShinyUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_shiny_url'],
      ),
      artworkUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_url'],
      ),
      artworkShinyUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_shiny_url'],
      ),
      artworkLocalPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_local_path'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PokemonTableTable createAlias(String alias) {
    return $PokemonTableTable(attachedDatabase, alias);
  }
}

class PokemonRow extends DataClass implements Insertable<PokemonRow> {
  final int id;
  final int speciesId;
  final String name;
  final bool isDefault;
  final int? height;
  final int? weight;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final int baseStatTotal;
  final String? spriteUrl;
  final String? spriteShinyUrl;
  final String? artworkUrl;
  final String? artworkShinyUrl;
  final String? artworkLocalPath;
  final DateTime updatedAt;
  const PokemonRow({
    required this.id,
    required this.speciesId,
    required this.name,
    required this.isDefault,
    this.height,
    this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.baseStatTotal,
    this.spriteUrl,
    this.spriteShinyUrl,
    this.artworkUrl,
    this.artworkShinyUrl,
    this.artworkLocalPath,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['species_id'] = Variable<int>(speciesId);
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<bool>(isDefault);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    map['hp'] = Variable<int>(hp);
    map['attack'] = Variable<int>(attack);
    map['defense'] = Variable<int>(defense);
    map['special_attack'] = Variable<int>(specialAttack);
    map['special_defense'] = Variable<int>(specialDefense);
    map['speed'] = Variable<int>(speed);
    if (!nullToAbsent || spriteUrl != null) {
      map['sprite_url'] = Variable<String>(spriteUrl);
    }
    if (!nullToAbsent || spriteShinyUrl != null) {
      map['sprite_shiny_url'] = Variable<String>(spriteShinyUrl);
    }
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    if (!nullToAbsent || artworkShinyUrl != null) {
      map['artwork_shiny_url'] = Variable<String>(artworkShinyUrl);
    }
    if (!nullToAbsent || artworkLocalPath != null) {
      map['artwork_local_path'] = Variable<String>(artworkLocalPath);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PokemonTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonTableCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      name: Value(name),
      isDefault: Value(isDefault),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      hp: Value(hp),
      attack: Value(attack),
      defense: Value(defense),
      specialAttack: Value(specialAttack),
      specialDefense: Value(specialDefense),
      speed: Value(speed),
      spriteUrl: spriteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteUrl),
      spriteShinyUrl: spriteShinyUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteShinyUrl),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      artworkShinyUrl: artworkShinyUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkShinyUrl),
      artworkLocalPath: artworkLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkLocalPath),
      updatedAt: Value(updatedAt),
    );
  }

  factory PokemonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonRow(
      id: serializer.fromJson<int>(json['id']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      hp: serializer.fromJson<int>(json['hp']),
      attack: serializer.fromJson<int>(json['attack']),
      defense: serializer.fromJson<int>(json['defense']),
      specialAttack: serializer.fromJson<int>(json['specialAttack']),
      specialDefense: serializer.fromJson<int>(json['specialDefense']),
      speed: serializer.fromJson<int>(json['speed']),
      baseStatTotal: serializer.fromJson<int>(json['baseStatTotal']),
      spriteUrl: serializer.fromJson<String?>(json['spriteUrl']),
      spriteShinyUrl: serializer.fromJson<String?>(json['spriteShinyUrl']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      artworkShinyUrl: serializer.fromJson<String?>(json['artworkShinyUrl']),
      artworkLocalPath: serializer.fromJson<String?>(json['artworkLocalPath']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'speciesId': serializer.toJson<int>(speciesId),
      'name': serializer.toJson<String>(name),
      'isDefault': serializer.toJson<bool>(isDefault),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'hp': serializer.toJson<int>(hp),
      'attack': serializer.toJson<int>(attack),
      'defense': serializer.toJson<int>(defense),
      'specialAttack': serializer.toJson<int>(specialAttack),
      'specialDefense': serializer.toJson<int>(specialDefense),
      'speed': serializer.toJson<int>(speed),
      'baseStatTotal': serializer.toJson<int>(baseStatTotal),
      'spriteUrl': serializer.toJson<String?>(spriteUrl),
      'spriteShinyUrl': serializer.toJson<String?>(spriteShinyUrl),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'artworkShinyUrl': serializer.toJson<String?>(artworkShinyUrl),
      'artworkLocalPath': serializer.toJson<String?>(artworkLocalPath),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PokemonRow copyWith({
    int? id,
    int? speciesId,
    String? name,
    bool? isDefault,
    Value<int?> height = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
    int? baseStatTotal,
    Value<String?> spriteUrl = const Value.absent(),
    Value<String?> spriteShinyUrl = const Value.absent(),
    Value<String?> artworkUrl = const Value.absent(),
    Value<String?> artworkShinyUrl = const Value.absent(),
    Value<String?> artworkLocalPath = const Value.absent(),
    DateTime? updatedAt,
  }) => PokemonRow(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    name: name ?? this.name,
    isDefault: isDefault ?? this.isDefault,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    hp: hp ?? this.hp,
    attack: attack ?? this.attack,
    defense: defense ?? this.defense,
    specialAttack: specialAttack ?? this.specialAttack,
    specialDefense: specialDefense ?? this.specialDefense,
    speed: speed ?? this.speed,
    baseStatTotal: baseStatTotal ?? this.baseStatTotal,
    spriteUrl: spriteUrl.present ? spriteUrl.value : this.spriteUrl,
    spriteShinyUrl: spriteShinyUrl.present
        ? spriteShinyUrl.value
        : this.spriteShinyUrl,
    artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
    artworkShinyUrl: artworkShinyUrl.present
        ? artworkShinyUrl.value
        : this.artworkShinyUrl,
    artworkLocalPath: artworkLocalPath.present
        ? artworkLocalPath.value
        : this.artworkLocalPath,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  @override
  String toString() {
    return (StringBuffer('PokemonRow(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('specialAttack: $specialAttack, ')
          ..write('specialDefense: $specialDefense, ')
          ..write('speed: $speed, ')
          ..write('baseStatTotal: $baseStatTotal, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('spriteShinyUrl: $spriteShinyUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('artworkShinyUrl: $artworkShinyUrl, ')
          ..write('artworkLocalPath: $artworkLocalPath, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    speciesId,
    name,
    isDefault,
    height,
    weight,
    hp,
    attack,
    defense,
    specialAttack,
    specialDefense,
    speed,
    baseStatTotal,
    spriteUrl,
    spriteShinyUrl,
    artworkUrl,
    artworkShinyUrl,
    artworkLocalPath,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.hp == this.hp &&
          other.attack == this.attack &&
          other.defense == this.defense &&
          other.specialAttack == this.specialAttack &&
          other.specialDefense == this.specialDefense &&
          other.speed == this.speed &&
          other.baseStatTotal == this.baseStatTotal &&
          other.spriteUrl == this.spriteUrl &&
          other.spriteShinyUrl == this.spriteShinyUrl &&
          other.artworkUrl == this.artworkUrl &&
          other.artworkShinyUrl == this.artworkShinyUrl &&
          other.artworkLocalPath == this.artworkLocalPath &&
          other.updatedAt == this.updatedAt);
}

class PokemonTableCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<int> speciesId;
  final Value<String> name;
  final Value<bool> isDefault;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<int> hp;
  final Value<int> attack;
  final Value<int> defense;
  final Value<int> specialAttack;
  final Value<int> specialDefense;
  final Value<int> speed;
  final Value<String?> spriteUrl;
  final Value<String?> spriteShinyUrl;
  final Value<String?> artworkUrl;
  final Value<String?> artworkShinyUrl;
  final Value<String?> artworkLocalPath;
  final Value<DateTime> updatedAt;
  const PokemonTableCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.hp = const Value.absent(),
    this.attack = const Value.absent(),
    this.defense = const Value.absent(),
    this.specialAttack = const Value.absent(),
    this.specialDefense = const Value.absent(),
    this.speed = const Value.absent(),
    this.spriteUrl = const Value.absent(),
    this.spriteShinyUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.artworkShinyUrl = const Value.absent(),
    this.artworkLocalPath = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PokemonTableCompanion.insert({
    this.id = const Value.absent(),
    required int speciesId,
    required String name,
    required bool isDefault,
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    required int hp,
    required int attack,
    required int defense,
    required int specialAttack,
    required int specialDefense,
    required int speed,
    this.spriteUrl = const Value.absent(),
    this.spriteShinyUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.artworkShinyUrl = const Value.absent(),
    this.artworkLocalPath = const Value.absent(),
    required DateTime updatedAt,
  }) : speciesId = Value(speciesId),
       name = Value(name),
       isDefault = Value(isDefault),
       hp = Value(hp),
       attack = Value(attack),
       defense = Value(defense),
       specialAttack = Value(specialAttack),
       specialDefense = Value(specialDefense),
       speed = Value(speed),
       updatedAt = Value(updatedAt);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<int>? speciesId,
    Expression<String>? name,
    Expression<bool>? isDefault,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<int>? hp,
    Expression<int>? attack,
    Expression<int>? defense,
    Expression<int>? specialAttack,
    Expression<int>? specialDefense,
    Expression<int>? speed,
    Expression<String>? spriteUrl,
    Expression<String>? spriteShinyUrl,
    Expression<String>? artworkUrl,
    Expression<String>? artworkShinyUrl,
    Expression<String>? artworkLocalPath,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (hp != null) 'hp': hp,
      if (attack != null) 'attack': attack,
      if (defense != null) 'defense': defense,
      if (specialAttack != null) 'special_attack': specialAttack,
      if (specialDefense != null) 'special_defense': specialDefense,
      if (speed != null) 'speed': speed,
      if (spriteUrl != null) 'sprite_url': spriteUrl,
      if (spriteShinyUrl != null) 'sprite_shiny_url': spriteShinyUrl,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (artworkShinyUrl != null) 'artwork_shiny_url': artworkShinyUrl,
      if (artworkLocalPath != null) 'artwork_local_path': artworkLocalPath,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PokemonTableCompanion copyWith({
    Value<int>? id,
    Value<int>? speciesId,
    Value<String>? name,
    Value<bool>? isDefault,
    Value<int?>? height,
    Value<int?>? weight,
    Value<int>? hp,
    Value<int>? attack,
    Value<int>? defense,
    Value<int>? specialAttack,
    Value<int>? specialDefense,
    Value<int>? speed,
    Value<String?>? spriteUrl,
    Value<String?>? spriteShinyUrl,
    Value<String?>? artworkUrl,
    Value<String?>? artworkShinyUrl,
    Value<String?>? artworkLocalPath,
    Value<DateTime>? updatedAt,
  }) {
    return PokemonTableCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefense: specialDefense ?? this.specialDefense,
      speed: speed ?? this.speed,
      spriteUrl: spriteUrl ?? this.spriteUrl,
      spriteShinyUrl: spriteShinyUrl ?? this.spriteShinyUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      artworkShinyUrl: artworkShinyUrl ?? this.artworkShinyUrl,
      artworkLocalPath: artworkLocalPath ?? this.artworkLocalPath,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (hp.present) {
      map['hp'] = Variable<int>(hp.value);
    }
    if (attack.present) {
      map['attack'] = Variable<int>(attack.value);
    }
    if (defense.present) {
      map['defense'] = Variable<int>(defense.value);
    }
    if (specialAttack.present) {
      map['special_attack'] = Variable<int>(specialAttack.value);
    }
    if (specialDefense.present) {
      map['special_defense'] = Variable<int>(specialDefense.value);
    }
    if (speed.present) {
      map['speed'] = Variable<int>(speed.value);
    }
    if (spriteUrl.present) {
      map['sprite_url'] = Variable<String>(spriteUrl.value);
    }
    if (spriteShinyUrl.present) {
      map['sprite_shiny_url'] = Variable<String>(spriteShinyUrl.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (artworkShinyUrl.present) {
      map['artwork_shiny_url'] = Variable<String>(artworkShinyUrl.value);
    }
    if (artworkLocalPath.present) {
      map['artwork_local_path'] = Variable<String>(artworkLocalPath.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTableCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('specialAttack: $specialAttack, ')
          ..write('specialDefense: $specialDefense, ')
          ..write('speed: $speed, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('spriteShinyUrl: $spriteShinyUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('artworkShinyUrl: $artworkShinyUrl, ')
          ..write('artworkLocalPath: $artworkLocalPath, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TypesTableTable extends TypesTable
    with TableInfo<$TypesTableTable, TypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, nameEs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
    );
  }

  @override
  $TypesTableTable createAlias(String alias) {
    return $TypesTableTable(attachedDatabase, alias);
  }
}

class TypeRow extends DataClass implements Insertable<TypeRow> {
  final int id;
  final String name;
  final String? nameEs;
  const TypeRow({required this.id, required this.name, this.nameEs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    return map;
  }

  TypesTableCompanion toCompanion(bool nullToAbsent) {
    return TypesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
    );
  }

  factory TypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
    };
  }

  TypeRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
  }) => TypeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
  );
  TypeRow copyWithCompanion(TypesTableCompanion data) {
    return TypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs);
}

class TypesTableCompanion extends UpdateCompanion<TypeRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  const TypesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
  });
  TypesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TypeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
    });
  }

  TypesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
  }) {
    return TypesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTableTable extends PokemonTypesTable
    with TableInfo<$PokemonTypesTableTable, PokemonTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_type';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  PokemonTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonTypesTableTable createAlias(String alias) {
    return $PokemonTypesTableTable(attachedDatabase, alias);
  }
}

class PokemonTypeRow extends DataClass implements Insertable<PokemonTypeRow> {
  final int pokemonId;
  final int typeId;
  final int slot;
  const PokemonTypeRow({
    required this.pokemonId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonTypesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesTableCompanion(
      pokemonId: Value(pokemonId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTypeRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonTypeRow copyWith({int? pokemonId, int? typeId, int? slot}) =>
      PokemonTypeRow(
        pokemonId: pokemonId ?? this.pokemonId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonTypeRow copyWithCompanion(PokemonTypesTableCompanion data) {
    return PokemonTypeRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTypeRow &&
          other.pokemonId == this.pokemonId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonTypesTableCompanion extends UpdateCompanion<PokemonTypeRow> {
  final Value<int> pokemonId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonTypesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonTypesTableCompanion.insert({
    required int pokemonId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonTypeRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonTypesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonTypesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonFormsTableTable extends PokemonFormsTable
    with TableInfo<$PokemonFormsTableTable, PokemonFormRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonFormsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formNameMeta = const VerificationMeta(
    'formName',
  );
  @override
  late final GeneratedColumn<String> formName = GeneratedColumn<String>(
    'form_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isMegaMeta = const VerificationMeta('isMega');
  @override
  late final GeneratedColumn<bool> isMega = GeneratedColumn<bool>(
    'is_mega',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mega" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isBattleOnlyMeta = const VerificationMeta(
    'isBattleOnly',
  );
  @override
  late final GeneratedColumn<bool> isBattleOnly = GeneratedColumn<bool>(
    'is_battle_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_battle_only" IN (0, 1))',
    ),
  );
  static const VerificationMeta _formOrderMeta = const VerificationMeta(
    'formOrder',
  );
  @override
  late final GeneratedColumn<int> formOrder = GeneratedColumn<int>(
    'form_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteUrlMeta = const VerificationMeta(
    'spriteUrl',
  );
  @override
  late final GeneratedColumn<String> spriteUrl = GeneratedColumn<String>(
    'sprite_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteShinyUrlMeta = const VerificationMeta(
    'spriteShinyUrl',
  );
  @override
  late final GeneratedColumn<String> spriteShinyUrl = GeneratedColumn<String>(
    'sprite_shiny_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pokemonId,
    name,
    formName,
    isDefault,
    isMega,
    isBattleOnly,
    formOrder,
    spriteUrl,
    spriteShinyUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_form';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonFormRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('form_name')) {
      context.handle(
        _formNameMeta,
        formName.isAcceptableOrUnknown(data['form_name']!, _formNameMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('is_mega')) {
      context.handle(
        _isMegaMeta,
        isMega.isAcceptableOrUnknown(data['is_mega']!, _isMegaMeta),
      );
    } else if (isInserting) {
      context.missing(_isMegaMeta);
    }
    if (data.containsKey('is_battle_only')) {
      context.handle(
        _isBattleOnlyMeta,
        isBattleOnly.isAcceptableOrUnknown(
          data['is_battle_only']!,
          _isBattleOnlyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isBattleOnlyMeta);
    }
    if (data.containsKey('form_order')) {
      context.handle(
        _formOrderMeta,
        formOrder.isAcceptableOrUnknown(data['form_order']!, _formOrderMeta),
      );
    }
    if (data.containsKey('sprite_url')) {
      context.handle(
        _spriteUrlMeta,
        spriteUrl.isAcceptableOrUnknown(data['sprite_url']!, _spriteUrlMeta),
      );
    }
    if (data.containsKey('sprite_shiny_url')) {
      context.handle(
        _spriteShinyUrlMeta,
        spriteShinyUrl.isAcceptableOrUnknown(
          data['sprite_shiny_url']!,
          _spriteShinyUrlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonFormRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonFormRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      formName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_name'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isMega: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mega'],
      )!,
      isBattleOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_battle_only'],
      )!,
      formOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}form_order'],
      ),
      spriteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_url'],
      ),
      spriteShinyUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_shiny_url'],
      ),
    );
  }

  @override
  $PokemonFormsTableTable createAlias(String alias) {
    return $PokemonFormsTableTable(attachedDatabase, alias);
  }
}

class PokemonFormRow extends DataClass implements Insertable<PokemonFormRow> {
  final int id;
  final int pokemonId;
  final String name;
  final String? formName;
  final bool isDefault;
  final bool isMega;
  final bool isBattleOnly;
  final int? formOrder;
  final String? spriteUrl;
  final String? spriteShinyUrl;
  const PokemonFormRow({
    required this.id,
    required this.pokemonId,
    required this.name,
    this.formName,
    required this.isDefault,
    required this.isMega,
    required this.isBattleOnly,
    this.formOrder,
    this.spriteUrl,
    this.spriteShinyUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || formName != null) {
      map['form_name'] = Variable<String>(formName);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_mega'] = Variable<bool>(isMega);
    map['is_battle_only'] = Variable<bool>(isBattleOnly);
    if (!nullToAbsent || formOrder != null) {
      map['form_order'] = Variable<int>(formOrder);
    }
    if (!nullToAbsent || spriteUrl != null) {
      map['sprite_url'] = Variable<String>(spriteUrl);
    }
    if (!nullToAbsent || spriteShinyUrl != null) {
      map['sprite_shiny_url'] = Variable<String>(spriteShinyUrl);
    }
    return map;
  }

  PokemonFormsTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonFormsTableCompanion(
      id: Value(id),
      pokemonId: Value(pokemonId),
      name: Value(name),
      formName: formName == null && nullToAbsent
          ? const Value.absent()
          : Value(formName),
      isDefault: Value(isDefault),
      isMega: Value(isMega),
      isBattleOnly: Value(isBattleOnly),
      formOrder: formOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(formOrder),
      spriteUrl: spriteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteUrl),
      spriteShinyUrl: spriteShinyUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteShinyUrl),
    );
  }

  factory PokemonFormRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonFormRow(
      id: serializer.fromJson<int>(json['id']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      name: serializer.fromJson<String>(json['name']),
      formName: serializer.fromJson<String?>(json['formName']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isMega: serializer.fromJson<bool>(json['isMega']),
      isBattleOnly: serializer.fromJson<bool>(json['isBattleOnly']),
      formOrder: serializer.fromJson<int?>(json['formOrder']),
      spriteUrl: serializer.fromJson<String?>(json['spriteUrl']),
      spriteShinyUrl: serializer.fromJson<String?>(json['spriteShinyUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'name': serializer.toJson<String>(name),
      'formName': serializer.toJson<String?>(formName),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isMega': serializer.toJson<bool>(isMega),
      'isBattleOnly': serializer.toJson<bool>(isBattleOnly),
      'formOrder': serializer.toJson<int?>(formOrder),
      'spriteUrl': serializer.toJson<String?>(spriteUrl),
      'spriteShinyUrl': serializer.toJson<String?>(spriteShinyUrl),
    };
  }

  PokemonFormRow copyWith({
    int? id,
    int? pokemonId,
    String? name,
    Value<String?> formName = const Value.absent(),
    bool? isDefault,
    bool? isMega,
    bool? isBattleOnly,
    Value<int?> formOrder = const Value.absent(),
    Value<String?> spriteUrl = const Value.absent(),
    Value<String?> spriteShinyUrl = const Value.absent(),
  }) => PokemonFormRow(
    id: id ?? this.id,
    pokemonId: pokemonId ?? this.pokemonId,
    name: name ?? this.name,
    formName: formName.present ? formName.value : this.formName,
    isDefault: isDefault ?? this.isDefault,
    isMega: isMega ?? this.isMega,
    isBattleOnly: isBattleOnly ?? this.isBattleOnly,
    formOrder: formOrder.present ? formOrder.value : this.formOrder,
    spriteUrl: spriteUrl.present ? spriteUrl.value : this.spriteUrl,
    spriteShinyUrl: spriteShinyUrl.present
        ? spriteShinyUrl.value
        : this.spriteShinyUrl,
  );
  PokemonFormRow copyWithCompanion(PokemonFormsTableCompanion data) {
    return PokemonFormRow(
      id: data.id.present ? data.id.value : this.id,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      name: data.name.present ? data.name.value : this.name,
      formName: data.formName.present ? data.formName.value : this.formName,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isMega: data.isMega.present ? data.isMega.value : this.isMega,
      isBattleOnly: data.isBattleOnly.present
          ? data.isBattleOnly.value
          : this.isBattleOnly,
      formOrder: data.formOrder.present ? data.formOrder.value : this.formOrder,
      spriteUrl: data.spriteUrl.present ? data.spriteUrl.value : this.spriteUrl,
      spriteShinyUrl: data.spriteShinyUrl.present
          ? data.spriteShinyUrl.value
          : this.spriteShinyUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonFormRow(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('formName: $formName, ')
          ..write('isDefault: $isDefault, ')
          ..write('isMega: $isMega, ')
          ..write('isBattleOnly: $isBattleOnly, ')
          ..write('formOrder: $formOrder, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('spriteShinyUrl: $spriteShinyUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pokemonId,
    name,
    formName,
    isDefault,
    isMega,
    isBattleOnly,
    formOrder,
    spriteUrl,
    spriteShinyUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonFormRow &&
          other.id == this.id &&
          other.pokemonId == this.pokemonId &&
          other.name == this.name &&
          other.formName == this.formName &&
          other.isDefault == this.isDefault &&
          other.isMega == this.isMega &&
          other.isBattleOnly == this.isBattleOnly &&
          other.formOrder == this.formOrder &&
          other.spriteUrl == this.spriteUrl &&
          other.spriteShinyUrl == this.spriteShinyUrl);
}

class PokemonFormsTableCompanion extends UpdateCompanion<PokemonFormRow> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<String> name;
  final Value<String?> formName;
  final Value<bool> isDefault;
  final Value<bool> isMega;
  final Value<bool> isBattleOnly;
  final Value<int?> formOrder;
  final Value<String?> spriteUrl;
  final Value<String?> spriteShinyUrl;
  const PokemonFormsTableCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.name = const Value.absent(),
    this.formName = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isMega = const Value.absent(),
    this.isBattleOnly = const Value.absent(),
    this.formOrder = const Value.absent(),
    this.spriteUrl = const Value.absent(),
    this.spriteShinyUrl = const Value.absent(),
  });
  PokemonFormsTableCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required String name,
    this.formName = const Value.absent(),
    required bool isDefault,
    required bool isMega,
    required bool isBattleOnly,
    this.formOrder = const Value.absent(),
    this.spriteUrl = const Value.absent(),
    this.spriteShinyUrl = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       name = Value(name),
       isDefault = Value(isDefault),
       isMega = Value(isMega),
       isBattleOnly = Value(isBattleOnly);
  static Insertable<PokemonFormRow> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<String>? name,
    Expression<String>? formName,
    Expression<bool>? isDefault,
    Expression<bool>? isMega,
    Expression<bool>? isBattleOnly,
    Expression<int>? formOrder,
    Expression<String>? spriteUrl,
    Expression<String>? spriteShinyUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (name != null) 'name': name,
      if (formName != null) 'form_name': formName,
      if (isDefault != null) 'is_default': isDefault,
      if (isMega != null) 'is_mega': isMega,
      if (isBattleOnly != null) 'is_battle_only': isBattleOnly,
      if (formOrder != null) 'form_order': formOrder,
      if (spriteUrl != null) 'sprite_url': spriteUrl,
      if (spriteShinyUrl != null) 'sprite_shiny_url': spriteShinyUrl,
    });
  }

  PokemonFormsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? pokemonId,
    Value<String>? name,
    Value<String?>? formName,
    Value<bool>? isDefault,
    Value<bool>? isMega,
    Value<bool>? isBattleOnly,
    Value<int?>? formOrder,
    Value<String?>? spriteUrl,
    Value<String?>? spriteShinyUrl,
  }) {
    return PokemonFormsTableCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      name: name ?? this.name,
      formName: formName ?? this.formName,
      isDefault: isDefault ?? this.isDefault,
      isMega: isMega ?? this.isMega,
      isBattleOnly: isBattleOnly ?? this.isBattleOnly,
      formOrder: formOrder ?? this.formOrder,
      spriteUrl: spriteUrl ?? this.spriteUrl,
      spriteShinyUrl: spriteShinyUrl ?? this.spriteShinyUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (formName.present) {
      map['form_name'] = Variable<String>(formName.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isMega.present) {
      map['is_mega'] = Variable<bool>(isMega.value);
    }
    if (isBattleOnly.present) {
      map['is_battle_only'] = Variable<bool>(isBattleOnly.value);
    }
    if (formOrder.present) {
      map['form_order'] = Variable<int>(formOrder.value);
    }
    if (spriteUrl.present) {
      map['sprite_url'] = Variable<String>(spriteUrl.value);
    }
    if (spriteShinyUrl.present) {
      map['sprite_shiny_url'] = Variable<String>(spriteShinyUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonFormsTableCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('formName: $formName, ')
          ..write('isDefault: $isDefault, ')
          ..write('isMega: $isMega, ')
          ..write('isBattleOnly: $isBattleOnly, ')
          ..write('formOrder: $formOrder, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('spriteShinyUrl: $spriteShinyUrl')
          ..write(')'))
        .toString();
  }
}

class $PokemonFormTypesTableTable extends PokemonFormTypesTable
    with TableInfo<$PokemonFormTypesTableTable, PokemonFormTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonFormTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _formIdMeta = const VerificationMeta('formId');
  @override
  late final GeneratedColumn<int> formId = GeneratedColumn<int>(
    'form_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon_form (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [formId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_form_type';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonFormTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form_id')) {
      context.handle(
        _formIdMeta,
        formId.isAcceptableOrUnknown(data['form_id']!, _formIdMeta),
      );
    } else if (isInserting) {
      context.missing(_formIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {formId, slot};
  @override
  PokemonFormTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonFormTypeRow(
      formId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}form_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonFormTypesTableTable createAlias(String alias) {
    return $PokemonFormTypesTableTable(attachedDatabase, alias);
  }
}

class PokemonFormTypeRow extends DataClass
    implements Insertable<PokemonFormTypeRow> {
  final int formId;
  final int typeId;
  final int slot;
  const PokemonFormTypeRow({
    required this.formId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['form_id'] = Variable<int>(formId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonFormTypesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonFormTypesTableCompanion(
      formId: Value(formId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonFormTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonFormTypeRow(
      formId: serializer.fromJson<int>(json['formId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'formId': serializer.toJson<int>(formId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonFormTypeRow copyWith({int? formId, int? typeId, int? slot}) =>
      PokemonFormTypeRow(
        formId: formId ?? this.formId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonFormTypeRow copyWithCompanion(PokemonFormTypesTableCompanion data) {
    return PokemonFormTypeRow(
      formId: data.formId.present ? data.formId.value : this.formId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonFormTypeRow(')
          ..write('formId: $formId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(formId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonFormTypeRow &&
          other.formId == this.formId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonFormTypesTableCompanion
    extends UpdateCompanion<PokemonFormTypeRow> {
  final Value<int> formId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonFormTypesTableCompanion({
    this.formId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonFormTypesTableCompanion.insert({
    required int formId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : formId = Value(formId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonFormTypeRow> custom({
    Expression<int>? formId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (formId != null) 'form_id': formId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonFormTypesTableCompanion copyWith({
    Value<int>? formId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonFormTypesTableCompanion(
      formId: formId ?? this.formId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (formId.present) {
      map['form_id'] = Variable<int>(formId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonFormTypesTableCompanion(')
          ..write('formId: $formId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TypeEfficacyTableTable extends TypeEfficacyTable
    with TableInfo<$TypeEfficacyTableTable, TypeEfficacyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypeEfficacyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attackingTypeIdMeta = const VerificationMeta(
    'attackingTypeId',
  );
  @override
  late final GeneratedColumn<int> attackingTypeId = GeneratedColumn<int>(
    'attacking_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _defendingTypeIdMeta = const VerificationMeta(
    'defendingTypeId',
  );
  @override
  late final GeneratedColumn<int> defendingTypeId = GeneratedColumn<int>(
    'defending_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _damageFactorMeta = const VerificationMeta(
    'damageFactor',
  );
  @override
  late final GeneratedColumn<int> damageFactor = GeneratedColumn<int>(
    'damage_factor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    attackingTypeId,
    defendingTypeId,
    damageFactor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type_efficacy';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeEfficacyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attacking_type_id')) {
      context.handle(
        _attackingTypeIdMeta,
        attackingTypeId.isAcceptableOrUnknown(
          data['attacking_type_id']!,
          _attackingTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attackingTypeIdMeta);
    }
    if (data.containsKey('defending_type_id')) {
      context.handle(
        _defendingTypeIdMeta,
        defendingTypeId.isAcceptableOrUnknown(
          data['defending_type_id']!,
          _defendingTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defendingTypeIdMeta);
    }
    if (data.containsKey('damage_factor')) {
      context.handle(
        _damageFactorMeta,
        damageFactor.isAcceptableOrUnknown(
          data['damage_factor']!,
          _damageFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageFactorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attackingTypeId, defendingTypeId};
  @override
  TypeEfficacyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeEfficacyRow(
      attackingTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attacking_type_id'],
      )!,
      defendingTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defending_type_id'],
      )!,
      damageFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}damage_factor'],
      )!,
    );
  }

  @override
  $TypeEfficacyTableTable createAlias(String alias) {
    return $TypeEfficacyTableTable(attachedDatabase, alias);
  }
}

class TypeEfficacyRow extends DataClass implements Insertable<TypeEfficacyRow> {
  final int attackingTypeId;
  final int defendingTypeId;
  final int damageFactor;
  const TypeEfficacyRow({
    required this.attackingTypeId,
    required this.defendingTypeId,
    required this.damageFactor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attacking_type_id'] = Variable<int>(attackingTypeId);
    map['defending_type_id'] = Variable<int>(defendingTypeId);
    map['damage_factor'] = Variable<int>(damageFactor);
    return map;
  }

  TypeEfficacyTableCompanion toCompanion(bool nullToAbsent) {
    return TypeEfficacyTableCompanion(
      attackingTypeId: Value(attackingTypeId),
      defendingTypeId: Value(defendingTypeId),
      damageFactor: Value(damageFactor),
    );
  }

  factory TypeEfficacyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeEfficacyRow(
      attackingTypeId: serializer.fromJson<int>(json['attackingTypeId']),
      defendingTypeId: serializer.fromJson<int>(json['defendingTypeId']),
      damageFactor: serializer.fromJson<int>(json['damageFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attackingTypeId': serializer.toJson<int>(attackingTypeId),
      'defendingTypeId': serializer.toJson<int>(defendingTypeId),
      'damageFactor': serializer.toJson<int>(damageFactor),
    };
  }

  TypeEfficacyRow copyWith({
    int? attackingTypeId,
    int? defendingTypeId,
    int? damageFactor,
  }) => TypeEfficacyRow(
    attackingTypeId: attackingTypeId ?? this.attackingTypeId,
    defendingTypeId: defendingTypeId ?? this.defendingTypeId,
    damageFactor: damageFactor ?? this.damageFactor,
  );
  TypeEfficacyRow copyWithCompanion(TypeEfficacyTableCompanion data) {
    return TypeEfficacyRow(
      attackingTypeId: data.attackingTypeId.present
          ? data.attackingTypeId.value
          : this.attackingTypeId,
      defendingTypeId: data.defendingTypeId.present
          ? data.defendingTypeId.value
          : this.defendingTypeId,
      damageFactor: data.damageFactor.present
          ? data.damageFactor.value
          : this.damageFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyRow(')
          ..write('attackingTypeId: $attackingTypeId, ')
          ..write('defendingTypeId: $defendingTypeId, ')
          ..write('damageFactor: $damageFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(attackingTypeId, defendingTypeId, damageFactor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeEfficacyRow &&
          other.attackingTypeId == this.attackingTypeId &&
          other.defendingTypeId == this.defendingTypeId &&
          other.damageFactor == this.damageFactor);
}

class TypeEfficacyTableCompanion extends UpdateCompanion<TypeEfficacyRow> {
  final Value<int> attackingTypeId;
  final Value<int> defendingTypeId;
  final Value<int> damageFactor;
  final Value<int> rowid;
  const TypeEfficacyTableCompanion({
    this.attackingTypeId = const Value.absent(),
    this.defendingTypeId = const Value.absent(),
    this.damageFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypeEfficacyTableCompanion.insert({
    required int attackingTypeId,
    required int defendingTypeId,
    required int damageFactor,
    this.rowid = const Value.absent(),
  }) : attackingTypeId = Value(attackingTypeId),
       defendingTypeId = Value(defendingTypeId),
       damageFactor = Value(damageFactor);
  static Insertable<TypeEfficacyRow> custom({
    Expression<int>? attackingTypeId,
    Expression<int>? defendingTypeId,
    Expression<int>? damageFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attackingTypeId != null) 'attacking_type_id': attackingTypeId,
      if (defendingTypeId != null) 'defending_type_id': defendingTypeId,
      if (damageFactor != null) 'damage_factor': damageFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypeEfficacyTableCompanion copyWith({
    Value<int>? attackingTypeId,
    Value<int>? defendingTypeId,
    Value<int>? damageFactor,
    Value<int>? rowid,
  }) {
    return TypeEfficacyTableCompanion(
      attackingTypeId: attackingTypeId ?? this.attackingTypeId,
      defendingTypeId: defendingTypeId ?? this.defendingTypeId,
      damageFactor: damageFactor ?? this.damageFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attackingTypeId.present) {
      map['attacking_type_id'] = Variable<int>(attackingTypeId.value);
    }
    if (defendingTypeId.present) {
      map['defending_type_id'] = Variable<int>(defendingTypeId.value);
    }
    if (damageFactor.present) {
      map['damage_factor'] = Variable<int>(damageFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyTableCompanion(')
          ..write('attackingTypeId: $attackingTypeId, ')
          ..write('defendingTypeId: $defendingTypeId, ')
          ..write('damageFactor: $damageFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AbilitiesTableTable extends AbilitiesTable
    with TableInfo<$AbilitiesTableTable, AbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbilitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEnMeta = const VerificationMeta(
    'effectEn',
  );
  @override
  late final GeneratedColumn<String> effectEn = GeneratedColumn<String>(
    'effect_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEsMeta = const VerificationMeta(
    'effectEs',
  );
  @override
  late final GeneratedColumn<String> effectEs = GeneratedColumn<String>(
    'effect_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, nameEs, effectEn, effectEs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ability';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('effect_en')) {
      context.handle(
        _effectEnMeta,
        effectEn.isAcceptableOrUnknown(data['effect_en']!, _effectEnMeta),
      );
    }
    if (data.containsKey('effect_es')) {
      context.handle(
        _effectEsMeta,
        effectEs.isAcceptableOrUnknown(data['effect_es']!, _effectEsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbilityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      effectEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_en'],
      ),
      effectEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_es'],
      ),
    );
  }

  @override
  $AbilitiesTableTable createAlias(String alias) {
    return $AbilitiesTableTable(attachedDatabase, alias);
  }
}

class AbilityRow extends DataClass implements Insertable<AbilityRow> {
  final int id;
  final String name;
  final String? nameEs;
  final String? effectEn;
  final String? effectEs;
  const AbilityRow({
    required this.id,
    required this.name,
    this.nameEs,
    this.effectEn,
    this.effectEs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || effectEn != null) {
      map['effect_en'] = Variable<String>(effectEn);
    }
    if (!nullToAbsent || effectEs != null) {
      map['effect_es'] = Variable<String>(effectEs);
    }
    return map;
  }

  AbilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return AbilitiesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      effectEn: effectEn == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEn),
      effectEs: effectEs == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEs),
    );
  }

  factory AbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbilityRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      effectEn: serializer.fromJson<String?>(json['effectEn']),
      effectEs: serializer.fromJson<String?>(json['effectEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
      'effectEn': serializer.toJson<String?>(effectEn),
      'effectEs': serializer.toJson<String?>(effectEs),
    };
  }

  AbilityRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
    Value<String?> effectEn = const Value.absent(),
    Value<String?> effectEs = const Value.absent(),
  }) => AbilityRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    effectEn: effectEn.present ? effectEn.value : this.effectEn,
    effectEs: effectEs.present ? effectEs.value : this.effectEs,
  );
  AbilityRow copyWithCompanion(AbilitiesTableCompanion data) {
    return AbilityRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      effectEn: data.effectEn.present ? data.effectEn.value : this.effectEn,
      effectEs: data.effectEs.present ? data.effectEs.value : this.effectEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbilityRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('effectEn: $effectEn, ')
          ..write('effectEs: $effectEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs, effectEn, effectEs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbilityRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.effectEn == this.effectEn &&
          other.effectEs == this.effectEs);
}

class AbilitiesTableCompanion extends UpdateCompanion<AbilityRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  final Value<String?> effectEn;
  final Value<String?> effectEs;
  const AbilitiesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.effectEn = const Value.absent(),
    this.effectEs = const Value.absent(),
  });
  AbilitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
    this.effectEn = const Value.absent(),
    this.effectEs = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AbilityRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? effectEn,
    Expression<String>? effectEs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (effectEn != null) 'effect_en': effectEn,
      if (effectEs != null) 'effect_es': effectEs,
    });
  }

  AbilitiesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
    Value<String?>? effectEn,
    Value<String?>? effectEs,
  }) {
    return AbilitiesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      effectEn: effectEn ?? this.effectEn,
      effectEs: effectEs ?? this.effectEs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (effectEn.present) {
      map['effect_en'] = Variable<String>(effectEn.value);
    }
    if (effectEs.present) {
      map['effect_es'] = Variable<String>(effectEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbilitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('effectEn: $effectEn, ')
          ..write('effectEs: $effectEs')
          ..write(')'))
        .toString();
  }
}

class $PokemonAbilitiesTableTable extends PokemonAbilitiesTable
    with TableInfo<$PokemonAbilitiesTableTable, PokemonAbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonAbilitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _abilityIdMeta = const VerificationMeta(
    'abilityId',
  );
  @override
  late final GeneratedColumn<int> abilityId = GeneratedColumn<int>(
    'ability_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ability (id)',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, abilityId, slot, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_ability';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonAbilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('ability_id')) {
      context.handle(
        _abilityIdMeta,
        abilityId.isAcceptableOrUnknown(data['ability_id']!, _abilityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_abilityIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    } else if (isInserting) {
      context.missing(_isHiddenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  PokemonAbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonAbilityRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      abilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ability_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $PokemonAbilitiesTableTable createAlias(String alias) {
    return $PokemonAbilitiesTableTable(attachedDatabase, alias);
  }
}

class PokemonAbilityRow extends DataClass
    implements Insertable<PokemonAbilityRow> {
  final int pokemonId;
  final int abilityId;
  final int slot;
  final bool isHidden;
  const PokemonAbilityRow({
    required this.pokemonId,
    required this.abilityId,
    required this.slot,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['ability_id'] = Variable<int>(abilityId);
    map['slot'] = Variable<int>(slot);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  PokemonAbilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonAbilitiesTableCompanion(
      pokemonId: Value(pokemonId),
      abilityId: Value(abilityId),
      slot: Value(slot),
      isHidden: Value(isHidden),
    );
  }

  factory PokemonAbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonAbilityRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      abilityId: serializer.fromJson<int>(json['abilityId']),
      slot: serializer.fromJson<int>(json['slot']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'abilityId': serializer.toJson<int>(abilityId),
      'slot': serializer.toJson<int>(slot),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  PokemonAbilityRow copyWith({
    int? pokemonId,
    int? abilityId,
    int? slot,
    bool? isHidden,
  }) => PokemonAbilityRow(
    pokemonId: pokemonId ?? this.pokemonId,
    abilityId: abilityId ?? this.abilityId,
    slot: slot ?? this.slot,
    isHidden: isHidden ?? this.isHidden,
  );
  PokemonAbilityRow copyWithCompanion(PokemonAbilitiesTableCompanion data) {
    return PokemonAbilityRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      abilityId: data.abilityId.present ? data.abilityId.value : this.abilityId,
      slot: data.slot.present ? data.slot.value : this.slot,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilityRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('slot: $slot, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, abilityId, slot, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonAbilityRow &&
          other.pokemonId == this.pokemonId &&
          other.abilityId == this.abilityId &&
          other.slot == this.slot &&
          other.isHidden == this.isHidden);
}

class PokemonAbilitiesTableCompanion
    extends UpdateCompanion<PokemonAbilityRow> {
  final Value<int> pokemonId;
  final Value<int> abilityId;
  final Value<int> slot;
  final Value<bool> isHidden;
  final Value<int> rowid;
  const PokemonAbilitiesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.abilityId = const Value.absent(),
    this.slot = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonAbilitiesTableCompanion.insert({
    required int pokemonId,
    required int abilityId,
    required int slot,
    required bool isHidden,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       abilityId = Value(abilityId),
       slot = Value(slot),
       isHidden = Value(isHidden);
  static Insertable<PokemonAbilityRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? abilityId,
    Expression<int>? slot,
    Expression<bool>? isHidden,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (abilityId != null) 'ability_id': abilityId,
      if (slot != null) 'slot': slot,
      if (isHidden != null) 'is_hidden': isHidden,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonAbilitiesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? abilityId,
    Value<int>? slot,
    Value<bool>? isHidden,
    Value<int>? rowid,
  }) {
    return PokemonAbilitiesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      abilityId: abilityId ?? this.abilityId,
      slot: slot ?? this.slot,
      isHidden: isHidden ?? this.isHidden,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (abilityId.present) {
      map['ability_id'] = Variable<int>(abilityId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilitiesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('slot: $slot, ')
          ..write('isHidden: $isHidden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VersionGroupsTableTable extends VersionGroupsTable
    with TableInfo<$VersionGroupsTableTable, VersionGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersionGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES generation (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, generationId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'version_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<VersionGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VersionGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VersionGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      ),
    );
  }

  @override
  $VersionGroupsTableTable createAlias(String alias) {
    return $VersionGroupsTableTable(attachedDatabase, alias);
  }
}

class VersionGroupRow extends DataClass implements Insertable<VersionGroupRow> {
  final int id;
  final String name;
  final int? generationId;
  final int? sortOrder;
  const VersionGroupRow({
    required this.id,
    required this.name,
    this.generationId,
    this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || generationId != null) {
      map['generation_id'] = Variable<int>(generationId);
    }
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<int>(sortOrder);
    }
    return map;
  }

  VersionGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return VersionGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      generationId: generationId == null && nullToAbsent
          ? const Value.absent()
          : Value(generationId),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
    );
  }

  factory VersionGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VersionGroupRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      generationId: serializer.fromJson<int?>(json['generationId']),
      sortOrder: serializer.fromJson<int?>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'generationId': serializer.toJson<int?>(generationId),
      'sortOrder': serializer.toJson<int?>(sortOrder),
    };
  }

  VersionGroupRow copyWith({
    int? id,
    String? name,
    Value<int?> generationId = const Value.absent(),
    Value<int?> sortOrder = const Value.absent(),
  }) => VersionGroupRow(
    id: id ?? this.id,
    name: name ?? this.name,
    generationId: generationId.present ? generationId.value : this.generationId,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
  );
  VersionGroupRow copyWithCompanion(VersionGroupsTableCompanion data) {
    return VersionGroupRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, generationId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VersionGroupRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.generationId == this.generationId &&
          other.sortOrder == this.sortOrder);
}

class VersionGroupsTableCompanion extends UpdateCompanion<VersionGroupRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> generationId;
  final Value<int?> sortOrder;
  const VersionGroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.generationId = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  VersionGroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.generationId = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name);
  static Insertable<VersionGroupRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? generationId,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (generationId != null) 'generation_id': generationId,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  VersionGroupsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? generationId,
    Value<int?>? sortOrder,
  }) {
    return VersionGroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      generationId: generationId ?? this.generationId,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersionGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('generationId: $generationId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $MovesTableTable extends MovesTable
    with TableInfo<$MovesTableTable, MoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES type (id)',
    ),
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<int> power = GeneratedColumn<int>(
    'power',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<int> accuracy = GeneratedColumn<int>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ppMeta = const VerificationMeta('pp');
  @override
  late final GeneratedColumn<int> pp = GeneratedColumn<int>(
    'pp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damageClassMeta = const VerificationMeta(
    'damageClass',
  );
  @override
  late final GeneratedColumn<String> damageClass = GeneratedColumn<String>(
    'damage_class',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameEs,
    typeId,
    power,
    accuracy,
    pp,
    damageClass,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'move';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoveRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('pp')) {
      context.handle(_ppMeta, pp.isAcceptableOrUnknown(data['pp']!, _ppMeta));
    }
    if (data.containsKey('damage_class')) {
      context.handle(
        _damageClassMeta,
        damageClass.isAcceptableOrUnknown(
          data['damage_class']!,
          _damageClassMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoveRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      ),
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accuracy'],
      ),
      pp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pp'],
      ),
      damageClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_class'],
      ),
    );
  }

  @override
  $MovesTableTable createAlias(String alias) {
    return $MovesTableTable(attachedDatabase, alias);
  }
}

class MoveRow extends DataClass implements Insertable<MoveRow> {
  final int id;
  final String name;
  final String? nameEs;
  final int? typeId;
  final int? power;
  final int? accuracy;
  final int? pp;
  final String? damageClass;
  const MoveRow({
    required this.id,
    required this.name,
    this.nameEs,
    this.typeId,
    this.power,
    this.accuracy,
    this.pp,
    this.damageClass,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || typeId != null) {
      map['type_id'] = Variable<int>(typeId);
    }
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<int>(power);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<int>(accuracy);
    }
    if (!nullToAbsent || pp != null) {
      map['pp'] = Variable<int>(pp);
    }
    if (!nullToAbsent || damageClass != null) {
      map['damage_class'] = Variable<String>(damageClass);
    }
    return map;
  }

  MovesTableCompanion toCompanion(bool nullToAbsent) {
    return MovesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      typeId: typeId == null && nullToAbsent
          ? const Value.absent()
          : Value(typeId),
      power: power == null && nullToAbsent
          ? const Value.absent()
          : Value(power),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      pp: pp == null && nullToAbsent ? const Value.absent() : Value(pp),
      damageClass: damageClass == null && nullToAbsent
          ? const Value.absent()
          : Value(damageClass),
    );
  }

  factory MoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoveRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      typeId: serializer.fromJson<int?>(json['typeId']),
      power: serializer.fromJson<int?>(json['power']),
      accuracy: serializer.fromJson<int?>(json['accuracy']),
      pp: serializer.fromJson<int?>(json['pp']),
      damageClass: serializer.fromJson<String?>(json['damageClass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
      'typeId': serializer.toJson<int?>(typeId),
      'power': serializer.toJson<int?>(power),
      'accuracy': serializer.toJson<int?>(accuracy),
      'pp': serializer.toJson<int?>(pp),
      'damageClass': serializer.toJson<String?>(damageClass),
    };
  }

  MoveRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
    Value<int?> typeId = const Value.absent(),
    Value<int?> power = const Value.absent(),
    Value<int?> accuracy = const Value.absent(),
    Value<int?> pp = const Value.absent(),
    Value<String?> damageClass = const Value.absent(),
  }) => MoveRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    typeId: typeId.present ? typeId.value : this.typeId,
    power: power.present ? power.value : this.power,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    pp: pp.present ? pp.value : this.pp,
    damageClass: damageClass.present ? damageClass.value : this.damageClass,
  );
  MoveRow copyWithCompanion(MovesTableCompanion data) {
    return MoveRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      power: data.power.present ? data.power.value : this.power,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      pp: data.pp.present ? data.pp.value : this.pp,
      damageClass: data.damageClass.present
          ? data.damageClass.value
          : this.damageClass,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoveRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('typeId: $typeId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('damageClass: $damageClass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, nameEs, typeId, power, accuracy, pp, damageClass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoveRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.typeId == this.typeId &&
          other.power == this.power &&
          other.accuracy == this.accuracy &&
          other.pp == this.pp &&
          other.damageClass == this.damageClass);
}

class MovesTableCompanion extends UpdateCompanion<MoveRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  final Value<int?> typeId;
  final Value<int?> power;
  final Value<int?> accuracy;
  final Value<int?> pp;
  final Value<String?> damageClass;
  const MovesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.typeId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.damageClass = const Value.absent(),
  });
  MovesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
    this.typeId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.damageClass = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MoveRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<int>? typeId,
    Expression<int>? power,
    Expression<int>? accuracy,
    Expression<int>? pp,
    Expression<String>? damageClass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (typeId != null) 'type_id': typeId,
      if (power != null) 'power': power,
      if (accuracy != null) 'accuracy': accuracy,
      if (pp != null) 'pp': pp,
      if (damageClass != null) 'damage_class': damageClass,
    });
  }

  MovesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
    Value<int?>? typeId,
    Value<int?>? power,
    Value<int?>? accuracy,
    Value<int?>? pp,
    Value<String?>? damageClass,
  }) {
    return MovesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      typeId: typeId ?? this.typeId,
      power: power ?? this.power,
      accuracy: accuracy ?? this.accuracy,
      pp: pp ?? this.pp,
      damageClass: damageClass ?? this.damageClass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (power.present) {
      map['power'] = Variable<int>(power.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<int>(accuracy.value);
    }
    if (pp.present) {
      map['pp'] = Variable<int>(pp.value);
    }
    if (damageClass.present) {
      map['damage_class'] = Variable<String>(damageClass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('typeId: $typeId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('damageClass: $damageClass')
          ..write(')'))
        .toString();
  }
}

class $PokemonMovesTableTable extends PokemonMovesTable
    with TableInfo<$PokemonMovesTableTable, PokemonMoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonMovesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _versionGroupIdMeta = const VerificationMeta(
    'versionGroupId',
  );
  @override
  late final GeneratedColumn<int> versionGroupId = GeneratedColumn<int>(
    'version_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES version_group (id)',
    ),
  );
  static const VerificationMeta _learnMethodMeta = const VerificationMeta(
    'learnMethod',
  );
  @override
  late final GeneratedColumn<String> learnMethod = GeneratedColumn<String>(
    'learn_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moveIdMeta = const VerificationMeta('moveId');
  @override
  late final GeneratedColumn<int> moveId = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES move (id)',
    ),
  );
  static const VerificationMeta _levelLearnedMeta = const VerificationMeta(
    'levelLearned',
  );
  @override
  late final GeneratedColumn<int> levelLearned = GeneratedColumn<int>(
    'level_learned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pokemonId,
    versionGroupId,
    learnMethod,
    moveId,
    levelLearned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_move';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonMoveRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('version_group_id')) {
      context.handle(
        _versionGroupIdMeta,
        versionGroupId.isAcceptableOrUnknown(
          data['version_group_id']!,
          _versionGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionGroupIdMeta);
    }
    if (data.containsKey('learn_method')) {
      context.handle(
        _learnMethodMeta,
        learnMethod.isAcceptableOrUnknown(
          data['learn_method']!,
          _learnMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_learnMethodMeta);
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _moveIdMeta,
        moveId.isAcceptableOrUnknown(data['move_id']!, _moveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moveIdMeta);
    }
    if (data.containsKey('level_learned')) {
      context.handle(
        _levelLearnedMeta,
        levelLearned.isAcceptableOrUnknown(
          data['level_learned']!,
          _levelLearnedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_levelLearnedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    pokemonId,
    versionGroupId,
    learnMethod,
    moveId,
    levelLearned,
  };
  @override
  PokemonMoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonMoveRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      versionGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_group_id'],
      )!,
      learnMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learn_method'],
      )!,
      moveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}move_id'],
      )!,
      levelLearned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level_learned'],
      )!,
    );
  }

  @override
  $PokemonMovesTableTable createAlias(String alias) {
    return $PokemonMovesTableTable(attachedDatabase, alias);
  }
}

class PokemonMoveRow extends DataClass implements Insertable<PokemonMoveRow> {
  final int pokemonId;
  final int versionGroupId;
  final String learnMethod;
  final int moveId;
  final int levelLearned;
  const PokemonMoveRow({
    required this.pokemonId,
    required this.versionGroupId,
    required this.learnMethod,
    required this.moveId,
    required this.levelLearned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['version_group_id'] = Variable<int>(versionGroupId);
    map['learn_method'] = Variable<String>(learnMethod);
    map['move_id'] = Variable<int>(moveId);
    map['level_learned'] = Variable<int>(levelLearned);
    return map;
  }

  PokemonMovesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonMovesTableCompanion(
      pokemonId: Value(pokemonId),
      versionGroupId: Value(versionGroupId),
      learnMethod: Value(learnMethod),
      moveId: Value(moveId),
      levelLearned: Value(levelLearned),
    );
  }

  factory PokemonMoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonMoveRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      versionGroupId: serializer.fromJson<int>(json['versionGroupId']),
      learnMethod: serializer.fromJson<String>(json['learnMethod']),
      moveId: serializer.fromJson<int>(json['moveId']),
      levelLearned: serializer.fromJson<int>(json['levelLearned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'versionGroupId': serializer.toJson<int>(versionGroupId),
      'learnMethod': serializer.toJson<String>(learnMethod),
      'moveId': serializer.toJson<int>(moveId),
      'levelLearned': serializer.toJson<int>(levelLearned),
    };
  }

  PokemonMoveRow copyWith({
    int? pokemonId,
    int? versionGroupId,
    String? learnMethod,
    int? moveId,
    int? levelLearned,
  }) => PokemonMoveRow(
    pokemonId: pokemonId ?? this.pokemonId,
    versionGroupId: versionGroupId ?? this.versionGroupId,
    learnMethod: learnMethod ?? this.learnMethod,
    moveId: moveId ?? this.moveId,
    levelLearned: levelLearned ?? this.levelLearned,
  );
  PokemonMoveRow copyWithCompanion(PokemonMovesTableCompanion data) {
    return PokemonMoveRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      versionGroupId: data.versionGroupId.present
          ? data.versionGroupId.value
          : this.versionGroupId,
      learnMethod: data.learnMethod.present
          ? data.learnMethod.value
          : this.learnMethod,
      moveId: data.moveId.present ? data.moveId.value : this.moveId,
      levelLearned: data.levelLearned.present
          ? data.levelLearned.value
          : this.levelLearned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMoveRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('learnMethod: $learnMethod, ')
          ..write('moveId: $moveId, ')
          ..write('levelLearned: $levelLearned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(pokemonId, versionGroupId, learnMethod, moveId, levelLearned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonMoveRow &&
          other.pokemonId == this.pokemonId &&
          other.versionGroupId == this.versionGroupId &&
          other.learnMethod == this.learnMethod &&
          other.moveId == this.moveId &&
          other.levelLearned == this.levelLearned);
}

class PokemonMovesTableCompanion extends UpdateCompanion<PokemonMoveRow> {
  final Value<int> pokemonId;
  final Value<int> versionGroupId;
  final Value<String> learnMethod;
  final Value<int> moveId;
  final Value<int> levelLearned;
  final Value<int> rowid;
  const PokemonMovesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.versionGroupId = const Value.absent(),
    this.learnMethod = const Value.absent(),
    this.moveId = const Value.absent(),
    this.levelLearned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonMovesTableCompanion.insert({
    required int pokemonId,
    required int versionGroupId,
    required String learnMethod,
    required int moveId,
    required int levelLearned,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       versionGroupId = Value(versionGroupId),
       learnMethod = Value(learnMethod),
       moveId = Value(moveId),
       levelLearned = Value(levelLearned);
  static Insertable<PokemonMoveRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? versionGroupId,
    Expression<String>? learnMethod,
    Expression<int>? moveId,
    Expression<int>? levelLearned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (versionGroupId != null) 'version_group_id': versionGroupId,
      if (learnMethod != null) 'learn_method': learnMethod,
      if (moveId != null) 'move_id': moveId,
      if (levelLearned != null) 'level_learned': levelLearned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonMovesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? versionGroupId,
    Value<String>? learnMethod,
    Value<int>? moveId,
    Value<int>? levelLearned,
    Value<int>? rowid,
  }) {
    return PokemonMovesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      versionGroupId: versionGroupId ?? this.versionGroupId,
      learnMethod: learnMethod ?? this.learnMethod,
      moveId: moveId ?? this.moveId,
      levelLearned: levelLearned ?? this.levelLearned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (versionGroupId.present) {
      map['version_group_id'] = Variable<int>(versionGroupId.value);
    }
    if (learnMethod.present) {
      map['learn_method'] = Variable<String>(learnMethod.value);
    }
    if (moveId.present) {
      map['move_id'] = Variable<int>(moveId.value);
    }
    if (levelLearned.present) {
      map['level_learned'] = Variable<int>(levelLearned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMovesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('versionGroupId: $versionGroupId, ')
          ..write('learnMethod: $learnMethod, ')
          ..write('moveId: $moveId, ')
          ..write('levelLearned: $levelLearned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionsTableTable extends EvolutionsTable
    with TableInfo<$EvolutionsTableTable, EvolutionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromSpeciesIdMeta = const VerificationMeta(
    'fromSpeciesId',
  );
  @override
  late final GeneratedColumn<int> fromSpeciesId = GeneratedColumn<int>(
    'from_species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _toSpeciesIdMeta = const VerificationMeta(
    'toSpeciesId',
  );
  @override
  late final GeneratedColumn<int> toSpeciesId = GeneratedColumn<int>(
    'to_species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _triggerNameMeta = const VerificationMeta(
    'triggerName',
  );
  @override
  late final GeneratedColumn<String> triggerName = GeneratedColumn<String>(
    'trigger_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLevelMeta = const VerificationMeta(
    'minLevel',
  );
  @override
  late final GeneratedColumn<int> minLevel = GeneratedColumn<int>(
    'min_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
    'item',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minHappinessMeta = const VerificationMeta(
    'minHappiness',
  );
  @override
  late final GeneratedColumn<int> minHappiness = GeneratedColumn<int>(
    'min_happiness',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromSpeciesId,
    toSpeciesId,
    triggerName,
    minLevel,
    item,
    minHappiness,
    timeOfDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolution';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_species_id')) {
      context.handle(
        _fromSpeciesIdMeta,
        fromSpeciesId.isAcceptableOrUnknown(
          data['from_species_id']!,
          _fromSpeciesIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromSpeciesIdMeta);
    }
    if (data.containsKey('to_species_id')) {
      context.handle(
        _toSpeciesIdMeta,
        toSpeciesId.isAcceptableOrUnknown(
          data['to_species_id']!,
          _toSpeciesIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toSpeciesIdMeta);
    }
    if (data.containsKey('trigger_name')) {
      context.handle(
        _triggerNameMeta,
        triggerName.isAcceptableOrUnknown(
          data['trigger_name']!,
          _triggerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triggerNameMeta);
    }
    if (data.containsKey('min_level')) {
      context.handle(
        _minLevelMeta,
        minLevel.isAcceptableOrUnknown(data['min_level']!, _minLevelMeta),
      );
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('min_happiness')) {
      context.handle(
        _minHappinessMeta,
        minHappiness.isAcceptableOrUnknown(
          data['min_happiness']!,
          _minHappinessMeta,
        ),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvolutionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromSpeciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_species_id'],
      )!,
      toSpeciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_species_id'],
      )!,
      triggerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_name'],
      )!,
      minLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_level'],
      ),
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item'],
      ),
      minHappiness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_happiness'],
      ),
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      ),
    );
  }

  @override
  $EvolutionsTableTable createAlias(String alias) {
    return $EvolutionsTableTable(attachedDatabase, alias);
  }
}

class EvolutionRow extends DataClass implements Insertable<EvolutionRow> {
  final int id;
  final int fromSpeciesId;
  final int toSpeciesId;
  final String triggerName;
  final int? minLevel;
  final String? item;
  final int? minHappiness;
  final String? timeOfDay;
  const EvolutionRow({
    required this.id,
    required this.fromSpeciesId,
    required this.toSpeciesId,
    required this.triggerName,
    this.minLevel,
    this.item,
    this.minHappiness,
    this.timeOfDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_species_id'] = Variable<int>(fromSpeciesId);
    map['to_species_id'] = Variable<int>(toSpeciesId);
    map['trigger_name'] = Variable<String>(triggerName);
    if (!nullToAbsent || minLevel != null) {
      map['min_level'] = Variable<int>(minLevel);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || minHappiness != null) {
      map['min_happiness'] = Variable<int>(minHappiness);
    }
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<String>(timeOfDay);
    }
    return map;
  }

  EvolutionsTableCompanion toCompanion(bool nullToAbsent) {
    return EvolutionsTableCompanion(
      id: Value(id),
      fromSpeciesId: Value(fromSpeciesId),
      toSpeciesId: Value(toSpeciesId),
      triggerName: Value(triggerName),
      minLevel: minLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(minLevel),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      minHappiness: minHappiness == null && nullToAbsent
          ? const Value.absent()
          : Value(minHappiness),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
    );
  }

  factory EvolutionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionRow(
      id: serializer.fromJson<int>(json['id']),
      fromSpeciesId: serializer.fromJson<int>(json['fromSpeciesId']),
      toSpeciesId: serializer.fromJson<int>(json['toSpeciesId']),
      triggerName: serializer.fromJson<String>(json['triggerName']),
      minLevel: serializer.fromJson<int?>(json['minLevel']),
      item: serializer.fromJson<String?>(json['item']),
      minHappiness: serializer.fromJson<int?>(json['minHappiness']),
      timeOfDay: serializer.fromJson<String?>(json['timeOfDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromSpeciesId': serializer.toJson<int>(fromSpeciesId),
      'toSpeciesId': serializer.toJson<int>(toSpeciesId),
      'triggerName': serializer.toJson<String>(triggerName),
      'minLevel': serializer.toJson<int?>(minLevel),
      'item': serializer.toJson<String?>(item),
      'minHappiness': serializer.toJson<int?>(minHappiness),
      'timeOfDay': serializer.toJson<String?>(timeOfDay),
    };
  }

  EvolutionRow copyWith({
    int? id,
    int? fromSpeciesId,
    int? toSpeciesId,
    String? triggerName,
    Value<int?> minLevel = const Value.absent(),
    Value<String?> item = const Value.absent(),
    Value<int?> minHappiness = const Value.absent(),
    Value<String?> timeOfDay = const Value.absent(),
  }) => EvolutionRow(
    id: id ?? this.id,
    fromSpeciesId: fromSpeciesId ?? this.fromSpeciesId,
    toSpeciesId: toSpeciesId ?? this.toSpeciesId,
    triggerName: triggerName ?? this.triggerName,
    minLevel: minLevel.present ? minLevel.value : this.minLevel,
    item: item.present ? item.value : this.item,
    minHappiness: minHappiness.present ? minHappiness.value : this.minHappiness,
    timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
  );
  EvolutionRow copyWithCompanion(EvolutionsTableCompanion data) {
    return EvolutionRow(
      id: data.id.present ? data.id.value : this.id,
      fromSpeciesId: data.fromSpeciesId.present
          ? data.fromSpeciesId.value
          : this.fromSpeciesId,
      toSpeciesId: data.toSpeciesId.present
          ? data.toSpeciesId.value
          : this.toSpeciesId,
      triggerName: data.triggerName.present
          ? data.triggerName.value
          : this.triggerName,
      minLevel: data.minLevel.present ? data.minLevel.value : this.minLevel,
      item: data.item.present ? data.item.value : this.item,
      minHappiness: data.minHappiness.present
          ? data.minHappiness.value
          : this.minHappiness,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionRow(')
          ..write('id: $id, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('toSpeciesId: $toSpeciesId, ')
          ..write('triggerName: $triggerName, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromSpeciesId,
    toSpeciesId,
    triggerName,
    minLevel,
    item,
    minHappiness,
    timeOfDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionRow &&
          other.id == this.id &&
          other.fromSpeciesId == this.fromSpeciesId &&
          other.toSpeciesId == this.toSpeciesId &&
          other.triggerName == this.triggerName &&
          other.minLevel == this.minLevel &&
          other.item == this.item &&
          other.minHappiness == this.minHappiness &&
          other.timeOfDay == this.timeOfDay);
}

class EvolutionsTableCompanion extends UpdateCompanion<EvolutionRow> {
  final Value<int> id;
  final Value<int> fromSpeciesId;
  final Value<int> toSpeciesId;
  final Value<String> triggerName;
  final Value<int?> minLevel;
  final Value<String?> item;
  final Value<int?> minHappiness;
  final Value<String?> timeOfDay;
  const EvolutionsTableCompanion({
    this.id = const Value.absent(),
    this.fromSpeciesId = const Value.absent(),
    this.toSpeciesId = const Value.absent(),
    this.triggerName = const Value.absent(),
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
  });
  EvolutionsTableCompanion.insert({
    this.id = const Value.absent(),
    required int fromSpeciesId,
    required int toSpeciesId,
    required String triggerName,
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
  }) : fromSpeciesId = Value(fromSpeciesId),
       toSpeciesId = Value(toSpeciesId),
       triggerName = Value(triggerName);
  static Insertable<EvolutionRow> custom({
    Expression<int>? id,
    Expression<int>? fromSpeciesId,
    Expression<int>? toSpeciesId,
    Expression<String>? triggerName,
    Expression<int>? minLevel,
    Expression<String>? item,
    Expression<int>? minHappiness,
    Expression<String>? timeOfDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromSpeciesId != null) 'from_species_id': fromSpeciesId,
      if (toSpeciesId != null) 'to_species_id': toSpeciesId,
      if (triggerName != null) 'trigger_name': triggerName,
      if (minLevel != null) 'min_level': minLevel,
      if (item != null) 'item': item,
      if (minHappiness != null) 'min_happiness': minHappiness,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
    });
  }

  EvolutionsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? fromSpeciesId,
    Value<int>? toSpeciesId,
    Value<String>? triggerName,
    Value<int?>? minLevel,
    Value<String?>? item,
    Value<int?>? minHappiness,
    Value<String?>? timeOfDay,
  }) {
    return EvolutionsTableCompanion(
      id: id ?? this.id,
      fromSpeciesId: fromSpeciesId ?? this.fromSpeciesId,
      toSpeciesId: toSpeciesId ?? this.toSpeciesId,
      triggerName: triggerName ?? this.triggerName,
      minLevel: minLevel ?? this.minLevel,
      item: item ?? this.item,
      minHappiness: minHappiness ?? this.minHappiness,
      timeOfDay: timeOfDay ?? this.timeOfDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromSpeciesId.present) {
      map['from_species_id'] = Variable<int>(fromSpeciesId.value);
    }
    if (toSpeciesId.present) {
      map['to_species_id'] = Variable<int>(toSpeciesId.value);
    }
    if (triggerName.present) {
      map['trigger_name'] = Variable<String>(triggerName.value);
    }
    if (minLevel.present) {
      map['min_level'] = Variable<int>(minLevel.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (minHappiness.present) {
      map['min_happiness'] = Variable<int>(minHappiness.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsTableCompanion(')
          ..write('id: $id, ')
          ..write('fromSpeciesId: $fromSpeciesId, ')
          ..write('toSpeciesId: $toSpeciesId, ')
          ..write('triggerName: $triggerName, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay')
          ..write(')'))
        .toString();
  }
}

class $EggGroupsTableTable extends EggGroupsTable
    with TableInfo<$EggGroupsTableTable, EggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EggGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, nameEs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'egg_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<EggGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EggGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
    );
  }

  @override
  $EggGroupsTableTable createAlias(String alias) {
    return $EggGroupsTableTable(attachedDatabase, alias);
  }
}

class EggGroupRow extends DataClass implements Insertable<EggGroupRow> {
  final int id;
  final String name;
  final String? nameEs;
  const EggGroupRow({required this.id, required this.name, this.nameEs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    return map;
  }

  EggGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return EggGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
    );
  }

  factory EggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EggGroupRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
    };
  }

  EggGroupRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
  }) => EggGroupRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
  );
  EggGroupRow copyWithCompanion(EggGroupsTableCompanion data) {
    return EggGroupRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EggGroupRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EggGroupRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs);
}

class EggGroupsTableCompanion extends UpdateCompanion<EggGroupRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  const EggGroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
  });
  EggGroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
  }) : name = Value(name);
  static Insertable<EggGroupRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
    });
  }

  EggGroupsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
  }) {
    return EggGroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EggGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs')
          ..write(')'))
        .toString();
  }
}

class $SpeciesEggGroupsTableTable extends SpeciesEggGroupsTable
    with TableInfo<$SpeciesEggGroupsTableTable, SpeciesEggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesEggGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eggGroupIdMeta = const VerificationMeta(
    'eggGroupId',
  );
  @override
  late final GeneratedColumn<int> eggGroupId = GeneratedColumn<int>(
    'egg_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES egg_group (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [speciesId, eggGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species_egg_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesEggGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('egg_group_id')) {
      context.handle(
        _eggGroupIdMeta,
        eggGroupId.isAcceptableOrUnknown(
          data['egg_group_id']!,
          _eggGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eggGroupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {speciesId, eggGroupId};
  @override
  SpeciesEggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesEggGroupRow(
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      eggGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}egg_group_id'],
      )!,
    );
  }

  @override
  $SpeciesEggGroupsTableTable createAlias(String alias) {
    return $SpeciesEggGroupsTableTable(attachedDatabase, alias);
  }
}

class SpeciesEggGroupRow extends DataClass
    implements Insertable<SpeciesEggGroupRow> {
  final int speciesId;
  final int eggGroupId;
  const SpeciesEggGroupRow({required this.speciesId, required this.eggGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['species_id'] = Variable<int>(speciesId);
    map['egg_group_id'] = Variable<int>(eggGroupId);
    return map;
  }

  SpeciesEggGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return SpeciesEggGroupsTableCompanion(
      speciesId: Value(speciesId),
      eggGroupId: Value(eggGroupId),
    );
  }

  factory SpeciesEggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesEggGroupRow(
      speciesId: serializer.fromJson<int>(json['speciesId']),
      eggGroupId: serializer.fromJson<int>(json['eggGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'speciesId': serializer.toJson<int>(speciesId),
      'eggGroupId': serializer.toJson<int>(eggGroupId),
    };
  }

  SpeciesEggGroupRow copyWith({int? speciesId, int? eggGroupId}) =>
      SpeciesEggGroupRow(
        speciesId: speciesId ?? this.speciesId,
        eggGroupId: eggGroupId ?? this.eggGroupId,
      );
  SpeciesEggGroupRow copyWithCompanion(SpeciesEggGroupsTableCompanion data) {
    return SpeciesEggGroupRow(
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      eggGroupId: data.eggGroupId.present
          ? data.eggGroupId.value
          : this.eggGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesEggGroupRow(')
          ..write('speciesId: $speciesId, ')
          ..write('eggGroupId: $eggGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(speciesId, eggGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesEggGroupRow &&
          other.speciesId == this.speciesId &&
          other.eggGroupId == this.eggGroupId);
}

class SpeciesEggGroupsTableCompanion
    extends UpdateCompanion<SpeciesEggGroupRow> {
  final Value<int> speciesId;
  final Value<int> eggGroupId;
  final Value<int> rowid;
  const SpeciesEggGroupsTableCompanion({
    this.speciesId = const Value.absent(),
    this.eggGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesEggGroupsTableCompanion.insert({
    required int speciesId,
    required int eggGroupId,
    this.rowid = const Value.absent(),
  }) : speciesId = Value(speciesId),
       eggGroupId = Value(eggGroupId);
  static Insertable<SpeciesEggGroupRow> custom({
    Expression<int>? speciesId,
    Expression<int>? eggGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (speciesId != null) 'species_id': speciesId,
      if (eggGroupId != null) 'egg_group_id': eggGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesEggGroupsTableCompanion copyWith({
    Value<int>? speciesId,
    Value<int>? eggGroupId,
    Value<int>? rowid,
  }) {
    return SpeciesEggGroupsTableCompanion(
      speciesId: speciesId ?? this.speciesId,
      eggGroupId: eggGroupId ?? this.eggGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (eggGroupId.present) {
      map['egg_group_id'] = Variable<int>(eggGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesEggGroupsTableCompanion(')
          ..write('speciesId: $speciesId, ')
          ..write('eggGroupId: $eggGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final int pokemonId;
  final DateTime createdAt;
  const FavoriteRow({required this.pokemonId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesTableCompanion(
      pokemonId: Value(pokemonId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteRow copyWith({int? pokemonId, DateTime? createdAt}) => FavoriteRow(
    pokemonId: pokemonId ?? this.pokemonId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteRow copyWithCompanion(FavoritesTableCompanion data) {
    return FavoriteRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.pokemonId == this.pokemonId &&
          other.createdAt == this.createdAt);
}

class FavoritesTableCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<int> pokemonId;
  final Value<DateTime> createdAt;
  const FavoritesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesTableCompanion.insert({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<FavoriteRow> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaResultsTableTable extends TriviaResultsTable
    with TableInfo<$TriviaResultsTableTable, TriviaResultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaResultsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    score,
    correctAnswers,
    totalQuestions,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_result';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaResultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaResultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaResultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $TriviaResultsTableTable createAlias(String alias) {
    return $TriviaResultsTableTable(attachedDatabase, alias);
  }
}

class TriviaResultRow extends DataClass implements Insertable<TriviaResultRow> {
  final int id;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime playedAt;
  const TriviaResultRow({
    required this.id,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  TriviaResultsTableCompanion toCompanion(bool nullToAbsent) {
    return TriviaResultsTableCompanion(
      id: Value(id),
      score: Value(score),
      correctAnswers: Value(correctAnswers),
      totalQuestions: Value(totalQuestions),
      playedAt: Value(playedAt),
    );
  }

  factory TriviaResultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaResultRow(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  TriviaResultRow copyWith({
    int? id,
    int? score,
    int? correctAnswers,
    int? totalQuestions,
    DateTime? playedAt,
  }) => TriviaResultRow(
    id: id ?? this.id,
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    playedAt: playedAt ?? this.playedAt,
  );
  TriviaResultRow copyWithCompanion(TriviaResultsTableCompanion data) {
    return TriviaResultRow(
      id: data.id.present ? data.id.value : this.id,
      score: data.score.present ? data.score.value : this.score,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultRow(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, score, correctAnswers, totalQuestions, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaResultRow &&
          other.id == this.id &&
          other.score == this.score &&
          other.correctAnswers == this.correctAnswers &&
          other.totalQuestions == this.totalQuestions &&
          other.playedAt == this.playedAt);
}

class TriviaResultsTableCompanion extends UpdateCompanion<TriviaResultRow> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> correctAnswers;
  final Value<int> totalQuestions;
  final Value<DateTime> playedAt;
  const TriviaResultsTableCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  TriviaResultsTableCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    required DateTime playedAt,
  }) : score = Value(score),
       correctAnswers = Value(correctAnswers),
       totalQuestions = Value(totalQuestions),
       playedAt = Value(playedAt);
  static Insertable<TriviaResultRow> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? correctAnswers,
    Expression<int>? totalQuestions,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  TriviaResultsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? score,
    Value<int>? correctAnswers,
    Value<int>? totalQuestions,
    Value<DateTime>? playedAt,
  }) {
    return TriviaResultsTableCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultsTableCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaAnswersTableTable extends TriviaAnswersTable
    with TableInfo<$TriviaAnswersTableTable, TriviaAnswerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaAnswersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _triviaResultIdMeta = const VerificationMeta(
    'triviaResultId',
  );
  @override
  late final GeneratedColumn<int> triviaResultId = GeneratedColumn<int>(
    'trivia_result_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trivia_result (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  @override
  late final GeneratedColumn<bool> correct = GeneratedColumn<bool>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("correct" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    triviaResultId,
    pokemonId,
    correct,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_answer';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaAnswerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trivia_result_id')) {
      context.handle(
        _triviaResultIdMeta,
        triviaResultId.isAcceptableOrUnknown(
          data['trivia_result_id']!,
          _triviaResultIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triviaResultIdMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaAnswerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaAnswerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      triviaResultId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trivia_result_id'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      correct: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}correct'],
      )!,
    );
  }

  @override
  $TriviaAnswersTableTable createAlias(String alias) {
    return $TriviaAnswersTableTable(attachedDatabase, alias);
  }
}

class TriviaAnswerRow extends DataClass implements Insertable<TriviaAnswerRow> {
  final int id;
  final int triviaResultId;
  final int pokemonId;
  final bool correct;
  const TriviaAnswerRow({
    required this.id,
    required this.triviaResultId,
    required this.pokemonId,
    required this.correct,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trivia_result_id'] = Variable<int>(triviaResultId);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['correct'] = Variable<bool>(correct);
    return map;
  }

  TriviaAnswersTableCompanion toCompanion(bool nullToAbsent) {
    return TriviaAnswersTableCompanion(
      id: Value(id),
      triviaResultId: Value(triviaResultId),
      pokemonId: Value(pokemonId),
      correct: Value(correct),
    );
  }

  factory TriviaAnswerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaAnswerRow(
      id: serializer.fromJson<int>(json['id']),
      triviaResultId: serializer.fromJson<int>(json['triviaResultId']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      correct: serializer.fromJson<bool>(json['correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'triviaResultId': serializer.toJson<int>(triviaResultId),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'correct': serializer.toJson<bool>(correct),
    };
  }

  TriviaAnswerRow copyWith({
    int? id,
    int? triviaResultId,
    int? pokemonId,
    bool? correct,
  }) => TriviaAnswerRow(
    id: id ?? this.id,
    triviaResultId: triviaResultId ?? this.triviaResultId,
    pokemonId: pokemonId ?? this.pokemonId,
    correct: correct ?? this.correct,
  );
  TriviaAnswerRow copyWithCompanion(TriviaAnswersTableCompanion data) {
    return TriviaAnswerRow(
      id: data.id.present ? data.id.value : this.id,
      triviaResultId: data.triviaResultId.present
          ? data.triviaResultId.value
          : this.triviaResultId,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      correct: data.correct.present ? data.correct.value : this.correct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswerRow(')
          ..write('id: $id, ')
          ..write('triviaResultId: $triviaResultId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, triviaResultId, pokemonId, correct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaAnswerRow &&
          other.id == this.id &&
          other.triviaResultId == this.triviaResultId &&
          other.pokemonId == this.pokemonId &&
          other.correct == this.correct);
}

class TriviaAnswersTableCompanion extends UpdateCompanion<TriviaAnswerRow> {
  final Value<int> id;
  final Value<int> triviaResultId;
  final Value<int> pokemonId;
  final Value<bool> correct;
  const TriviaAnswersTableCompanion({
    this.id = const Value.absent(),
    this.triviaResultId = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.correct = const Value.absent(),
  });
  TriviaAnswersTableCompanion.insert({
    this.id = const Value.absent(),
    required int triviaResultId,
    required int pokemonId,
    required bool correct,
  }) : triviaResultId = Value(triviaResultId),
       pokemonId = Value(pokemonId),
       correct = Value(correct);
  static Insertable<TriviaAnswerRow> custom({
    Expression<int>? id,
    Expression<int>? triviaResultId,
    Expression<int>? pokemonId,
    Expression<bool>? correct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (triviaResultId != null) 'trivia_result_id': triviaResultId,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (correct != null) 'correct': correct,
    });
  }

  TriviaAnswersTableCompanion copyWith({
    Value<int>? id,
    Value<int>? triviaResultId,
    Value<int>? pokemonId,
    Value<bool>? correct,
  }) {
    return TriviaAnswersTableCompanion(
      id: id ?? this.id,
      triviaResultId: triviaResultId ?? this.triviaResultId,
      pokemonId: pokemonId ?? this.pokemonId,
      correct: correct ?? this.correct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (triviaResultId.present) {
      map['trivia_result_id'] = Variable<int>(triviaResultId.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (correct.present) {
      map['correct'] = Variable<bool>(correct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswersTableCompanion(')
          ..write('id: $id, ')
          ..write('triviaResultId: $triviaResultId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTableTable extends AchievementsTable
    with TableInfo<$AchievementsTableTable, AchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _achievementKeyMeta = const VerificationMeta(
    'achievementKey',
  );
  @override
  late final GeneratedColumn<String> achievementKey = GeneratedColumn<String>(
    'achievement_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [achievementKey, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievement_unlocked';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('achievement_key')) {
      context.handle(
        _achievementKeyMeta,
        achievementKey.isAcceptableOrUnknown(
          data['achievement_key']!,
          _achievementKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementKeyMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {achievementKey};
  @override
  AchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementRow(
      achievementKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_key'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $AchievementsTableTable createAlias(String alias) {
    return $AchievementsTableTable(attachedDatabase, alias);
  }
}

class AchievementRow extends DataClass implements Insertable<AchievementRow> {
  final String achievementKey;
  final DateTime unlockedAt;
  const AchievementRow({
    required this.achievementKey,
    required this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['achievement_key'] = Variable<String>(achievementKey);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  AchievementsTableCompanion toCompanion(bool nullToAbsent) {
    return AchievementsTableCompanion(
      achievementKey: Value(achievementKey),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory AchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementRow(
      achievementKey: serializer.fromJson<String>(json['achievementKey']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'achievementKey': serializer.toJson<String>(achievementKey),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  AchievementRow copyWith({String? achievementKey, DateTime? unlockedAt}) =>
      AchievementRow(
        achievementKey: achievementKey ?? this.achievementKey,
        unlockedAt: unlockedAt ?? this.unlockedAt,
      );
  AchievementRow copyWithCompanion(AchievementsTableCompanion data) {
    return AchievementRow(
      achievementKey: data.achievementKey.present
          ? data.achievementKey.value
          : this.achievementKey,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementRow(')
          ..write('achievementKey: $achievementKey, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(achievementKey, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementRow &&
          other.achievementKey == this.achievementKey &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsTableCompanion extends UpdateCompanion<AchievementRow> {
  final Value<String> achievementKey;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const AchievementsTableCompanion({
    this.achievementKey = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsTableCompanion.insert({
    required String achievementKey,
    required DateTime unlockedAt,
    this.rowid = const Value.absent(),
  }) : achievementKey = Value(achievementKey),
       unlockedAt = Value(unlockedAt);
  static Insertable<AchievementRow> custom({
    Expression<String>? achievementKey,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (achievementKey != null) 'achievement_key': achievementKey,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsTableCompanion copyWith({
    Value<String>? achievementKey,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementsTableCompanion(
      achievementKey: achievementKey ?? this.achievementKey,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (achievementKey.present) {
      map['achievement_key'] = Variable<String>(achievementKey.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableCompanion(')
          ..write('achievementKey: $achievementKey, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTableTable extends SyncMetadataTable
    with TableInfo<$SyncMetadataTableTable, SyncMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceKeyMeta = const VerificationMeta(
    'resourceKey',
  );
  @override
  late final GeneratedColumn<String> resourceKey = GeneratedColumn<String>(
    'resource_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatusDb, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncStatusDb>($SyncMetadataTableTable.$converterstatus);
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextOffsetMeta = const VerificationMeta(
    'nextOffset',
  );
  @override
  late final GeneratedColumn<int> nextOffset = GeneratedColumn<int>(
    'next_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    resourceKey,
    status,
    lastSuccessAt,
    lastAttemptAt,
    nextOffset,
    totalCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource_key')) {
      context.handle(
        _resourceKeyMeta,
        resourceKey.isAcceptableOrUnknown(
          data['resource_key']!,
          _resourceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resourceKeyMeta);
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('next_offset')) {
      context.handle(
        _nextOffsetMeta,
        nextOffset.isAcceptableOrUnknown(data['next_offset']!, _nextOffsetMeta),
      );
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resourceKey};
  @override
  SyncMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataRow(
      resourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_key'],
      )!,
      status: $SyncMetadataTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      nextOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_offset'],
      )!,
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncMetadataTableTable createAlias(String alias) {
    return $SyncMetadataTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatusDb, String, String> $converterstatus =
      const EnumNameConverter<SyncStatusDb>(SyncStatusDb.values);
}

class SyncMetadataRow extends DataClass implements Insertable<SyncMetadataRow> {
  final String resourceKey;
  final SyncStatusDb status;
  final DateTime? lastSuccessAt;
  final DateTime? lastAttemptAt;
  final int nextOffset;
  final int? totalCount;
  final String? lastError;
  const SyncMetadataRow({
    required this.resourceKey,
    required this.status,
    this.lastSuccessAt,
    this.lastAttemptAt,
    required this.nextOffset,
    this.totalCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_key'] = Variable<String>(resourceKey);
    {
      map['status'] = Variable<String>(
        $SyncMetadataTableTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['next_offset'] = Variable<int>(nextOffset);
    if (!nullToAbsent || totalCount != null) {
      map['total_count'] = Variable<int>(totalCount);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataTableCompanion(
      resourceKey: Value(resourceKey),
      status: Value(status),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      nextOffset: Value(nextOffset),
      totalCount: totalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataRow(
      resourceKey: serializer.fromJson<String>(json['resourceKey']),
      status: $SyncMetadataTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      nextOffset: serializer.fromJson<int>(json['nextOffset']),
      totalCount: serializer.fromJson<int?>(json['totalCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceKey': serializer.toJson<String>(resourceKey),
      'status': serializer.toJson<String>(
        $SyncMetadataTableTable.$converterstatus.toJson(status),
      ),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'nextOffset': serializer.toJson<int>(nextOffset),
      'totalCount': serializer.toJson<int?>(totalCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncMetadataRow copyWith({
    String? resourceKey,
    SyncStatusDb? status,
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    int? nextOffset,
    Value<int?> totalCount = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
  }) => SyncMetadataRow(
    resourceKey: resourceKey ?? this.resourceKey,
    status: status ?? this.status,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    nextOffset: nextOffset ?? this.nextOffset,
    totalCount: totalCount.present ? totalCount.value : this.totalCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataTableCompanion data) {
    return SyncMetadataRow(
      resourceKey: data.resourceKey.present
          ? data.resourceKey.value
          : this.resourceKey,
      status: data.status.present ? data.status.value : this.status,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      nextOffset: data.nextOffset.present
          ? data.nextOffset.value
          : this.nextOffset,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('resourceKey: $resourceKey, ')
          ..write('status: $status, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextOffset: $nextOffset, ')
          ..write('totalCount: $totalCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    resourceKey,
    status,
    lastSuccessAt,
    lastAttemptAt,
    nextOffset,
    totalCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.resourceKey == this.resourceKey &&
          other.status == this.status &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.nextOffset == this.nextOffset &&
          other.totalCount == this.totalCount &&
          other.lastError == this.lastError);
}

class SyncMetadataTableCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> resourceKey;
  final Value<SyncStatusDb> status;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<int> nextOffset;
  final Value<int?> totalCount;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncMetadataTableCompanion({
    this.resourceKey = const Value.absent(),
    this.status = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextOffset = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataTableCompanion.insert({
    required String resourceKey,
    required SyncStatusDb status,
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextOffset = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resourceKey = Value(resourceKey),
       status = Value(status);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? resourceKey,
    Expression<String>? status,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<int>? nextOffset,
    Expression<int>? totalCount,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceKey != null) 'resource_key': resourceKey,
      if (status != null) 'status': status,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (nextOffset != null) 'next_offset': nextOffset,
      if (totalCount != null) 'total_count': totalCount,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataTableCompanion copyWith({
    Value<String>? resourceKey,
    Value<SyncStatusDb>? status,
    Value<DateTime?>? lastSuccessAt,
    Value<DateTime?>? lastAttemptAt,
    Value<int>? nextOffset,
    Value<int?>? totalCount,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncMetadataTableCompanion(
      resourceKey: resourceKey ?? this.resourceKey,
      status: status ?? this.status,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      nextOffset: nextOffset ?? this.nextOffset,
      totalCount: totalCount ?? this.totalCount,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resourceKey.present) {
      map['resource_key'] = Variable<String>(resourceKey.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncMetadataTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (nextOffset.present) {
      map['next_offset'] = Variable<int>(nextOffset.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableCompanion(')
          ..write('resourceKey: $resourceKey, ')
          ..write('status: $status, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextOffset: $nextOffset, ')
          ..write('totalCount: $totalCount, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GenerationsTableTable generationsTable = $GenerationsTableTable(
    this,
  );
  late final $SpeciesTableTable speciesTable = $SpeciesTableTable(this);
  late final $PokemonTableTable pokemonTable = $PokemonTableTable(this);
  late final $TypesTableTable typesTable = $TypesTableTable(this);
  late final $PokemonTypesTableTable pokemonTypesTable =
      $PokemonTypesTableTable(this);
  late final $PokemonFormsTableTable pokemonFormsTable =
      $PokemonFormsTableTable(this);
  late final $PokemonFormTypesTableTable pokemonFormTypesTable =
      $PokemonFormTypesTableTable(this);
  late final $TypeEfficacyTableTable typeEfficacyTable =
      $TypeEfficacyTableTable(this);
  late final $AbilitiesTableTable abilitiesTable = $AbilitiesTableTable(this);
  late final $PokemonAbilitiesTableTable pokemonAbilitiesTable =
      $PokemonAbilitiesTableTable(this);
  late final $VersionGroupsTableTable versionGroupsTable =
      $VersionGroupsTableTable(this);
  late final $MovesTableTable movesTable = $MovesTableTable(this);
  late final $PokemonMovesTableTable pokemonMovesTable =
      $PokemonMovesTableTable(this);
  late final $EvolutionsTableTable evolutionsTable = $EvolutionsTableTable(
    this,
  );
  late final $EggGroupsTableTable eggGroupsTable = $EggGroupsTableTable(this);
  late final $SpeciesEggGroupsTableTable speciesEggGroupsTable =
      $SpeciesEggGroupsTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $TriviaResultsTableTable triviaResultsTable =
      $TriviaResultsTableTable(this);
  late final $TriviaAnswersTableTable triviaAnswersTable =
      $TriviaAnswersTableTable(this);
  late final $AchievementsTableTable achievementsTable =
      $AchievementsTableTable(this);
  late final $SyncMetadataTableTable syncMetadataTable =
      $SyncMetadataTableTable(this);
  late final Index idxSpeciesGeneration = Index(
    'idx_species_generation',
    'CREATE INDEX idx_species_generation ON species (generation_id)',
  );
  late final Index idxSpeciesChain = Index(
    'idx_species_chain',
    'CREATE INDEX idx_species_chain ON species (evolution_chain_id)',
  );
  late final Index idxPokemonName = Index(
    'idx_pokemon_name',
    'CREATE INDEX idx_pokemon_name ON pokemon (name)',
  );
  late final Index idxPokemonSpecies = Index(
    'idx_pokemon_species',
    'CREATE INDEX idx_pokemon_species ON pokemon (species_id)',
  );
  late final Index idxPokemonBst = Index(
    'idx_pokemon_bst',
    'CREATE INDEX idx_pokemon_bst ON pokemon (base_stat_total)',
  );
  late final Index idxPokemonTypeType = Index(
    'idx_pokemon_type_type',
    'CREATE INDEX idx_pokemon_type_type ON pokemon_type (type_id)',
  );
  late final Index idxPokemonFormPokemon = Index(
    'idx_pokemon_form_pokemon',
    'CREATE INDEX idx_pokemon_form_pokemon ON pokemon_form (pokemon_id)',
  );
  late final Index idxPokemonAbilityAbility = Index(
    'idx_pokemon_ability_ability',
    'CREATE INDEX idx_pokemon_ability_ability ON pokemon_ability (ability_id)',
  );
  late final Index idxEvolutionFrom = Index(
    'idx_evolution_from',
    'CREATE INDEX idx_evolution_from ON evolution (from_species_id)',
  );
  late final Index idxEvolutionTo = Index(
    'idx_evolution_to',
    'CREATE INDEX idx_evolution_to ON evolution (to_species_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    generationsTable,
    speciesTable,
    pokemonTable,
    typesTable,
    pokemonTypesTable,
    pokemonFormsTable,
    pokemonFormTypesTable,
    typeEfficacyTable,
    abilitiesTable,
    pokemonAbilitiesTable,
    versionGroupsTable,
    movesTable,
    pokemonMovesTable,
    evolutionsTable,
    eggGroupsTable,
    speciesEggGroupsTable,
    favoritesTable,
    triviaResultsTable,
    triviaAnswersTable,
    achievementsTable,
    syncMetadataTable,
    idxSpeciesGeneration,
    idxSpeciesChain,
    idxPokemonName,
    idxPokemonSpecies,
    idxPokemonBst,
    idxPokemonTypeType,
    idxPokemonFormPokemon,
    idxPokemonAbilityAbility,
    idxEvolutionFrom,
    idxEvolutionTo,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_type', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_form', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon_form',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_form_type', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_ability', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_move', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'species',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('species_egg_group', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trivia_result',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trivia_answer', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GenerationsTableTableCreateCompanionBuilder =
    GenerationsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> mainRegion,
    });
typedef $$GenerationsTableTableUpdateCompanionBuilder =
    GenerationsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> mainRegion,
    });

final class $$GenerationsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $GenerationsTableTable, GenerationRow> {
  $$GenerationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SpeciesTableTable, List<SpeciesRow>>
  _speciesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.speciesTable,
    aliasName: 'generation__id__species__generation_id',
  );

  $$SpeciesTableTableProcessedTableManager get speciesTableRefs {
    final manager = $$SpeciesTableTableTableManager(
      $_db,
      $_db.speciesTable,
    ).filter((f) => f.generationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_speciesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VersionGroupsTableTable, List<VersionGroupRow>>
  _versionGroupsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.versionGroupsTable,
        aliasName: 'generation__id__version_group__generation_id',
      );

  $$VersionGroupsTableTableProcessedTableManager get versionGroupsTableRefs {
    final manager = $$VersionGroupsTableTableTableManager(
      $_db,
      $_db.versionGroupsTable,
    ).filter((f) => f.generationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _versionGroupsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GenerationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GenerationsTableTable> {
  $$GenerationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainRegion => $composableBuilder(
    column: $table.mainRegion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> speciesTableRefs(
    Expression<bool> Function($$SpeciesTableTableFilterComposer f) f,
  ) {
    final $$SpeciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.generationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableFilterComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> versionGroupsTableRefs(
    Expression<bool> Function($$VersionGroupsTableTableFilterComposer f) f,
  ) {
    final $$VersionGroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.versionGroupsTable,
      getReferencedColumn: (t) => t.generationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionGroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.versionGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GenerationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GenerationsTableTable> {
  $$GenerationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainRegion => $composableBuilder(
    column: $table.mainRegion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GenerationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenerationsTableTable> {
  $$GenerationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mainRegion => $composableBuilder(
    column: $table.mainRegion,
    builder: (column) => column,
  );

  Expression<T> speciesTableRefs<T extends Object>(
    Expression<T> Function($$SpeciesTableTableAnnotationComposer a) f,
  ) {
    final $$SpeciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.generationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> versionGroupsTableRefs<T extends Object>(
    Expression<T> Function($$VersionGroupsTableTableAnnotationComposer a) f,
  ) {
    final $$VersionGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.versionGroupsTable,
          getReferencedColumn: (t) => t.generationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VersionGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.versionGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GenerationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GenerationsTableTable,
          GenerationRow,
          $$GenerationsTableTableFilterComposer,
          $$GenerationsTableTableOrderingComposer,
          $$GenerationsTableTableAnnotationComposer,
          $$GenerationsTableTableCreateCompanionBuilder,
          $$GenerationsTableTableUpdateCompanionBuilder,
          (GenerationRow, $$GenerationsTableTableReferences),
          GenerationRow,
          PrefetchHooks Function({
            bool speciesTableRefs,
            bool versionGroupsTableRefs,
          })
        > {
  $$GenerationsTableTableTableManager(
    _$AppDatabase db,
    $GenerationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenerationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenerationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenerationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> mainRegion = const Value.absent(),
              }) => GenerationsTableCompanion(
                id: id,
                name: name,
                mainRegion: mainRegion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> mainRegion = const Value.absent(),
              }) => GenerationsTableCompanion.insert(
                id: id,
                name: name,
                mainRegion: mainRegion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GenerationsTableTable, GenerationRow>(table),
                  $$GenerationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({speciesTableRefs = false, versionGroupsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (speciesTableRefs) db.speciesTable,
                    if (versionGroupsTableRefs) db.versionGroupsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (speciesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          GenerationRow,
                          $GenerationsTableTable,
                          SpeciesRow,
                          $SpeciesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$GenerationsTableTableReferences
                              ._speciesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GenerationsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'generation_id',
                          typedResults: items,
                        ),
                      if (versionGroupsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          GenerationRow,
                          $GenerationsTableTable,
                          VersionGroupRow,
                          $VersionGroupsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$GenerationsTableTableReferences
                              ._versionGroupsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GenerationsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).versionGroupsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'generation_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GenerationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GenerationsTableTable,
      GenerationRow,
      $$GenerationsTableTableFilterComposer,
      $$GenerationsTableTableOrderingComposer,
      $$GenerationsTableTableAnnotationComposer,
      $$GenerationsTableTableCreateCompanionBuilder,
      $$GenerationsTableTableUpdateCompanionBuilder,
      (GenerationRow, $$GenerationsTableTableReferences),
      GenerationRow,
      PrefetchHooks Function({
        bool speciesTableRefs,
        bool versionGroupsTableRefs,
      })
    >;
typedef $$SpeciesTableTableCreateCompanionBuilder =
    SpeciesTableCompanion Function({
      Value<int> id,
      required String name,
      required int generationId,
      required int evolutionChainId,
    });
typedef $$SpeciesTableTableUpdateCompanionBuilder =
    SpeciesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> generationId,
      Value<int> evolutionChainId,
    });

final class $$SpeciesTableTableReferences
    extends BaseReferences<_$AppDatabase, $SpeciesTableTable, SpeciesRow> {
  $$SpeciesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GenerationsTableTable _generationIdTable(_$AppDatabase db) =>
      db.generationsTable.createAlias('species__generation_id__generation__id');

  $$GenerationsTableTableProcessedTableManager get generationId {
    final $_column = $_itemColumn<int>('generation_id')!;

    final manager = $$GenerationsTableTableTableManager(
      $_db,
      $_db.generationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_generationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PokemonTableTable, List<PokemonRow>>
  _pokemonTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTable,
    aliasName: 'species__id__pokemon__species_id',
  );

  $$PokemonTableTableProcessedTableManager get pokemonTableRefs {
    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpeciesEggGroupsTableTable,
    List<SpeciesEggGroupRow>
  >
  _speciesEggGroupsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speciesEggGroupsTable,
        aliasName: 'species__id__species_egg_group__species_id',
      );

  $$SpeciesEggGroupsTableTableProcessedTableManager
  get speciesEggGroupsTableRefs {
    final manager = $$SpeciesEggGroupsTableTableTableManager(
      $_db,
      $_db.speciesEggGroupsTable,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speciesEggGroupsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesTableTable> {
  $$SpeciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnFilters(column),
  );

  $$GenerationsTableTableFilterComposer get generationId {
    final $$GenerationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableFilterComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pokemonTableRefs(
    Expression<bool> Function($$PokemonTableTableFilterComposer f) f,
  ) {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> speciesEggGroupsTableRefs(
    Expression<bool> Function($$SpeciesEggGroupsTableTableFilterComposer f) f,
  ) {
    final $$SpeciesEggGroupsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesEggGroupsTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesEggGroupsTableTableFilterComposer(
                $db: $db,
                $table: $db.speciesEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpeciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesTableTable> {
  $$SpeciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => ColumnOrderings(column),
  );

  $$GenerationsTableTableOrderingComposer get generationId {
    final $$GenerationsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableOrderingComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesTableTable> {
  $$SpeciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get evolutionChainId => $composableBuilder(
    column: $table.evolutionChainId,
    builder: (column) => column,
  );

  $$GenerationsTableTableAnnotationComposer get generationId {
    final $$GenerationsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pokemonTableRefs<T extends Object>(
    Expression<T> Function($$PokemonTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> speciesEggGroupsTableRefs<T extends Object>(
    Expression<T> Function($$SpeciesEggGroupsTableTableAnnotationComposer a) f,
  ) {
    final $$SpeciesEggGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesEggGroupsTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesEggGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpeciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesTableTable,
          SpeciesRow,
          $$SpeciesTableTableFilterComposer,
          $$SpeciesTableTableOrderingComposer,
          $$SpeciesTableTableAnnotationComposer,
          $$SpeciesTableTableCreateCompanionBuilder,
          $$SpeciesTableTableUpdateCompanionBuilder,
          (SpeciesRow, $$SpeciesTableTableReferences),
          SpeciesRow,
          PrefetchHooks Function({
            bool generationId,
            bool pokemonTableRefs,
            bool speciesEggGroupsTableRefs,
          })
        > {
  $$SpeciesTableTableTableManager(_$AppDatabase db, $SpeciesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeciesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeciesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> generationId = const Value.absent(),
                Value<int> evolutionChainId = const Value.absent(),
              }) => SpeciesTableCompanion(
                id: id,
                name: name,
                generationId: generationId,
                evolutionChainId: evolutionChainId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int generationId,
                required int evolutionChainId,
              }) => SpeciesTableCompanion.insert(
                id: id,
                name: name,
                generationId: generationId,
                evolutionChainId: evolutionChainId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpeciesTableTable, SpeciesRow>(table),
                  $$SpeciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                generationId = false,
                pokemonTableRefs = false,
                speciesEggGroupsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTableRefs) db.pokemonTable,
                    if (speciesEggGroupsTableRefs) db.speciesEggGroupsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (generationId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.generationId,
                            referencedTable: $$SpeciesTableTableReferences
                                ._generationIdTable(db),
                            referencedColumn: $$SpeciesTableTableReferences
                                ._generationIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTableRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesRow,
                          $SpeciesTableTable,
                          PokemonRow,
                          $PokemonTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableTableReferences
                              ._pokemonTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                      if (speciesEggGroupsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesRow,
                          $SpeciesTableTable,
                          SpeciesEggGroupRow,
                          $SpeciesEggGroupsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableTableReferences
                              ._speciesEggGroupsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesEggGroupsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SpeciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesTableTable,
      SpeciesRow,
      $$SpeciesTableTableFilterComposer,
      $$SpeciesTableTableOrderingComposer,
      $$SpeciesTableTableAnnotationComposer,
      $$SpeciesTableTableCreateCompanionBuilder,
      $$SpeciesTableTableUpdateCompanionBuilder,
      (SpeciesRow, $$SpeciesTableTableReferences),
      SpeciesRow,
      PrefetchHooks Function({
        bool generationId,
        bool pokemonTableRefs,
        bool speciesEggGroupsTableRefs,
      })
    >;
typedef $$PokemonTableTableCreateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      required int speciesId,
      required String name,
      required bool isDefault,
      Value<int?> height,
      Value<int?> weight,
      required int hp,
      required int attack,
      required int defense,
      required int specialAttack,
      required int specialDefense,
      required int speed,
      Value<String?> spriteUrl,
      Value<String?> spriteShinyUrl,
      Value<String?> artworkUrl,
      Value<String?> artworkShinyUrl,
      Value<String?> artworkLocalPath,
      required DateTime updatedAt,
    });
typedef $$PokemonTableTableUpdateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      Value<int> speciesId,
      Value<String> name,
      Value<bool> isDefault,
      Value<int?> height,
      Value<int?> weight,
      Value<int> hp,
      Value<int> attack,
      Value<int> defense,
      Value<int> specialAttack,
      Value<int> specialDefense,
      Value<int> speed,
      Value<String?> spriteUrl,
      Value<String?> spriteShinyUrl,
      Value<String?> artworkUrl,
      Value<String?> artworkShinyUrl,
      Value<String?> artworkLocalPath,
      Value<DateTime> updatedAt,
    });

final class $$PokemonTableTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonTableTable, PokemonRow> {
  $$PokemonTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SpeciesTableTable _speciesIdTable(_$AppDatabase db) =>
      db.speciesTable.createAlias('pokemon__species_id__species__id');

  $$SpeciesTableTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$SpeciesTableTableTableManager(
      $_db,
      $_db.speciesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PokemonTypesTableTable, List<PokemonTypeRow>>
  _pokemonTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonTypesTable,
        aliasName: 'pokemon__id__pokemon_type__pokemon_id',
      );

  $$PokemonTypesTableTableProcessedTableManager get pokemonTypesTableRefs {
    final manager = $$PokemonTypesTableTableTableManager(
      $_db,
      $_db.pokemonTypesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonFormsTableTable, List<PokemonFormRow>>
  _pokemonFormsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonFormsTable,
        aliasName: 'pokemon__id__pokemon_form__pokemon_id',
      );

  $$PokemonFormsTableTableProcessedTableManager get pokemonFormsTableRefs {
    final manager = $$PokemonFormsTableTableTableManager(
      $_db,
      $_db.pokemonFormsTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonFormsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PokemonAbilitiesTableTable,
    List<PokemonAbilityRow>
  >
  _pokemonAbilitiesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonAbilitiesTable,
        aliasName: 'pokemon__id__pokemon_ability__pokemon_id',
      );

  $$PokemonAbilitiesTableTableProcessedTableManager
  get pokemonAbilitiesTableRefs {
    final manager = $$PokemonAbilitiesTableTableTableManager(
      $_db,
      $_db.pokemonAbilitiesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonMovesTableTable, List<PokemonMoveRow>>
  _pokemonMovesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonMovesTable,
        aliasName: 'pokemon__id__pokemon_move__pokemon_id',
      );

  $$PokemonMovesTableTableProcessedTableManager get pokemonMovesTableRefs {
    final manager = $$PokemonMovesTableTableTableManager(
      $_db,
      $_db.pokemonMovesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonMovesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTableTable, List<FavoriteRow>>
  _favoritesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favoritesTable,
    aliasName: 'pokemon__id__favorite__pokemon_id',
  );

  $$FavoritesTableTableProcessedTableManager get favoritesTableRefs {
    final manager = $$FavoritesTableTableTableManager(
      $_db,
      $_db.favoritesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defense => $composableBuilder(
    column: $table.defense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkShinyUrl => $composableBuilder(
    column: $table.artworkShinyUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkLocalPath => $composableBuilder(
    column: $table.artworkLocalPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SpeciesTableTableFilterComposer get speciesId {
    final $$SpeciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableFilterComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pokemonTypesTableRefs(
    Expression<bool> Function($$PokemonTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonFormsTableRefs(
    Expression<bool> Function($$PokemonFormsTableTableFilterComposer f) f,
  ) {
    final $$PokemonFormsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonFormsTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonFormsTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonFormsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonAbilitiesTableRefs(
    Expression<bool> Function($$PokemonAbilitiesTableTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> pokemonMovesTableRefs(
    Expression<bool> Function($$PokemonMovesTableTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMovesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMovesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesTableRefs(
    Expression<bool> Function($$FavoritesTableTableFilterComposer f) f,
  ) {
    final $$FavoritesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favoritesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableTableFilterComposer(
            $db: $db,
            $table: $db.favoritesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defense => $composableBuilder(
    column: $table.defense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkShinyUrl => $composableBuilder(
    column: $table.artworkShinyUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkLocalPath => $composableBuilder(
    column: $table.artworkLocalPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpeciesTableTableOrderingComposer get speciesId {
    final $$SpeciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<int> get attack =>
      $composableBuilder(column: $table.attack, builder: (column) => column);

  GeneratedColumn<int> get defense =>
      $composableBuilder(column: $table.defense, builder: (column) => column);

  GeneratedColumn<int> get specialAttack => $composableBuilder(
    column: $table.specialAttack,
    builder: (column) => column,
  );

  GeneratedColumn<int> get specialDefense => $composableBuilder(
    column: $table.specialDefense,
    builder: (column) => column,
  );

  GeneratedColumn<int> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get spriteUrl =>
      $composableBuilder(column: $table.spriteUrl, builder: (column) => column);

  GeneratedColumn<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkShinyUrl => $composableBuilder(
    column: $table.artworkShinyUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkLocalPath => $composableBuilder(
    column: $table.artworkLocalPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SpeciesTableTableAnnotationComposer get speciesId {
    final $$SpeciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pokemonTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonTypesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonFormsTableRefs<T extends Object>(
    Expression<T> Function($$PokemonFormsTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonFormsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonFormsTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonFormsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonAbilitiesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonMovesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonMovesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonMovesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonMovesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> favoritesTableRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favoritesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.favoritesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTableTable,
          PokemonRow,
          $$PokemonTableTableFilterComposer,
          $$PokemonTableTableOrderingComposer,
          $$PokemonTableTableAnnotationComposer,
          $$PokemonTableTableCreateCompanionBuilder,
          $$PokemonTableTableUpdateCompanionBuilder,
          (PokemonRow, $$PokemonTableTableReferences),
          PokemonRow,
          PrefetchHooks Function({
            bool speciesId,
            bool pokemonTypesTableRefs,
            bool pokemonFormsTableRefs,
            bool pokemonAbilitiesTableRefs,
            bool pokemonMovesTableRefs,
            bool favoritesTableRefs,
          })
        > {
  $$PokemonTableTableTableManager(_$AppDatabase db, $PokemonTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int> hp = const Value.absent(),
                Value<int> attack = const Value.absent(),
                Value<int> defense = const Value.absent(),
                Value<int> specialAttack = const Value.absent(),
                Value<int> specialDefense = const Value.absent(),
                Value<int> speed = const Value.absent(),
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> spriteShinyUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<String?> artworkShinyUrl = const Value.absent(),
                Value<String?> artworkLocalPath = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PokemonTableCompanion(
                id: id,
                speciesId: speciesId,
                name: name,
                isDefault: isDefault,
                height: height,
                weight: weight,
                hp: hp,
                attack: attack,
                defense: defense,
                specialAttack: specialAttack,
                specialDefense: specialDefense,
                speed: speed,
                spriteUrl: spriteUrl,
                spriteShinyUrl: spriteShinyUrl,
                artworkUrl: artworkUrl,
                artworkShinyUrl: artworkShinyUrl,
                artworkLocalPath: artworkLocalPath,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int speciesId,
                required String name,
                required bool isDefault,
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                required int hp,
                required int attack,
                required int defense,
                required int specialAttack,
                required int specialDefense,
                required int speed,
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> spriteShinyUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<String?> artworkShinyUrl = const Value.absent(),
                Value<String?> artworkLocalPath = const Value.absent(),
                required DateTime updatedAt,
              }) => PokemonTableCompanion.insert(
                id: id,
                speciesId: speciesId,
                name: name,
                isDefault: isDefault,
                height: height,
                weight: weight,
                hp: hp,
                attack: attack,
                defense: defense,
                specialAttack: specialAttack,
                specialDefense: specialDefense,
                speed: speed,
                spriteUrl: spriteUrl,
                spriteShinyUrl: spriteShinyUrl,
                artworkUrl: artworkUrl,
                artworkShinyUrl: artworkShinyUrl,
                artworkLocalPath: artworkLocalPath,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTableTable, PokemonRow>(table),
                  $$PokemonTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                speciesId = false,
                pokemonTypesTableRefs = false,
                pokemonFormsTableRefs = false,
                pokemonAbilitiesTableRefs = false,
                pokemonMovesTableRefs = false,
                favoritesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesTableRefs) db.pokemonTypesTable,
                    if (pokemonFormsTableRefs) db.pokemonFormsTable,
                    if (pokemonAbilitiesTableRefs) db.pokemonAbilitiesTable,
                    if (pokemonMovesTableRefs) db.pokemonMovesTable,
                    if (favoritesTableRefs) db.favoritesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (speciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.speciesId,
                            referencedTable: $$PokemonTableTableReferences
                                ._speciesIdTable(db),
                            referencedColumn: $$PokemonTableTableReferences
                                ._speciesIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonTypeRow,
                          $PokemonTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonFormsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonFormRow,
                          $PokemonFormsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonFormsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonFormsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonAbilitiesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonAbilityRow,
                          $PokemonAbilitiesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonAbilitiesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonAbilitiesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonMovesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonMoveRow,
                          $PokemonMovesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonMovesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonMovesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (favoritesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          FavoriteRow,
                          $FavoritesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._favoritesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTableTable,
      PokemonRow,
      $$PokemonTableTableFilterComposer,
      $$PokemonTableTableOrderingComposer,
      $$PokemonTableTableAnnotationComposer,
      $$PokemonTableTableCreateCompanionBuilder,
      $$PokemonTableTableUpdateCompanionBuilder,
      (PokemonRow, $$PokemonTableTableReferences),
      PokemonRow,
      PrefetchHooks Function({
        bool speciesId,
        bool pokemonTypesTableRefs,
        bool pokemonFormsTableRefs,
        bool pokemonAbilitiesTableRefs,
        bool pokemonMovesTableRefs,
        bool favoritesTableRefs,
      })
    >;
typedef $$TypesTableTableCreateCompanionBuilder = TypesTableCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> nameEs,
});
typedef $$TypesTableTableUpdateCompanionBuilder = TypesTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> nameEs,
});

final class $$TypesTableTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTableTable, TypeRow> {
  $$TypesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTableTable, List<PokemonTypeRow>>
  _pokemonTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonTypesTable,
        aliasName: 'type__id__pokemon_type__type_id',
      );

  $$PokemonTypesTableTableProcessedTableManager get pokemonTypesTableRefs {
    final manager = $$PokemonTypesTableTableTableManager(
      $_db,
      $_db.pokemonTypesTable,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PokemonFormTypesTableTable,
    List<PokemonFormTypeRow>
  >
  _pokemonFormTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonFormTypesTable,
        aliasName: 'type__id__pokemon_form_type__type_id',
      );

  $$PokemonFormTypesTableTableProcessedTableManager
  get pokemonFormTypesTableRefs {
    final manager = $$PokemonFormTypesTableTableTableManager(
      $_db,
      $_db.pokemonFormTypesTable,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonFormTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovesTableTable, List<MoveRow>>
  _movesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movesTable,
    aliasName: 'type__id__move__type_id',
  );

  $$MovesTableTableProcessedTableManager get movesTableRefs {
    final manager = $$MovesTableTableTableManager(
      $_db,
      $_db.movesTable,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesTableRefs(
    Expression<bool> Function($$PokemonTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonFormTypesTableRefs(
    Expression<bool> Function($$PokemonFormTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonFormTypesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonFormTypesTable,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormTypesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonFormTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> movesTableRefs(
    Expression<bool> Function($$MovesTableTableFilterComposer f) f,
  ) {
    final $$MovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableFilterComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  Expression<T> pokemonTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonTypesTable,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonFormTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonFormTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonFormTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonFormTypesTable,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonFormTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> movesTableRefs<T extends Object>(
    Expression<T> Function($$MovesTableTableAnnotationComposer a) f,
  ) {
    final $$MovesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTableTable,
          TypeRow,
          $$TypesTableTableFilterComposer,
          $$TypesTableTableOrderingComposer,
          $$TypesTableTableAnnotationComposer,
          $$TypesTableTableCreateCompanionBuilder,
          $$TypesTableTableUpdateCompanionBuilder,
          (TypeRow, $$TypesTableTableReferences),
          TypeRow,
          PrefetchHooks Function({
            bool pokemonTypesTableRefs,
            bool pokemonFormTypesTableRefs,
            bool movesTableRefs,
          })
        > {
  $$TypesTableTableTableManager(_$AppDatabase db, $TypesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> nameEs = const Value.absent(),
          }) => TypesTableCompanion(id: id, name: name, nameEs: nameEs),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> nameEs = const Value.absent(),
          }) => TypesTableCompanion.insert(id: id, name: name, nameEs: nameEs),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypesTableTable, TypeRow>(table),
                  $$TypesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pokemonTypesTableRefs = false,
                pokemonFormTypesTableRefs = false,
                movesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesTableRefs) db.pokemonTypesTable,
                    if (pokemonFormTypesTableRefs) db.pokemonFormTypesTable,
                    if (movesTableRefs) db.movesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          PokemonTypeRow,
                          $PokemonTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._pokemonTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                      if (pokemonFormTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          PokemonFormTypeRow,
                          $PokemonFormTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._pokemonFormTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonFormTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                      if (movesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          MoveRow,
                          $MovesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._movesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).movesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTableTable,
      TypeRow,
      $$TypesTableTableFilterComposer,
      $$TypesTableTableOrderingComposer,
      $$TypesTableTableAnnotationComposer,
      $$TypesTableTableCreateCompanionBuilder,
      $$TypesTableTableUpdateCompanionBuilder,
      (TypeRow, $$TypesTableTableReferences),
      TypeRow,
      PrefetchHooks Function({
        bool pokemonTypesTableRefs,
        bool pokemonFormTypesTableRefs,
        bool movesTableRefs,
      })
    >;
typedef $$PokemonTypesTableTableCreateCompanionBuilder =
    PokemonTypesTableCompanion Function({
      required int pokemonId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonTypesTableTableUpdateCompanionBuilder =
    PokemonTypesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

final class $$PokemonTypesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonTypesTableTable, PokemonTypeRow> {
  $$PokemonTypesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_type__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTableTable _typeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('pokemon_type__type_id__type__id');

  $$TypesTableTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableFilterComposer get typeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableOrderingComposer get typeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableAnnotationComposer get typeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTableTable,
          PokemonTypeRow,
          $$PokemonTypesTableTableFilterComposer,
          $$PokemonTypesTableTableOrderingComposer,
          $$PokemonTypesTableTableAnnotationComposer,
          $$PokemonTypesTableTableCreateCompanionBuilder,
          $$PokemonTypesTableTableUpdateCompanionBuilder,
          (PokemonTypeRow, $$PokemonTypesTableTableReferences),
          PokemonTypeRow,
          PrefetchHooks Function({bool pokemonId, bool typeId})
        > {
  $$PokemonTypesTableTableTableManager(
    _$AppDatabase db,
    $PokemonTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesTableCompanion(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesTableCompanion.insert(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTableTable, PokemonTypeRow>(table),
                  $$PokemonTypesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonTypesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonTypesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonTypesTableTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonTypesTableTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTableTable,
      PokemonTypeRow,
      $$PokemonTypesTableTableFilterComposer,
      $$PokemonTypesTableTableOrderingComposer,
      $$PokemonTypesTableTableAnnotationComposer,
      $$PokemonTypesTableTableCreateCompanionBuilder,
      $$PokemonTypesTableTableUpdateCompanionBuilder,
      (PokemonTypeRow, $$PokemonTypesTableTableReferences),
      PokemonTypeRow,
      PrefetchHooks Function({bool pokemonId, bool typeId})
    >;
typedef $$PokemonFormsTableTableCreateCompanionBuilder =
    PokemonFormsTableCompanion Function({
      Value<int> id,
      required int pokemonId,
      required String name,
      Value<String?> formName,
      required bool isDefault,
      required bool isMega,
      required bool isBattleOnly,
      Value<int?> formOrder,
      Value<String?> spriteUrl,
      Value<String?> spriteShinyUrl,
    });
typedef $$PokemonFormsTableTableUpdateCompanionBuilder =
    PokemonFormsTableCompanion Function({
      Value<int> id,
      Value<int> pokemonId,
      Value<String> name,
      Value<String?> formName,
      Value<bool> isDefault,
      Value<bool> isMega,
      Value<bool> isBattleOnly,
      Value<int?> formOrder,
      Value<String?> spriteUrl,
      Value<String?> spriteShinyUrl,
    });

final class $$PokemonFormsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonFormsTableTable, PokemonFormRow> {
  $$PokemonFormsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_form__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PokemonFormTypesTableTable,
    List<PokemonFormTypeRow>
  >
  _pokemonFormTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonFormTypesTable,
        aliasName: 'pokemon_form__id__pokemon_form_type__form_id',
      );

  $$PokemonFormTypesTableTableProcessedTableManager
  get pokemonFormTypesTableRefs {
    final manager = $$PokemonFormTypesTableTableTableManager(
      $_db,
      $_db.pokemonFormTypesTable,
    ).filter((f) => f.formId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonFormTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonFormsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonFormsTableTable> {
  $$PokemonFormsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formName => $composableBuilder(
    column: $table.formName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMega => $composableBuilder(
    column: $table.isMega,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBattleOnly => $composableBuilder(
    column: $table.isBattleOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get formOrder => $composableBuilder(
    column: $table.formOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pokemonFormTypesTableRefs(
    Expression<bool> Function($$PokemonFormTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonFormTypesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonFormTypesTable,
          getReferencedColumn: (t) => t.formId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormTypesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonFormTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PokemonFormsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonFormsTableTable> {
  $$PokemonFormsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formName => $composableBuilder(
    column: $table.formName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMega => $composableBuilder(
    column: $table.isMega,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBattleOnly => $composableBuilder(
    column: $table.isBattleOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get formOrder => $composableBuilder(
    column: $table.formOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonFormsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonFormsTableTable> {
  $$PokemonFormsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get formName =>
      $composableBuilder(column: $table.formName, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isMega =>
      $composableBuilder(column: $table.isMega, builder: (column) => column);

  GeneratedColumn<bool> get isBattleOnly => $composableBuilder(
    column: $table.isBattleOnly,
    builder: (column) => column,
  );

  GeneratedColumn<int> get formOrder =>
      $composableBuilder(column: $table.formOrder, builder: (column) => column);

  GeneratedColumn<String> get spriteUrl =>
      $composableBuilder(column: $table.spriteUrl, builder: (column) => column);

  GeneratedColumn<String> get spriteShinyUrl => $composableBuilder(
    column: $table.spriteShinyUrl,
    builder: (column) => column,
  );

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pokemonFormTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonFormTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonFormTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonFormTypesTable,
          getReferencedColumn: (t) => t.formId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonFormTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PokemonFormsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonFormsTableTable,
          PokemonFormRow,
          $$PokemonFormsTableTableFilterComposer,
          $$PokemonFormsTableTableOrderingComposer,
          $$PokemonFormsTableTableAnnotationComposer,
          $$PokemonFormsTableTableCreateCompanionBuilder,
          $$PokemonFormsTableTableUpdateCompanionBuilder,
          (PokemonFormRow, $$PokemonFormsTableTableReferences),
          PokemonFormRow,
          PrefetchHooks Function({
            bool pokemonId,
            bool pokemonFormTypesTableRefs,
          })
        > {
  $$PokemonFormsTableTableTableManager(
    _$AppDatabase db,
    $PokemonFormsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonFormsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonFormsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonFormsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> formName = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isMega = const Value.absent(),
                Value<bool> isBattleOnly = const Value.absent(),
                Value<int?> formOrder = const Value.absent(),
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> spriteShinyUrl = const Value.absent(),
              }) => PokemonFormsTableCompanion(
                id: id,
                pokemonId: pokemonId,
                name: name,
                formName: formName,
                isDefault: isDefault,
                isMega: isMega,
                isBattleOnly: isBattleOnly,
                formOrder: formOrder,
                spriteUrl: spriteUrl,
                spriteShinyUrl: spriteShinyUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pokemonId,
                required String name,
                Value<String?> formName = const Value.absent(),
                required bool isDefault,
                required bool isMega,
                required bool isBattleOnly,
                Value<int?> formOrder = const Value.absent(),
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> spriteShinyUrl = const Value.absent(),
              }) => PokemonFormsTableCompanion.insert(
                id: id,
                pokemonId: pokemonId,
                name: name,
                formName: formName,
                isDefault: isDefault,
                isMega: isMega,
                isBattleOnly: isBattleOnly,
                formOrder: formOrder,
                spriteUrl: spriteUrl,
                spriteShinyUrl: spriteShinyUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonFormsTableTable, PokemonFormRow>(table),
                  $$PokemonFormsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({pokemonId = false, pokemonFormTypesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonFormTypesTableRefs) db.pokemonFormTypesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (pokemonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pokemonId,
                            referencedTable: $$PokemonFormsTableTableReferences
                                ._pokemonIdTable(db),
                            referencedColumn: $$PokemonFormsTableTableReferences
                                ._pokemonIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonFormTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonFormRow,
                          $PokemonFormsTableTable,
                          PokemonFormTypeRow,
                          $PokemonFormTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonFormsTableTableReferences
                              ._pokemonFormTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonFormsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonFormTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'form_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonFormsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonFormsTableTable,
      PokemonFormRow,
      $$PokemonFormsTableTableFilterComposer,
      $$PokemonFormsTableTableOrderingComposer,
      $$PokemonFormsTableTableAnnotationComposer,
      $$PokemonFormsTableTableCreateCompanionBuilder,
      $$PokemonFormsTableTableUpdateCompanionBuilder,
      (PokemonFormRow, $$PokemonFormsTableTableReferences),
      PokemonFormRow,
      PrefetchHooks Function({bool pokemonId, bool pokemonFormTypesTableRefs})
    >;
typedef $$PokemonFormTypesTableTableCreateCompanionBuilder =
    PokemonFormTypesTableCompanion Function({
      required int formId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonFormTypesTableTableUpdateCompanionBuilder =
    PokemonFormTypesTableCompanion Function({
      Value<int> formId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

final class $$PokemonFormTypesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonFormTypesTableTable,
          PokemonFormTypeRow
        > {
  $$PokemonFormTypesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonFormsTableTable _formIdTable(_$AppDatabase db) => db
      .pokemonFormsTable
      .createAlias('pokemon_form_type__form_id__pokemon_form__id');

  $$PokemonFormsTableTableProcessedTableManager get formId {
    final $_column = $_itemColumn<int>('form_id')!;

    final manager = $$PokemonFormsTableTableTableManager(
      $_db,
      $_db.pokemonFormsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTableTable _typeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('pokemon_form_type__type_id__type__id');

  $$TypesTableTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonFormTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonFormTypesTableTable> {
  $$PokemonFormTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonFormsTableTableFilterComposer get formId {
    final $$PokemonFormsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.formId,
      referencedTable: $db.pokemonFormsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonFormsTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonFormsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableFilterComposer get typeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonFormTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonFormTypesTableTable> {
  $$PokemonFormTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonFormsTableTableOrderingComposer get formId {
    final $$PokemonFormsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.formId,
      referencedTable: $db.pokemonFormsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonFormsTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonFormsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableOrderingComposer get typeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonFormTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonFormTypesTableTable> {
  $$PokemonFormTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonFormsTableTableAnnotationComposer get formId {
    final $$PokemonFormsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.formId,
          referencedTable: $db.pokemonFormsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonFormsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonFormsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TypesTableTableAnnotationComposer get typeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonFormTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonFormTypesTableTable,
          PokemonFormTypeRow,
          $$PokemonFormTypesTableTableFilterComposer,
          $$PokemonFormTypesTableTableOrderingComposer,
          $$PokemonFormTypesTableTableAnnotationComposer,
          $$PokemonFormTypesTableTableCreateCompanionBuilder,
          $$PokemonFormTypesTableTableUpdateCompanionBuilder,
          (PokemonFormTypeRow, $$PokemonFormTypesTableTableReferences),
          PokemonFormTypeRow,
          PrefetchHooks Function({bool formId, bool typeId})
        > {
  $$PokemonFormTypesTableTableTableManager(
    _$AppDatabase db,
    $PokemonFormTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonFormTypesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonFormTypesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonFormTypesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> formId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonFormTypesTableCompanion(
                formId: formId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int formId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonFormTypesTableCompanion.insert(
                formId: formId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonFormTypesTableTable, PokemonFormTypeRow>(
                    table,
                  ),
                  $$PokemonFormTypesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({formId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (formId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.formId,
                        referencedTable: $$PokemonFormTypesTableTableReferences
                            ._formIdTable(db),
                        referencedColumn: $$PokemonFormTypesTableTableReferences
                            ._formIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonFormTypesTableTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonFormTypesTableTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonFormTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonFormTypesTableTable,
      PokemonFormTypeRow,
      $$PokemonFormTypesTableTableFilterComposer,
      $$PokemonFormTypesTableTableOrderingComposer,
      $$PokemonFormTypesTableTableAnnotationComposer,
      $$PokemonFormTypesTableTableCreateCompanionBuilder,
      $$PokemonFormTypesTableTableUpdateCompanionBuilder,
      (PokemonFormTypeRow, $$PokemonFormTypesTableTableReferences),
      PokemonFormTypeRow,
      PrefetchHooks Function({bool formId, bool typeId})
    >;
typedef $$TypeEfficacyTableTableCreateCompanionBuilder =
    TypeEfficacyTableCompanion Function({
      required int attackingTypeId,
      required int defendingTypeId,
      required int damageFactor,
      Value<int> rowid,
    });
typedef $$TypeEfficacyTableTableUpdateCompanionBuilder =
    TypeEfficacyTableCompanion Function({
      Value<int> attackingTypeId,
      Value<int> defendingTypeId,
      Value<int> damageFactor,
      Value<int> rowid,
    });

final class $$TypeEfficacyTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TypeEfficacyTableTable,
          TypeEfficacyRow
        > {
  $$TypeEfficacyTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TypesTableTable _attackingTypeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('type_efficacy__attacking_type_id__type__id');

  $$TypesTableTableProcessedTableManager get attackingTypeId {
    final $_column = $_itemColumn<int>('attacking_type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attackingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTableTable _defendingTypeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('type_efficacy__defending_type_id__type__id');

  $$TypesTableTableProcessedTableManager get defendingTypeId {
    final $_column = $_itemColumn<int>('defending_type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defendingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TypeEfficacyTableTableFilterComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTableTable> {
  $$TypeEfficacyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnFilters(column),
  );

  $$TypesTableTableFilterComposer get attackingTypeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableFilterComposer get defendingTypeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficacyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTableTable> {
  $$TypeEfficacyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypesTableTableOrderingComposer get attackingTypeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableOrderingComposer get defendingTypeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficacyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypeEfficacyTableTable> {
  $$TypeEfficacyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => column,
  );

  $$TypesTableTableAnnotationComposer get attackingTypeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableAnnotationComposer get defendingTypeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficacyTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypeEfficacyTableTable,
          TypeEfficacyRow,
          $$TypeEfficacyTableTableFilterComposer,
          $$TypeEfficacyTableTableOrderingComposer,
          $$TypeEfficacyTableTableAnnotationComposer,
          $$TypeEfficacyTableTableCreateCompanionBuilder,
          $$TypeEfficacyTableTableUpdateCompanionBuilder,
          (TypeEfficacyRow, $$TypeEfficacyTableTableReferences),
          TypeEfficacyRow,
          PrefetchHooks Function({bool attackingTypeId, bool defendingTypeId})
        > {
  $$TypeEfficacyTableTableTableManager(
    _$AppDatabase db,
    $TypeEfficacyTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypeEfficacyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypeEfficacyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypeEfficacyTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> attackingTypeId = const Value.absent(),
                Value<int> defendingTypeId = const Value.absent(),
                Value<int> damageFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficacyTableCompanion(
                attackingTypeId: attackingTypeId,
                defendingTypeId: defendingTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int attackingTypeId,
                required int defendingTypeId,
                required int damageFactor,
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficacyTableCompanion.insert(
                attackingTypeId: attackingTypeId,
                defendingTypeId: defendingTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypeEfficacyTableTable, TypeEfficacyRow>(table),
                  $$TypeEfficacyTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attackingTypeId = false, defendingTypeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (attackingTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.attackingTypeId,
                            referencedTable: $$TypeEfficacyTableTableReferences
                                ._attackingTypeIdTable(db),
                            referencedColumn: $$TypeEfficacyTableTableReferences
                                ._attackingTypeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (defendingTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defendingTypeId,
                            referencedTable: $$TypeEfficacyTableTableReferences
                                ._defendingTypeIdTable(db),
                            referencedColumn: $$TypeEfficacyTableTableReferences
                                ._defendingTypeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TypeEfficacyTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypeEfficacyTableTable,
      TypeEfficacyRow,
      $$TypeEfficacyTableTableFilterComposer,
      $$TypeEfficacyTableTableOrderingComposer,
      $$TypeEfficacyTableTableAnnotationComposer,
      $$TypeEfficacyTableTableCreateCompanionBuilder,
      $$TypeEfficacyTableTableUpdateCompanionBuilder,
      (TypeEfficacyRow, $$TypeEfficacyTableTableReferences),
      TypeEfficacyRow,
      PrefetchHooks Function({bool attackingTypeId, bool defendingTypeId})
    >;
typedef $$AbilitiesTableTableCreateCompanionBuilder =
    AbilitiesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> nameEs,
      Value<String?> effectEn,
      Value<String?> effectEs,
    });
typedef $$AbilitiesTableTableUpdateCompanionBuilder =
    AbilitiesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> nameEs,
      Value<String?> effectEn,
      Value<String?> effectEs,
    });

final class $$AbilitiesTableTableReferences
    extends BaseReferences<_$AppDatabase, $AbilitiesTableTable, AbilityRow> {
  $$AbilitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PokemonAbilitiesTableTable,
    List<PokemonAbilityRow>
  >
  _pokemonAbilitiesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonAbilitiesTable,
        aliasName: 'ability__id__pokemon_ability__ability_id',
      );

  $$PokemonAbilitiesTableTableProcessedTableManager
  get pokemonAbilitiesTableRefs {
    final manager = $$PokemonAbilitiesTableTableTableManager(
      $_db,
      $_db.pokemonAbilitiesTable,
    ).filter((f) => f.abilityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AbilitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonAbilitiesTableRefs(
    Expression<bool> Function($$PokemonAbilitiesTableTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.abilityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AbilitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AbilitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get effectEn =>
      $composableBuilder(column: $table.effectEn, builder: (column) => column);

  GeneratedColumn<String> get effectEs =>
      $composableBuilder(column: $table.effectEs, builder: (column) => column);

  Expression<T> pokemonAbilitiesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.abilityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AbilitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AbilitiesTableTable,
          AbilityRow,
          $$AbilitiesTableTableFilterComposer,
          $$AbilitiesTableTableOrderingComposer,
          $$AbilitiesTableTableAnnotationComposer,
          $$AbilitiesTableTableCreateCompanionBuilder,
          $$AbilitiesTableTableUpdateCompanionBuilder,
          (AbilityRow, $$AbilitiesTableTableReferences),
          AbilityRow,
          PrefetchHooks Function({bool pokemonAbilitiesTableRefs})
        > {
  $$AbilitiesTableTableTableManager(
    _$AppDatabase db,
    $AbilitiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbilitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbilitiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbilitiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
              }) => AbilitiesTableCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                effectEn: effectEn,
                effectEs: effectEs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
              }) => AbilitiesTableCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                effectEn: effectEn,
                effectEs: effectEs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AbilitiesTableTable, AbilityRow>(table),
                  $$AbilitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonAbilitiesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonAbilitiesTableRefs) db.pokemonAbilitiesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonAbilitiesTableRefs)
                    await $_getPrefetchedDataByColumns<
                      AbilityRow,
                      $AbilitiesTableTable,
                      PokemonAbilityRow,
                      $PokemonAbilitiesTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$AbilitiesTableTableReferences
                          ._pokemonAbilitiesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AbilitiesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonAbilitiesTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'ability_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AbilitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AbilitiesTableTable,
      AbilityRow,
      $$AbilitiesTableTableFilterComposer,
      $$AbilitiesTableTableOrderingComposer,
      $$AbilitiesTableTableAnnotationComposer,
      $$AbilitiesTableTableCreateCompanionBuilder,
      $$AbilitiesTableTableUpdateCompanionBuilder,
      (AbilityRow, $$AbilitiesTableTableReferences),
      AbilityRow,
      PrefetchHooks Function({bool pokemonAbilitiesTableRefs})
    >;
typedef $$PokemonAbilitiesTableTableCreateCompanionBuilder =
    PokemonAbilitiesTableCompanion Function({
      required int pokemonId,
      required int abilityId,
      required int slot,
      required bool isHidden,
      Value<int> rowid,
    });
typedef $$PokemonAbilitiesTableTableUpdateCompanionBuilder =
    PokemonAbilitiesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> abilityId,
      Value<int> slot,
      Value<bool> isHidden,
      Value<int> rowid,
    });

final class $$PokemonAbilitiesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonAbilitiesTableTable,
          PokemonAbilityRow
        > {
  $$PokemonAbilitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_ability__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AbilitiesTableTable _abilityIdTable(_$AppDatabase db) =>
      db.abilitiesTable.createAlias('pokemon_ability__ability_id__ability__id');

  $$AbilitiesTableTableProcessedTableManager get abilityId {
    final $_column = $_itemColumn<int>('ability_id')!;

    final manager = $$AbilitiesTableTableTableManager(
      $_db,
      $_db.abilitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_abilityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonAbilitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableFilterComposer get abilityId {
    final $$AbilitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableOrderingComposer get abilityId {
    final $$AbilitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableAnnotationComposer get abilityId {
    final $$AbilitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonAbilitiesTableTable,
          PokemonAbilityRow,
          $$PokemonAbilitiesTableTableFilterComposer,
          $$PokemonAbilitiesTableTableOrderingComposer,
          $$PokemonAbilitiesTableTableAnnotationComposer,
          $$PokemonAbilitiesTableTableCreateCompanionBuilder,
          $$PokemonAbilitiesTableTableUpdateCompanionBuilder,
          (PokemonAbilityRow, $$PokemonAbilitiesTableTableReferences),
          PokemonAbilityRow,
          PrefetchHooks Function({bool pokemonId, bool abilityId})
        > {
  $$PokemonAbilitiesTableTableTableManager(
    _$AppDatabase db,
    $PokemonAbilitiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonAbilitiesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonAbilitiesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> abilityId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesTableCompanion(
                pokemonId: pokemonId,
                abilityId: abilityId,
                slot: slot,
                isHidden: isHidden,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int abilityId,
                required int slot,
                required bool isHidden,
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesTableCompanion.insert(
                pokemonId: pokemonId,
                abilityId: abilityId,
                slot: slot,
                isHidden: isHidden,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonAbilitiesTableTable, PokemonAbilityRow>(
                    table,
                  ),
                  $$PokemonAbilitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, abilityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonAbilitiesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (abilityId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.abilityId,
                        referencedTable: $$PokemonAbilitiesTableTableReferences
                            ._abilityIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableTableReferences
                            ._abilityIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonAbilitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonAbilitiesTableTable,
      PokemonAbilityRow,
      $$PokemonAbilitiesTableTableFilterComposer,
      $$PokemonAbilitiesTableTableOrderingComposer,
      $$PokemonAbilitiesTableTableAnnotationComposer,
      $$PokemonAbilitiesTableTableCreateCompanionBuilder,
      $$PokemonAbilitiesTableTableUpdateCompanionBuilder,
      (PokemonAbilityRow, $$PokemonAbilitiesTableTableReferences),
      PokemonAbilityRow,
      PrefetchHooks Function({bool pokemonId, bool abilityId})
    >;
typedef $$VersionGroupsTableTableCreateCompanionBuilder =
    VersionGroupsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> generationId,
      Value<int?> sortOrder,
    });
typedef $$VersionGroupsTableTableUpdateCompanionBuilder =
    VersionGroupsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> generationId,
      Value<int?> sortOrder,
    });

final class $$VersionGroupsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VersionGroupsTableTable,
          VersionGroupRow
        > {
  $$VersionGroupsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GenerationsTableTable _generationIdTable(_$AppDatabase db) => db
      .generationsTable
      .createAlias('version_group__generation_id__generation__id');

  $$GenerationsTableTableProcessedTableManager? get generationId {
    final $_column = $_itemColumn<int>('generation_id');
    if ($_column == null) return null;
    final manager = $$GenerationsTableTableTableManager(
      $_db,
      $_db.generationsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_generationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PokemonMovesTableTable, List<PokemonMoveRow>>
  _pokemonMovesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonMovesTable,
        aliasName: 'version_group__id__pokemon_move__version_group_id',
      );

  $$PokemonMovesTableTableProcessedTableManager get pokemonMovesTableRefs {
    final manager = $$PokemonMovesTableTableTableManager(
      $_db,
      $_db.pokemonMovesTable,
    ).filter((f) => f.versionGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonMovesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VersionGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $VersionGroupsTableTable> {
  $$VersionGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$GenerationsTableTableFilterComposer get generationId {
    final $$GenerationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableFilterComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pokemonMovesTableRefs(
    Expression<bool> Function($$PokemonMovesTableTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMovesTable,
      getReferencedColumn: (t) => t.versionGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMovesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VersionGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VersionGroupsTableTable> {
  $$VersionGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$GenerationsTableTableOrderingComposer get generationId {
    final $$GenerationsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableOrderingComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VersionGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VersionGroupsTableTable> {
  $$VersionGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$GenerationsTableTableAnnotationComposer get generationId {
    final $$GenerationsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generationId,
      referencedTable: $db.generationsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenerationsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.generationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pokemonMovesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonMovesTable,
          getReferencedColumn: (t) => t.versionGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonMovesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonMovesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VersionGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VersionGroupsTableTable,
          VersionGroupRow,
          $$VersionGroupsTableTableFilterComposer,
          $$VersionGroupsTableTableOrderingComposer,
          $$VersionGroupsTableTableAnnotationComposer,
          $$VersionGroupsTableTableCreateCompanionBuilder,
          $$VersionGroupsTableTableUpdateCompanionBuilder,
          (VersionGroupRow, $$VersionGroupsTableTableReferences),
          VersionGroupRow,
          PrefetchHooks Function({
            bool generationId,
            bool pokemonMovesTableRefs,
          })
        > {
  $$VersionGroupsTableTableTableManager(
    _$AppDatabase db,
    $VersionGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersionGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersionGroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersionGroupsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> generationId = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
              }) => VersionGroupsTableCompanion(
                id: id,
                name: name,
                generationId: generationId,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> generationId = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
              }) => VersionGroupsTableCompanion.insert(
                id: id,
                name: name,
                generationId: generationId,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VersionGroupsTableTable, VersionGroupRow>(table),
                  $$VersionGroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({generationId = false, pokemonMovesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonMovesTableRefs) db.pokemonMovesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (generationId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.generationId,
                            referencedTable: $$VersionGroupsTableTableReferences
                                ._generationIdTable(db),
                            referencedColumn:
                                $$VersionGroupsTableTableReferences
                                    ._generationIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonMovesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          VersionGroupRow,
                          $VersionGroupsTableTable,
                          PokemonMoveRow,
                          $PokemonMovesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$VersionGroupsTableTableReferences
                              ._pokemonMovesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VersionGroupsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonMovesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'version_group_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VersionGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VersionGroupsTableTable,
      VersionGroupRow,
      $$VersionGroupsTableTableFilterComposer,
      $$VersionGroupsTableTableOrderingComposer,
      $$VersionGroupsTableTableAnnotationComposer,
      $$VersionGroupsTableTableCreateCompanionBuilder,
      $$VersionGroupsTableTableUpdateCompanionBuilder,
      (VersionGroupRow, $$VersionGroupsTableTableReferences),
      VersionGroupRow,
      PrefetchHooks Function({bool generationId, bool pokemonMovesTableRefs})
    >;
typedef $$MovesTableTableCreateCompanionBuilder = MovesTableCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> nameEs,
  Value<int?> typeId,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  Value<String?> damageClass,
});
typedef $$MovesTableTableUpdateCompanionBuilder = MovesTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> nameEs,
  Value<int?> typeId,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  Value<String?> damageClass,
});

final class $$MovesTableTableReferences
    extends BaseReferences<_$AppDatabase, $MovesTableTable, MoveRow> {
  $$MovesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TypesTableTable _typeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('move__type_id__type__id');

  $$TypesTableTableProcessedTableManager? get typeId {
    final $_column = $_itemColumn<int>('type_id');
    if ($_column == null) return null;
    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PokemonMovesTableTable, List<PokemonMoveRow>>
  _pokemonMovesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonMovesTable,
        aliasName: 'move__id__pokemon_move__move_id',
      );

  $$PokemonMovesTableTableProcessedTableManager get pokemonMovesTableRefs {
    final manager = $$PokemonMovesTableTableTableManager(
      $_db,
      $_db.pokemonMovesTable,
    ).filter((f) => f.moveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonMovesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MovesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => ColumnFilters(column),
  );

  $$TypesTableTableFilterComposer get typeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pokemonMovesTableRefs(
    Expression<bool> Function($$PokemonMovesTableTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMovesTable,
      getReferencedColumn: (t) => t.moveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMovesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypesTableTableOrderingComposer get typeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<int> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);

  GeneratedColumn<int> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get pp =>
      $composableBuilder(column: $table.pp, builder: (column) => column);

  GeneratedColumn<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => column,
  );

  $$TypesTableTableAnnotationComposer get typeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pokemonMovesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonMovesTable,
          getReferencedColumn: (t) => t.moveId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonMovesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonMovesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MovesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovesTableTable,
          MoveRow,
          $$MovesTableTableFilterComposer,
          $$MovesTableTableOrderingComposer,
          $$MovesTableTableAnnotationComposer,
          $$MovesTableTableCreateCompanionBuilder,
          $$MovesTableTableUpdateCompanionBuilder,
          (MoveRow, $$MovesTableTableReferences),
          MoveRow,
          PrefetchHooks Function({bool typeId, bool pokemonMovesTableRefs})
        > {
  $$MovesTableTableTableManager(_$AppDatabase db, $MovesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<int?> typeId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<String?> damageClass = const Value.absent(),
              }) => MovesTableCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                typeId: typeId,
                power: power,
                accuracy: accuracy,
                pp: pp,
                damageClass: damageClass,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameEs = const Value.absent(),
                Value<int?> typeId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<String?> damageClass = const Value.absent(),
              }) => MovesTableCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                typeId: typeId,
                power: power,
                accuracy: accuracy,
                pp: pp,
                damageClass: damageClass,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovesTableTable, MoveRow>(table),
                  $$MovesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({typeId = false, pokemonMovesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonMovesTableRefs) db.pokemonMovesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (typeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.typeId,
                            referencedTable: $$MovesTableTableReferences
                                ._typeIdTable(db),
                            referencedColumn: $$MovesTableTableReferences
                                ._typeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonMovesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          MoveRow,
                          $MovesTableTable,
                          PokemonMoveRow,
                          $PokemonMovesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$MovesTableTableReferences
                              ._pokemonMovesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MovesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonMovesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'move_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MovesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovesTableTable,
      MoveRow,
      $$MovesTableTableFilterComposer,
      $$MovesTableTableOrderingComposer,
      $$MovesTableTableAnnotationComposer,
      $$MovesTableTableCreateCompanionBuilder,
      $$MovesTableTableUpdateCompanionBuilder,
      (MoveRow, $$MovesTableTableReferences),
      MoveRow,
      PrefetchHooks Function({bool typeId, bool pokemonMovesTableRefs})
    >;
typedef $$PokemonMovesTableTableCreateCompanionBuilder =
    PokemonMovesTableCompanion Function({
      required int pokemonId,
      required int versionGroupId,
      required String learnMethod,
      required int moveId,
      required int levelLearned,
      Value<int> rowid,
    });
typedef $$PokemonMovesTableTableUpdateCompanionBuilder =
    PokemonMovesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> versionGroupId,
      Value<String> learnMethod,
      Value<int> moveId,
      Value<int> levelLearned,
      Value<int> rowid,
    });

final class $$PokemonMovesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonMovesTableTable, PokemonMoveRow> {
  $$PokemonMovesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_move__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VersionGroupsTableTable _versionGroupIdTable(_$AppDatabase db) => db
      .versionGroupsTable
      .createAlias('pokemon_move__version_group_id__version_group__id');

  $$VersionGroupsTableTableProcessedTableManager get versionGroupId {
    final $_column = $_itemColumn<int>('version_group_id')!;

    final manager = $$VersionGroupsTableTableTableManager(
      $_db,
      $_db.versionGroupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_versionGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MovesTableTable _moveIdTable(_$AppDatabase db) =>
      db.movesTable.createAlias('pokemon_move__move_id__move__id');

  $$MovesTableTableProcessedTableManager get moveId {
    final $_column = $_itemColumn<int>('move_id')!;

    final manager = $$MovesTableTableTableManager(
      $_db,
      $_db.movesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonMovesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get levelLearned => $composableBuilder(
    column: $table.levelLearned,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VersionGroupsTableTableFilterComposer get versionGroupId {
    final $$VersionGroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.versionGroupId,
      referencedTable: $db.versionGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionGroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.versionGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovesTableTableFilterComposer get moveId {
    final $$MovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableFilterComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get levelLearned => $composableBuilder(
    column: $table.levelLearned,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VersionGroupsTableTableOrderingComposer get versionGroupId {
    final $$VersionGroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.versionGroupId,
      referencedTable: $db.versionGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionGroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.versionGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovesTableTableOrderingComposer get moveId {
    final $$MovesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableOrderingComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get learnMethod => $composableBuilder(
    column: $table.learnMethod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get levelLearned => $composableBuilder(
    column: $table.levelLearned,
    builder: (column) => column,
  );

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VersionGroupsTableTableAnnotationComposer get versionGroupId {
    final $$VersionGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.versionGroupId,
          referencedTable: $db.versionGroupsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VersionGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.versionGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$MovesTableTableAnnotationComposer get moveId {
    final $$MovesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonMovesTableTable,
          PokemonMoveRow,
          $$PokemonMovesTableTableFilterComposer,
          $$PokemonMovesTableTableOrderingComposer,
          $$PokemonMovesTableTableAnnotationComposer,
          $$PokemonMovesTableTableCreateCompanionBuilder,
          $$PokemonMovesTableTableUpdateCompanionBuilder,
          (PokemonMoveRow, $$PokemonMovesTableTableReferences),
          PokemonMoveRow,
          PrefetchHooks Function({
            bool pokemonId,
            bool versionGroupId,
            bool moveId,
          })
        > {
  $$PokemonMovesTableTableTableManager(
    _$AppDatabase db,
    $PokemonMovesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonMovesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonMovesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonMovesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> versionGroupId = const Value.absent(),
                Value<String> learnMethod = const Value.absent(),
                Value<int> moveId = const Value.absent(),
                Value<int> levelLearned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesTableCompanion(
                pokemonId: pokemonId,
                versionGroupId: versionGroupId,
                learnMethod: learnMethod,
                moveId: moveId,
                levelLearned: levelLearned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int versionGroupId,
                required String learnMethod,
                required int moveId,
                required int levelLearned,
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesTableCompanion.insert(
                pokemonId: pokemonId,
                versionGroupId: versionGroupId,
                learnMethod: learnMethod,
                moveId: moveId,
                levelLearned: levelLearned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonMovesTableTable, PokemonMoveRow>(table),
                  $$PokemonMovesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({pokemonId = false, versionGroupId = false, moveId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (pokemonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pokemonId,
                            referencedTable: $$PokemonMovesTableTableReferences
                                ._pokemonIdTable(db),
                            referencedColumn: $$PokemonMovesTableTableReferences
                                ._pokemonIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (versionGroupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.versionGroupId,
                            referencedTable: $$PokemonMovesTableTableReferences
                                ._versionGroupIdTable(db),
                            referencedColumn: $$PokemonMovesTableTableReferences
                                ._versionGroupIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (moveId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.moveId,
                            referencedTable: $$PokemonMovesTableTableReferences
                                ._moveIdTable(db),
                            referencedColumn: $$PokemonMovesTableTableReferences
                                ._moveIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonMovesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonMovesTableTable,
      PokemonMoveRow,
      $$PokemonMovesTableTableFilterComposer,
      $$PokemonMovesTableTableOrderingComposer,
      $$PokemonMovesTableTableAnnotationComposer,
      $$PokemonMovesTableTableCreateCompanionBuilder,
      $$PokemonMovesTableTableUpdateCompanionBuilder,
      (PokemonMoveRow, $$PokemonMovesTableTableReferences),
      PokemonMoveRow,
      PrefetchHooks Function({bool pokemonId, bool versionGroupId, bool moveId})
    >;
typedef $$EvolutionsTableTableCreateCompanionBuilder =
    EvolutionsTableCompanion Function({
      Value<int> id,
      required int fromSpeciesId,
      required int toSpeciesId,
      required String triggerName,
      Value<int?> minLevel,
      Value<String?> item,
      Value<int?> minHappiness,
      Value<String?> timeOfDay,
    });
typedef $$EvolutionsTableTableUpdateCompanionBuilder =
    EvolutionsTableCompanion Function({
      Value<int> id,
      Value<int> fromSpeciesId,
      Value<int> toSpeciesId,
      Value<String> triggerName,
      Value<int?> minLevel,
      Value<String?> item,
      Value<int?> minHappiness,
      Value<String?> timeOfDay,
    });

final class $$EvolutionsTableTableReferences
    extends BaseReferences<_$AppDatabase, $EvolutionsTableTable, EvolutionRow> {
  $$EvolutionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpeciesTableTable _fromSpeciesIdTable(_$AppDatabase db) =>
      db.speciesTable.createAlias('evolution__from_species_id__species__id');

  $$SpeciesTableTableProcessedTableManager get fromSpeciesId {
    final $_column = $_itemColumn<int>('from_species_id')!;

    final manager = $$SpeciesTableTableTableManager(
      $_db,
      $_db.speciesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromSpeciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpeciesTableTable _toSpeciesIdTable(_$AppDatabase db) =>
      db.speciesTable.createAlias('evolution__to_species_id__species__id');

  $$SpeciesTableTableProcessedTableManager get toSpeciesId {
    final $_column = $_itemColumn<int>('to_species_id')!;

    final manager = $$SpeciesTableTableTableManager(
      $_db,
      $_db.speciesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toSpeciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvolutionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionsTableTable> {
  $$EvolutionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  $$SpeciesTableTableFilterComposer get fromSpeciesId {
    final $$SpeciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableFilterComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableTableFilterComposer get toSpeciesId {
    final $$SpeciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableFilterComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionsTableTable> {
  $$EvolutionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpeciesTableTableOrderingComposer get fromSpeciesId {
    final $$SpeciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableTableOrderingComposer get toSpeciesId {
    final $$SpeciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionsTableTable> {
  $$EvolutionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get triggerName => $composableBuilder(
    column: $table.triggerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minLevel =>
      $composableBuilder(column: $table.minLevel, builder: (column) => column);

  GeneratedColumn<String> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  GeneratedColumn<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  $$SpeciesTableTableAnnotationComposer get fromSpeciesId {
    final $$SpeciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableTableAnnotationComposer get toSpeciesId {
    final $$SpeciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSpeciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionsTableTable,
          EvolutionRow,
          $$EvolutionsTableTableFilterComposer,
          $$EvolutionsTableTableOrderingComposer,
          $$EvolutionsTableTableAnnotationComposer,
          $$EvolutionsTableTableCreateCompanionBuilder,
          $$EvolutionsTableTableUpdateCompanionBuilder,
          (EvolutionRow, $$EvolutionsTableTableReferences),
          EvolutionRow,
          PrefetchHooks Function({bool fromSpeciesId, bool toSpeciesId})
        > {
  $$EvolutionsTableTableTableManager(
    _$AppDatabase db,
    $EvolutionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvolutionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromSpeciesId = const Value.absent(),
                Value<int> toSpeciesId = const Value.absent(),
                Value<String> triggerName = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
              }) => EvolutionsTableCompanion(
                id: id,
                fromSpeciesId: fromSpeciesId,
                toSpeciesId: toSpeciesId,
                triggerName: triggerName,
                minLevel: minLevel,
                item: item,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromSpeciesId,
                required int toSpeciesId,
                required String triggerName,
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
              }) => EvolutionsTableCompanion.insert(
                id: id,
                fromSpeciesId: fromSpeciesId,
                toSpeciesId: toSpeciesId,
                triggerName: triggerName,
                minLevel: minLevel,
                item: item,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvolutionsTableTable, EvolutionRow>(table),
                  $$EvolutionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({fromSpeciesId = false, toSpeciesId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fromSpeciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.fromSpeciesId,
                            referencedTable: $$EvolutionsTableTableReferences
                                ._fromSpeciesIdTable(db),
                            referencedColumn: $$EvolutionsTableTableReferences
                                ._fromSpeciesIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (toSpeciesId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.toSpeciesId,
                            referencedTable: $$EvolutionsTableTableReferences
                                ._toSpeciesIdTable(db),
                            referencedColumn: $$EvolutionsTableTableReferences
                                ._toSpeciesIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EvolutionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionsTableTable,
      EvolutionRow,
      $$EvolutionsTableTableFilterComposer,
      $$EvolutionsTableTableOrderingComposer,
      $$EvolutionsTableTableAnnotationComposer,
      $$EvolutionsTableTableCreateCompanionBuilder,
      $$EvolutionsTableTableUpdateCompanionBuilder,
      (EvolutionRow, $$EvolutionsTableTableReferences),
      EvolutionRow,
      PrefetchHooks Function({bool fromSpeciesId, bool toSpeciesId})
    >;
typedef $$EggGroupsTableTableCreateCompanionBuilder =
    EggGroupsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> nameEs,
    });
typedef $$EggGroupsTableTableUpdateCompanionBuilder =
    EggGroupsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> nameEs,
    });

final class $$EggGroupsTableTableReferences
    extends BaseReferences<_$AppDatabase, $EggGroupsTableTable, EggGroupRow> {
  $$EggGroupsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SpeciesEggGroupsTableTable,
    List<SpeciesEggGroupRow>
  >
  _speciesEggGroupsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speciesEggGroupsTable,
        aliasName: 'egg_group__id__species_egg_group__egg_group_id',
      );

  $$SpeciesEggGroupsTableTableProcessedTableManager
  get speciesEggGroupsTableRefs {
    final manager = $$SpeciesEggGroupsTableTableTableManager(
      $_db,
      $_db.speciesEggGroupsTable,
    ).filter((f) => f.eggGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speciesEggGroupsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EggGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> speciesEggGroupsTableRefs(
    Expression<bool> Function($$SpeciesEggGroupsTableTableFilterComposer f) f,
  ) {
    final $$SpeciesEggGroupsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesEggGroupsTable,
          getReferencedColumn: (t) => t.eggGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesEggGroupsTableTableFilterComposer(
                $db: $db,
                $table: $db.speciesEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EggGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EggGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  Expression<T> speciesEggGroupsTableRefs<T extends Object>(
    Expression<T> Function($$SpeciesEggGroupsTableTableAnnotationComposer a) f,
  ) {
    final $$SpeciesEggGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesEggGroupsTable,
          getReferencedColumn: (t) => t.eggGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesEggGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EggGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EggGroupsTableTable,
          EggGroupRow,
          $$EggGroupsTableTableFilterComposer,
          $$EggGroupsTableTableOrderingComposer,
          $$EggGroupsTableTableAnnotationComposer,
          $$EggGroupsTableTableCreateCompanionBuilder,
          $$EggGroupsTableTableUpdateCompanionBuilder,
          (EggGroupRow, $$EggGroupsTableTableReferences),
          EggGroupRow,
          PrefetchHooks Function({bool speciesEggGroupsTableRefs})
        > {
  $$EggGroupsTableTableTableManager(
    _$AppDatabase db,
    $EggGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EggGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EggGroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EggGroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> nameEs = const Value.absent(),
          }) => EggGroupsTableCompanion(id: id, name: name, nameEs: nameEs),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameEs = const Value.absent(),
              }) => EggGroupsTableCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EggGroupsTableTable, EggGroupRow>(table),
                  $$EggGroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({speciesEggGroupsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (speciesEggGroupsTableRefs) db.speciesEggGroupsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (speciesEggGroupsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      EggGroupRow,
                      $EggGroupsTableTable,
                      SpeciesEggGroupRow,
                      $SpeciesEggGroupsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$EggGroupsTableTableReferences
                          ._speciesEggGroupsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EggGroupsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).speciesEggGroupsTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'egg_group_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EggGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EggGroupsTableTable,
      EggGroupRow,
      $$EggGroupsTableTableFilterComposer,
      $$EggGroupsTableTableOrderingComposer,
      $$EggGroupsTableTableAnnotationComposer,
      $$EggGroupsTableTableCreateCompanionBuilder,
      $$EggGroupsTableTableUpdateCompanionBuilder,
      (EggGroupRow, $$EggGroupsTableTableReferences),
      EggGroupRow,
      PrefetchHooks Function({bool speciesEggGroupsTableRefs})
    >;
typedef $$SpeciesEggGroupsTableTableCreateCompanionBuilder =
    SpeciesEggGroupsTableCompanion Function({
      required int speciesId,
      required int eggGroupId,
      Value<int> rowid,
    });
typedef $$SpeciesEggGroupsTableTableUpdateCompanionBuilder =
    SpeciesEggGroupsTableCompanion Function({
      Value<int> speciesId,
      Value<int> eggGroupId,
      Value<int> rowid,
    });

final class $$SpeciesEggGroupsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpeciesEggGroupsTableTable,
          SpeciesEggGroupRow
        > {
  $$SpeciesEggGroupsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpeciesTableTable _speciesIdTable(_$AppDatabase db) =>
      db.speciesTable.createAlias('species_egg_group__species_id__species__id');

  $$SpeciesTableTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$SpeciesTableTableTableManager(
      $_db,
      $_db.speciesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EggGroupsTableTable _eggGroupIdTable(_$AppDatabase db) => db
      .eggGroupsTable
      .createAlias('species_egg_group__egg_group_id__egg_group__id');

  $$EggGroupsTableTableProcessedTableManager get eggGroupId {
    final $_column = $_itemColumn<int>('egg_group_id')!;

    final manager = $$EggGroupsTableTableTableManager(
      $_db,
      $_db.eggGroupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eggGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpeciesEggGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesEggGroupsTableTable> {
  $$SpeciesEggGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SpeciesTableTableFilterComposer get speciesId {
    final $$SpeciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableFilterComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableFilterComposer get eggGroupId {
    final $$EggGroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesEggGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesEggGroupsTableTable> {
  $$SpeciesEggGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SpeciesTableTableOrderingComposer get speciesId {
    final $$SpeciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableOrderingComposer get eggGroupId {
    final $$EggGroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesEggGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesEggGroupsTableTable> {
  $$SpeciesEggGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SpeciesTableTableAnnotationComposer get speciesId {
    final $$SpeciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableAnnotationComposer get eggGroupId {
    final $$EggGroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesEggGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesEggGroupsTableTable,
          SpeciesEggGroupRow,
          $$SpeciesEggGroupsTableTableFilterComposer,
          $$SpeciesEggGroupsTableTableOrderingComposer,
          $$SpeciesEggGroupsTableTableAnnotationComposer,
          $$SpeciesEggGroupsTableTableCreateCompanionBuilder,
          $$SpeciesEggGroupsTableTableUpdateCompanionBuilder,
          (SpeciesEggGroupRow, $$SpeciesEggGroupsTableTableReferences),
          SpeciesEggGroupRow,
          PrefetchHooks Function({bool speciesId, bool eggGroupId})
        > {
  $$SpeciesEggGroupsTableTableTableManager(
    _$AppDatabase db,
    $SpeciesEggGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesEggGroupsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpeciesEggGroupsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpeciesEggGroupsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                Value<int> eggGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesEggGroupsTableCompanion(
                speciesId: speciesId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int speciesId,
                required int eggGroupId,
                Value<int> rowid = const Value.absent(),
              }) => SpeciesEggGroupsTableCompanion.insert(
                speciesId: speciesId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpeciesEggGroupsTableTable, SpeciesEggGroupRow>(
                    table,
                  ),
                  $$SpeciesEggGroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({speciesId = false, eggGroupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (speciesId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.speciesId,
                        referencedTable: $$SpeciesEggGroupsTableTableReferences
                            ._speciesIdTable(db),
                        referencedColumn: $$SpeciesEggGroupsTableTableReferences
                            ._speciesIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (eggGroupId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eggGroupId,
                        referencedTable: $$SpeciesEggGroupsTableTableReferences
                            ._eggGroupIdTable(db),
                        referencedColumn: $$SpeciesEggGroupsTableTableReferences
                            ._eggGroupIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SpeciesEggGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesEggGroupsTableTable,
      SpeciesEggGroupRow,
      $$SpeciesEggGroupsTableTableFilterComposer,
      $$SpeciesEggGroupsTableTableOrderingComposer,
      $$SpeciesEggGroupsTableTableAnnotationComposer,
      $$SpeciesEggGroupsTableTableCreateCompanionBuilder,
      $$SpeciesEggGroupsTableTableUpdateCompanionBuilder,
      (SpeciesEggGroupRow, $$SpeciesEggGroupsTableTableReferences),
      SpeciesEggGroupRow,
      PrefetchHooks Function({bool speciesId, bool eggGroupId})
    >;
typedef $$FavoritesTableTableCreateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> pokemonId,
      Value<DateTime> createdAt,
    });
typedef $$FavoritesTableTableUpdateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> pokemonId,
      Value<DateTime> createdAt,
    });

final class $$FavoritesTableTableReferences
    extends BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteRow> {
  $$FavoritesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('favorite__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTableTable,
          FavoriteRow,
          $$FavoritesTableTableFilterComposer,
          $$FavoritesTableTableOrderingComposer,
          $$FavoritesTableTableAnnotationComposer,
          $$FavoritesTableTableCreateCompanionBuilder,
          $$FavoritesTableTableUpdateCompanionBuilder,
          (FavoriteRow, $$FavoritesTableTableReferences),
          FavoriteRow,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$FavoritesTableTableTableManager(
    _$AppDatabase db,
    $FavoritesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion.insert(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTableTable, FavoriteRow>(table),
                  $$FavoritesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$FavoritesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$FavoritesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoritesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTableTable,
      FavoriteRow,
      $$FavoritesTableTableFilterComposer,
      $$FavoritesTableTableOrderingComposer,
      $$FavoritesTableTableAnnotationComposer,
      $$FavoritesTableTableCreateCompanionBuilder,
      $$FavoritesTableTableUpdateCompanionBuilder,
      (FavoriteRow, $$FavoritesTableTableReferences),
      FavoriteRow,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$TriviaResultsTableTableCreateCompanionBuilder =
    TriviaResultsTableCompanion Function({
      Value<int> id,
      required int score,
      required int correctAnswers,
      required int totalQuestions,
      required DateTime playedAt,
    });
typedef $$TriviaResultsTableTableUpdateCompanionBuilder =
    TriviaResultsTableCompanion Function({
      Value<int> id,
      Value<int> score,
      Value<int> correctAnswers,
      Value<int> totalQuestions,
      Value<DateTime> playedAt,
    });

final class $$TriviaResultsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TriviaResultsTableTable,
          TriviaResultRow
        > {
  $$TriviaResultsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TriviaAnswersTableTable, List<TriviaAnswerRow>>
  _triviaAnswersTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.triviaAnswersTable,
        aliasName: 'trivia_result__id__trivia_answer__trivia_result_id',
      );

  $$TriviaAnswersTableTableProcessedTableManager get triviaAnswersTableRefs {
    final manager = $$TriviaAnswersTableTableTableManager(
      $_db,
      $_db.triviaAnswersTable,
    ).filter((f) => f.triviaResultId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _triviaAnswersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TriviaResultsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> triviaAnswersTableRefs(
    Expression<bool> Function($$TriviaAnswersTableTableFilterComposer f) f,
  ) {
    final $$TriviaAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswersTable,
      getReferencedColumn: (t) => t.triviaResultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableTableFilterComposer(
            $db: $db,
            $table: $db.triviaAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriviaResultsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriviaResultsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  Expression<T> triviaAnswersTableRefs<T extends Object>(
    Expression<T> Function($$TriviaAnswersTableTableAnnotationComposer a) f,
  ) {
    final $$TriviaAnswersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.triviaAnswersTable,
          getReferencedColumn: (t) => t.triviaResultId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TriviaAnswersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.triviaAnswersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TriviaResultsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaResultsTableTable,
          TriviaResultRow,
          $$TriviaResultsTableTableFilterComposer,
          $$TriviaResultsTableTableOrderingComposer,
          $$TriviaResultsTableTableAnnotationComposer,
          $$TriviaResultsTableTableCreateCompanionBuilder,
          $$TriviaResultsTableTableUpdateCompanionBuilder,
          (TriviaResultRow, $$TriviaResultsTableTableReferences),
          TriviaResultRow,
          PrefetchHooks Function({bool triviaAnswersTableRefs})
        > {
  $$TriviaResultsTableTableTableManager(
    _$AppDatabase db,
    $TriviaResultsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaResultsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaResultsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaResultsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaResultsTableCompanion(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int score,
                required int correctAnswers,
                required int totalQuestions,
                required DateTime playedAt,
              }) => TriviaResultsTableCompanion.insert(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaResultsTableTable, TriviaResultRow>(table),
                  $$TriviaResultsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triviaAnswersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (triviaAnswersTableRefs) db.triviaAnswersTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (triviaAnswersTableRefs)
                    await $_getPrefetchedDataByColumns<
                      TriviaResultRow,
                      $TriviaResultsTableTable,
                      TriviaAnswerRow,
                      $TriviaAnswersTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$TriviaResultsTableTableReferences
                          ._triviaAnswersTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TriviaResultsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).triviaAnswersTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'trivia_result_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TriviaResultsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaResultsTableTable,
      TriviaResultRow,
      $$TriviaResultsTableTableFilterComposer,
      $$TriviaResultsTableTableOrderingComposer,
      $$TriviaResultsTableTableAnnotationComposer,
      $$TriviaResultsTableTableCreateCompanionBuilder,
      $$TriviaResultsTableTableUpdateCompanionBuilder,
      (TriviaResultRow, $$TriviaResultsTableTableReferences),
      TriviaResultRow,
      PrefetchHooks Function({bool triviaAnswersTableRefs})
    >;
typedef $$TriviaAnswersTableTableCreateCompanionBuilder =
    TriviaAnswersTableCompanion Function({
      Value<int> id,
      required int triviaResultId,
      required int pokemonId,
      required bool correct,
    });
typedef $$TriviaAnswersTableTableUpdateCompanionBuilder =
    TriviaAnswersTableCompanion Function({
      Value<int> id,
      Value<int> triviaResultId,
      Value<int> pokemonId,
      Value<bool> correct,
    });

final class $$TriviaAnswersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TriviaAnswersTableTable,
          TriviaAnswerRow
        > {
  $$TriviaAnswersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TriviaResultsTableTable _triviaResultIdTable(_$AppDatabase db) => db
      .triviaResultsTable
      .createAlias('trivia_answer__trivia_result_id__trivia_result__id');

  $$TriviaResultsTableTableProcessedTableManager get triviaResultId {
    final $_column = $_itemColumn<int>('trivia_result_id')!;

    final manager = $$TriviaResultsTableTableTableManager(
      $_db,
      $_db.triviaResultsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_triviaResultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TriviaAnswersTableTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  $$TriviaResultsTableTableFilterComposer get triviaResultId {
    final $$TriviaResultsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triviaResultId,
      referencedTable: $db.triviaResultsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableTableFilterComposer(
            $db: $db,
            $table: $db.triviaResultsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriviaAnswersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  $$TriviaResultsTableTableOrderingComposer get triviaResultId {
    final $$TriviaResultsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triviaResultId,
      referencedTable: $db.triviaResultsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableTableOrderingComposer(
            $db: $db,
            $table: $db.triviaResultsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriviaAnswersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<bool> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  $$TriviaResultsTableTableAnnotationComposer get triviaResultId {
    final $$TriviaResultsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.triviaResultId,
          referencedTable: $db.triviaResultsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TriviaResultsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.triviaResultsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TriviaAnswersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaAnswersTableTable,
          TriviaAnswerRow,
          $$TriviaAnswersTableTableFilterComposer,
          $$TriviaAnswersTableTableOrderingComposer,
          $$TriviaAnswersTableTableAnnotationComposer,
          $$TriviaAnswersTableTableCreateCompanionBuilder,
          $$TriviaAnswersTableTableUpdateCompanionBuilder,
          (TriviaAnswerRow, $$TriviaAnswersTableTableReferences),
          TriviaAnswerRow,
          PrefetchHooks Function({bool triviaResultId})
        > {
  $$TriviaAnswersTableTableTableManager(
    _$AppDatabase db,
    $TriviaAnswersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaAnswersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaAnswersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaAnswersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> triviaResultId = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<bool> correct = const Value.absent(),
              }) => TriviaAnswersTableCompanion(
                id: id,
                triviaResultId: triviaResultId,
                pokemonId: pokemonId,
                correct: correct,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int triviaResultId,
                required int pokemonId,
                required bool correct,
              }) => TriviaAnswersTableCompanion.insert(
                id: id,
                triviaResultId: triviaResultId,
                pokemonId: pokemonId,
                correct: correct,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaAnswersTableTable, TriviaAnswerRow>(table),
                  $$TriviaAnswersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triviaResultId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (triviaResultId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.triviaResultId,
                        referencedTable: $$TriviaAnswersTableTableReferences
                            ._triviaResultIdTable(db),
                        referencedColumn: $$TriviaAnswersTableTableReferences
                            ._triviaResultIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TriviaAnswersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaAnswersTableTable,
      TriviaAnswerRow,
      $$TriviaAnswersTableTableFilterComposer,
      $$TriviaAnswersTableTableOrderingComposer,
      $$TriviaAnswersTableTableAnnotationComposer,
      $$TriviaAnswersTableTableCreateCompanionBuilder,
      $$TriviaAnswersTableTableUpdateCompanionBuilder,
      (TriviaAnswerRow, $$TriviaAnswersTableTableReferences),
      TriviaAnswerRow,
      PrefetchHooks Function({bool triviaResultId})
    >;
typedef $$AchievementsTableTableCreateCompanionBuilder =
    AchievementsTableCompanion Function({
      required String achievementKey,
      required DateTime unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableTableUpdateCompanionBuilder =
    AchievementsTableCompanion Function({
      Value<String> achievementKey,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get achievementKey => $composableBuilder(
    column: $table.achievementKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get achievementKey => $composableBuilder(
    column: $table.achievementKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get achievementKey => $composableBuilder(
    column: $table.achievementKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTableTable,
          AchievementRow,
          $$AchievementsTableTableFilterComposer,
          $$AchievementsTableTableOrderingComposer,
          $$AchievementsTableTableAnnotationComposer,
          $$AchievementsTableTableCreateCompanionBuilder,
          $$AchievementsTableTableUpdateCompanionBuilder,
          (
            AchievementRow,
            BaseReferences<
              _$AppDatabase,
              $AchievementsTableTable,
              AchievementRow
            >,
          ),
          AchievementRow,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableTableManager(
    _$AppDatabase db,
    $AchievementsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> achievementKey = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion(
                achievementKey: achievementKey,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String achievementKey,
                required DateTime unlockedAt,
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion.insert(
                achievementKey: achievementKey,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementsTableTable, AchievementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AchievementsTableTable,
                    AchievementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTableTable,
      AchievementRow,
      $$AchievementsTableTableFilterComposer,
      $$AchievementsTableTableOrderingComposer,
      $$AchievementsTableTableAnnotationComposer,
      $$AchievementsTableTableCreateCompanionBuilder,
      $$AchievementsTableTableUpdateCompanionBuilder,
      (
        AchievementRow,
        BaseReferences<_$AppDatabase, $AchievementsTableTable, AchievementRow>,
      ),
      AchievementRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableTableCreateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      required String resourceKey,
      required SyncStatusDb status,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> nextOffset,
      Value<int?> totalCount,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableTableUpdateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      Value<String> resourceKey,
      Value<SyncStatusDb> status,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> nextOffset,
      Value<int?> totalCount,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$SyncMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatusDb, SyncStatusDb, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncStatusDb, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTableTable,
          SyncMetadataRow,
          $$SyncMetadataTableTableFilterComposer,
          $$SyncMetadataTableTableOrderingComposer,
          $$SyncMetadataTableTableAnnotationComposer,
          $$SyncMetadataTableTableCreateCompanionBuilder,
          $$SyncMetadataTableTableUpdateCompanionBuilder,
          (
            SyncMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $SyncMetadataTableTable,
              SyncMetadataRow
            >,
          ),
          SyncMetadataRow,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableTableManager(
    _$AppDatabase db,
    $SyncMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> resourceKey = const Value.absent(),
                Value<SyncStatusDb> status = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> nextOffset = const Value.absent(),
                Value<int?> totalCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion(
                resourceKey: resourceKey,
                status: status,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                nextOffset: nextOffset,
                totalCount: totalCount,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resourceKey,
                required SyncStatusDb status,
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> nextOffset = const Value.absent(),
                Value<int?> totalCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion.insert(
                resourceKey: resourceKey,
                status: status,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                nextOffset: nextOffset,
                totalCount: totalCount,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetadataTableTable, SyncMetadataRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncMetadataTableTable,
                    SyncMetadataRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTableTable,
      SyncMetadataRow,
      $$SyncMetadataTableTableFilterComposer,
      $$SyncMetadataTableTableOrderingComposer,
      $$SyncMetadataTableTableAnnotationComposer,
      $$SyncMetadataTableTableCreateCompanionBuilder,
      $$SyncMetadataTableTableUpdateCompanionBuilder,
      (
        SyncMetadataRow,
        BaseReferences<_$AppDatabase, $SyncMetadataTableTable, SyncMetadataRow>,
      ),
      SyncMetadataRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GenerationsTableTableTableManager get generationsTable =>
      $$GenerationsTableTableTableManager(_db, _db.generationsTable);
  $$SpeciesTableTableTableManager get speciesTable =>
      $$SpeciesTableTableTableManager(_db, _db.speciesTable);
  $$PokemonTableTableTableManager get pokemonTable =>
      $$PokemonTableTableTableManager(_db, _db.pokemonTable);
  $$TypesTableTableTableManager get typesTable =>
      $$TypesTableTableTableManager(_db, _db.typesTable);
  $$PokemonTypesTableTableTableManager get pokemonTypesTable =>
      $$PokemonTypesTableTableTableManager(_db, _db.pokemonTypesTable);
  $$PokemonFormsTableTableTableManager get pokemonFormsTable =>
      $$PokemonFormsTableTableTableManager(_db, _db.pokemonFormsTable);
  $$PokemonFormTypesTableTableTableManager get pokemonFormTypesTable =>
      $$PokemonFormTypesTableTableTableManager(_db, _db.pokemonFormTypesTable);
  $$TypeEfficacyTableTableTableManager get typeEfficacyTable =>
      $$TypeEfficacyTableTableTableManager(_db, _db.typeEfficacyTable);
  $$AbilitiesTableTableTableManager get abilitiesTable =>
      $$AbilitiesTableTableTableManager(_db, _db.abilitiesTable);
  $$PokemonAbilitiesTableTableTableManager get pokemonAbilitiesTable =>
      $$PokemonAbilitiesTableTableTableManager(_db, _db.pokemonAbilitiesTable);
  $$VersionGroupsTableTableTableManager get versionGroupsTable =>
      $$VersionGroupsTableTableTableManager(_db, _db.versionGroupsTable);
  $$MovesTableTableTableManager get movesTable =>
      $$MovesTableTableTableManager(_db, _db.movesTable);
  $$PokemonMovesTableTableTableManager get pokemonMovesTable =>
      $$PokemonMovesTableTableTableManager(_db, _db.pokemonMovesTable);
  $$EvolutionsTableTableTableManager get evolutionsTable =>
      $$EvolutionsTableTableTableManager(_db, _db.evolutionsTable);
  $$EggGroupsTableTableTableManager get eggGroupsTable =>
      $$EggGroupsTableTableTableManager(_db, _db.eggGroupsTable);
  $$SpeciesEggGroupsTableTableTableManager get speciesEggGroupsTable =>
      $$SpeciesEggGroupsTableTableTableManager(_db, _db.speciesEggGroupsTable);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$TriviaResultsTableTableTableManager get triviaResultsTable =>
      $$TriviaResultsTableTableTableManager(_db, _db.triviaResultsTable);
  $$TriviaAnswersTableTableTableManager get triviaAnswersTable =>
      $$TriviaAnswersTableTableTableManager(_db, _db.triviaAnswersTable);
  $$AchievementsTableTableTableManager get achievementsTable =>
      $$AchievementsTableTableTableManager(_db, _db.achievementsTable);
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(_db, _db.syncMetadataTable);
}
