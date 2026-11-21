import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner.dart';

class PokedexScaffold extends StatelessWidget {
  const PokedexScaffold({
    super.key,
    this.title,
    this.appBar,
    required this.body,
  }) : assert(title != null || appBar != null);

  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      appBar:
          appBar ??
          AppBar(
            backgroundColor: const Color(0xFF1F2B42),
            foregroundColor: Colors.white,
            title: Text(title!),
          ),
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
