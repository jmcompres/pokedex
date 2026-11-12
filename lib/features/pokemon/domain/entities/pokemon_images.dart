import 'package:equatable/equatable.dart';

class PokemonImages extends Equatable {
  const PokemonImages({
    this.artworkUrl,
    this.artworkShinyUrl,
    this.spriteUrl,
    this.spriteShinyUrl,
    this.localArtworkPath,
  });

  final String? artworkUrl;
  final String? artworkShinyUrl;
  final String? spriteUrl;
  final String? spriteShinyUrl;

  final String? localArtworkPath;

  String? get preferredUrl => artworkUrl ?? spriteUrl;
  String? get preferredShinyUrl => artworkShinyUrl ?? spriteShinyUrl;
  bool get hasShiny => preferredShinyUrl != null;

  @override
  List<Object?> get props => [
    artworkUrl,
    artworkShinyUrl,
    spriteUrl,
    spriteShinyUrl,
    localArtworkPath,
  ];
}