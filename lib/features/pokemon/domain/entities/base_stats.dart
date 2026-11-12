import 'package:equatable/equatable.dart';

class BaseStats extends Equatable {
  const BaseStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  int get total =>
      hp + attack + defense + specialAttack + specialDefense + speed;

  @override
  List<Object?> get props =>
      [hp, attack, defense, specialAttack, specialDefense, speed];
}