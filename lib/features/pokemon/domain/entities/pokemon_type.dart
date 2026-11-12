import 'package:equatable/equatable.dart';

class PokemonType extends Equatable {
  const PokemonType({required this.id, required this.name, this.nameEs});

  final int id;
  final String name;
  final String? nameEs;

  @override
  List<Object?> get props => [id, name, nameEs];
}