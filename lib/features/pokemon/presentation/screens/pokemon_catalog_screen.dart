import 'dart:math' show pi;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/errors/failures.dart';
import 'package:pokedex/core/presentation/pokedex_scaffold.dart';
import 'package:pokedex/core/router/app_routes.dart';
import 'package:pokedex/core/sync/domain/sync_status.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/controllers/catalog_controller.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_tile.dart';

const _navy = Color(0xFF1F2B42);
const _buttonBlue = Color(0xFF344E7D);
const _skeletonGrey = Color(0xFFEAECF0);
const _listPadding = EdgeInsets.fromLTRB(12, 20, 12, 34);

typedef _Tone = ({Color foreground, Color background, Color label});

const _emptyTone = (
  foreground: Color(0xFF51647F),
  background: Color(0xFFE7EDF6),
  label: Color(0xFF506785),
);

const _errorTone = (
  foreground: Color(0xFF805044),
  background: Color(0xFFF5E4DF),
  label: Color(0xFF8C4D3D),
);

class PokemonCatalogScreen extends ConsumerWidget {
  const PokemonCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(catalogStateProvider);
    final retryButton = _RetryButton(onPressed: () => refreshCatalog(ref));

    return PokedexScaffold(
      appBar: _buildAppBar(),
      body: switch (state) {
        CatalogLoading() => const _SkeletonList(),
        CatalogLoaded(:final pokemon, :final syncing) => _CatalogList(
          pokemon: pokemon,
          syncing: syncing,
          onRefresh: () async => refreshCatalog(ref),
        ),
        CatalogEmpty(offline: true) => _MessageView(
          tone: _emptyTone,
          icon: Icons.cloud_off,
          withPokeball: true,
          label: 'Catálogo aún no descargado',
          title: 'Conéctate a Internet para descargar el catálogo',
          message:
              'Cuando recuperes la conexión, la descarga comenzará '
              'automáticamente. Después podrás consultarlo sin conexión.',
          action: _WaitingForConnection(onRetry: () => refreshCatalog(ref)),
        ),
        CatalogEmpty() => _MessageView(
          tone: _emptyTone,
          icon: Icons.inbox_outlined,
          label: 'Catálogo vacío',
          title: 'Todavía no hay Pokémon guardados',
          message: 'Vuelve a intentar la descarga del catálogo.',
          action: retryButton,
        ),
        CatalogError(:final failure) => _MessageView(
          tone: _errorTone,
          icon: Icons.cloud_off,
          label: 'No se pudo cargar',
          title: 'No podemos acceder al catálogo',
          message:
              '${_failureMessage(failure)} '
              'No se ha descargado ningún dato todavía.',
          action: retryButton,
        ),
      },
    );
  }
}

AppBar _buildAppBar() => AppBar(
  toolbarHeight: 84,
  backgroundColor: _navy,
  foregroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
  scrolledUnderElevation: 0,
  titleSpacing: 16,
  title: const Row(
    children: [
      _Pokeball(size: 39, dark: Color(0xFF121B2D)),
      SizedBox(width: 12),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'POKÉDEX NACIONAL',
            style: TextStyle(
              color: Color(0xFFBFCBED),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Catálogo Pokémon',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    ],
  ),
);

class _CatalogList extends StatelessWidget {
  const _CatalogList({
    required this.pokemon,
    required this.syncing,
    required this.onRefresh,
  });

  final List<Pokemon> pokemon;
  final SyncInProgress? syncing;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final syncing = this.syncing;

    return Column(
      children: [
        if (syncing != null) _SyncBanner(syncing: syncing),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              padding: _listPadding,
              itemCount: pokemon.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? _ListHeading(
                      count: pokemon.length,
                      loading: syncing != null,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: PokemonListTile(
                        pokemon: pokemon[index - 1],
                        onTap: () => context.go(
                          AppRoutes.catalogDetail(pokemon[index - 1].id),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ListHeading extends StatelessWidget {
  const _ListHeading({required this.count, required this.loading});

  final int count;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'POKÉDEX NACIONAL',
                  style: TextStyle(
                    color: Color(0xFF687288),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  'Especies',
                  style: TextStyle(
                    color: Color(0xFF222936),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.7,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xFFECEFF4),
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
            child: Text(
              '${_thousands(count)} ${loading ? 'cargadas' : 'especies'}',
              style: const TextStyle(
                color: Color(0xFF4F5A70),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncBanner extends StatelessWidget {
  const _SyncBanner({required this.syncing});

  final SyncInProgress syncing;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF274C7F);
    final total = syncing.total;

    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 9),
        decoration: const BoxDecoration(
          color: Color(0xFFF1F6FF),
          border: Border(bottom: BorderSide(color: Color(0xFFD5E1F5))),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.sync, size: 18, color: color),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Sincronizando catálogo',
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (total != null)
                  Text(
                    '${_thousands(syncing.synced)} de ${_thousands(total)}',
                    style: const TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: syncing.progress,
              minHeight: 3,
              color: const Color(0xFF4F73A9),
              backgroundColor: const Color(0xFFD7E2F5),
              borderRadius: const BorderRadius.all(Radius.circular(99)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cargando catálogo',
      child: ExcludeSemantics(
        child: ListView.builder(
          padding: _listPadding,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 9),
            child: _SkeletonRow(),
          ),
        ),
      ),
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.fromLTRB(12, 10, 18, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E4E9)),
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      child: Row(
        children: [
          _bar(68, 68, radius: 15),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bar(34, 6),
              const SizedBox(height: 8),
              _bar(115, 14),
              const SizedBox(height: 8),
              _bar(76, 19),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _bar(double width, double height, {double radius = 999}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: _skeletonGrey,
    borderRadius: BorderRadius.circular(radius),
  ),
);

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.tone,
    required this.icon,
    required this.label,
    required this.title,
    required this.message,
    required this.action,
    this.withPokeball = false,
  });

  final _Tone tone;
  final IconData icon;
  final String label;
  final String title;
  final String message;
  final Widget action;
  final bool withPokeball;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 42),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Illustration(tone: tone, icon: icon, withPokeball: withPokeball),
              const SizedBox(height: 26),
              Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: tone.label,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF252B35),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.18,
                  letterSpacing: -0.55,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF636B78),
                  fontSize: 12,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 22),
              action,
            ],
          ),
        ),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration({
    required this.tone,
    required this.icon,
    required this.withPokeball,
  });

  final _Tone tone;
  final IconData icon;
  final bool withPokeball;

  @override
  Widget build(BuildContext context) {
    const tilt = 4 * pi / 180;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.rotate(
          angle: -tilt,
          child: Container(
            width: 108,
            height: 108,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.background,
              borderRadius: const BorderRadius.all(Radius.circular(34)),
            ),
            child: Transform.rotate(
              angle: tilt,
              child: Icon(icon, size: 36, color: tone.foreground),
            ),
          ),
        ),
        if (withPokeball)
          Positioned(
            right: -8,
            bottom: -8,
            child: _Pokeball(size: 42, dark: tone.foreground, outlined: true),
          ),
      ],
    );
  }
}

class _WaitingForConnection extends StatelessWidget {
  const _WaitingForConnection({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: const BoxDecoration(
            color: Color(0xFFECEEF2),
            borderRadius: BorderRadius.all(Radius.circular(999)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 18, color: Color(0xFF555E6D)),
              SizedBox(width: 7),
              Text(
                'Esperando conexión',
                style: TextStyle(
                  color: Color(0xFF555E6D),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: onRetry, child: const Text('Reintentar ahora')),
      ],
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _buttonBlue,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
      icon: const Icon(Icons.refresh, size: 19),
      label: const Text('Reintentar'),
    );
  }
}

class _Pokeball extends StatelessWidget {
  const _Pokeball({
    required this.size,
    required this.dark,
    this.outlined = false,
  });

  final double size;
  final Color dark;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFEC7777);
    final center = size * 0.4;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: outlined ? Border.all(color: dark, width: 4) : null,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [red, red, dark, dark, Colors.white, Colors.white],
          stops: const [0, 0.45, 0.45, 0.55, 0.55, 1],
        ),
      ),
      child: Container(
        width: center,
        height: center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: dark, width: 3),
        ),
      ),
    );
  }
}

String _thousands(int n) =>
    n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');

String _failureMessage(Failure failure) => switch (failure) {
  NetworkFailure() => 'No hay conexión a Internet.',
  TimeoutFailure() => 'PokeAPI tardó demasiado en responder.',
  RateLimitFailure() =>
    'Se hicieron demasiadas solicitudes. Espera un momento.',
  ServerFailure() ||
  GraphQLFailure() => 'PokeAPI no está respondiendo correctamente.',
  ValidationFailure() => 'PokeAPI envió datos incompletos.',
  CacheFailure() => 'No se pudo leer el catálogo guardado.',
};
