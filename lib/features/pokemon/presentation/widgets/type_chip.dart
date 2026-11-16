import 'package:material_ui/material_ui.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_type.dart';

typedef _ChipColors = ({Color text, Color border, Color background});

const _palette = <String, _ChipColors>{
  'grass': (text: Color(0xFF1F5C35), border: Color(0xFFABD8B7), background: Color(0xFFD9F2DF)),
  'poison': (text: Color(0xFF6C356D), border: Color(0xFFD2ADD2), background: Color(0xFFF0DCEF)),
  'fire': (text: Color(0xFF81341E), border: Color(0xFFEDB6A1), background: Color(0xFFFBE0D5)),
  'flying': (text: Color(0xFF385575), border: Color(0xFFB2C8DF), background: Color(0xFFE0EAF5)),
  'water': (text: Color(0xFF24568A), border: Color(0xFFA7CAEC), background: Color(0xFFD8EAFB)),
  'bug': (text: Color(0xFF47591E), border: Color(0xFFC5D29C), background: Color(0xFFE5EDC7)),
  'normal': (text: Color(0xFF4F5157), border: Color(0xFFCFD0D3), background: Color(0xFFECECEE)),
  'electric': (text: Color(0xFF6B5310), border: Color(0xFFE6D18A), background: Color(0xFFFBF0C9)),
  'fighting': (text: Color(0xFF7A2E2A), border: Color(0xFFE3AEA9), background: Color(0xFFF7DCD9)),
  'ground': (text: Color(0xFF6B4A22), border: Color(0xFFDCC19A), background: Color(0xFFF3E6D2)),
  'rock': (text: Color(0xFF5C5233), border: Color(0xFFCFC4A3), background: Color(0xFFECE6D3)),
  'ghost': (text: Color(0xFF4A3D6E), border: Color(0xFFC2B6DD), background: Color(0xFFE6E0F3)),
  'steel': (text: Color(0xFF3F5460), border: Color(0xFFB9C7CF), background: Color(0xFFE3EAEE)),
  'psychic': (text: Color(0xFF84304F), border: Color(0xFFEDB0C6), background: Color(0xFFFADBE6)),
  'ice': (text: Color(0xFF1F5F66), border: Color(0xFFA6D9DC), background: Color(0xFFD9F2F3)),
  'dragon': (text: Color(0xFF3B3F8A), border: Color(0xFFB5B8E6), background: Color(0xFFE1E2F7)),
  'dark': (text: Color(0xFF3D3A3A), border: Color(0xFFC4BFBC), background: Color(0xFFE6E2DF)),
  'fairy': (text: Color(0xFF7D3768), border: Color(0xFFE9B3D6), background: Color(0xFFF8DEEE)),
};

class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type});

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    final colors = _palette[type.name] ?? _palette['normal']!;
    final label = type.nameEs ?? type.name;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border.all(color: colors.border),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Text(
        '${label[0].toUpperCase()}${label.substring(1)}',
        style: TextStyle(
          color: colors.text,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}