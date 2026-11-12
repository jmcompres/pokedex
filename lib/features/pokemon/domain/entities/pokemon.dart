import 'package:equatable/equatable.dart';

import 'base_stats.dart';
import 'pokemon_images.dart';
import 'pokemon_type.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.id,
    required this.speciesId,
    required this.name,
    required this.speciesName,
    required this.isDefault,
    required this.types,
    required this.baseStats,
    required this.images,
  });

  final int id;
  final int speciesId;
  final String name;
  final String speciesName;
  final bool isDefault;
  final List<PokemonType> types;
  final BaseStats baseStats;
  final PokemonImages images;

  int get nationalDexNumber => speciesId;

  @override
  List<Object?> get props => [
    id,
    speciesId,
    name,
    speciesName,
    isDefault,
    types,
    baseStats,
    images,
  ];
}