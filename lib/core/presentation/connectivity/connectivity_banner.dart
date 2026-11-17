import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/presentation/connectivity/connectivity_banner_state.dart';

class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(connectivityBannerStateProvider);
    final copy = _BannerCopy.fromState(state);
    final style = _BannerVisualStyle.fromMode(state.mode);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: Semantics(
        key: ValueKey<ConnectivityBannerMode>(state.mode),
        container: true,
        liveRegion: true,
        label: copy.semanticsLabel,
        excludeSemantics: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border: Border(bottom: BorderSide(color: style.borderColor)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: style.badgeBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Icon(style.icon, size: 20, color: style.foregroundColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      copy.title,
                      style: TextStyle(
                        color: style.foregroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      copy.subtitle,
                      style: TextStyle(
                        color: style.subtitleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerVisualStyle {
  const _BannerVisualStyle({
    required this.icon,
    required this.backgroundColor,
    required this.badgeBackgroundColor,
    required this.borderColor,
    required this.foregroundColor,
    required this.subtitleColor,
  });

  factory _BannerVisualStyle.fromMode(ConnectivityBannerMode mode) {
    switch (mode) {
      case ConnectivityBannerMode.online:
        return const _BannerVisualStyle(
          icon: Icons.wifi,
          backgroundColor: Color(0xFFEDF8F1),
          badgeBackgroundColor: Color(0xFFD5EFE0),
          borderColor: Color(0xFFD5E9DC),
          foregroundColor: Color(0xFF0E4F31),
          subtitleColor: Color(0xFF1F5C3F),
        );
      case ConnectivityBannerMode.offline:
        return const _BannerVisualStyle(
          icon: Icons.wifi_off,
          backgroundColor: Color(0xFFF3F4F7),
          badgeBackgroundColor: Color(0xFFE4E6EC),
          borderColor: Color(0xFFE2E4E9),
          foregroundColor: Color(0xFF424A59),
          subtitleColor: Color(0xFF555E6D),
        );
      case ConnectivityBannerMode.serviceUnavailable:
        return const _BannerVisualStyle(
          icon: Icons.cloud_off_outlined,
          backgroundColor: Color(0xFFFFF8E7),
          badgeBackgroundColor: Color(0xFFFCE8BD),
          borderColor: Color(0xFFF3DFB3),
          foregroundColor: Color(0xFF7A4100),
          subtitleColor: Color(0xFF8A4F0D),
        );
      case ConnectivityBannerMode.syncing:
        return const _BannerVisualStyle(
          icon: Icons.sync,
          backgroundColor: Color(0xFFF1F6FF),
          badgeBackgroundColor: Color(0xFFDCE8FA),
          borderColor: Color(0xFFD5E1F5),
          foregroundColor: Color(0xFF1E3F6E),
          subtitleColor: Color(0xFF274C7F),
        );
    }
  }

  final IconData icon;
  final Color backgroundColor;
  final Color badgeBackgroundColor;
  final Color borderColor;
  final Color foregroundColor;
  final Color subtitleColor;
}

// Pendiente reemplazar los textos cuando se implementen los idiomas
class _BannerCopy {
  const _BannerCopy({
    required this.title,
    required this.subtitle,
    required this.semanticsLabel,
  });

  factory _BannerCopy.fromState(ConnectivityBannerViewState state) {
    final formattedTime = state.lastSyncAt != null
        ? _formatSyncTime(state.lastSyncAt!)
        : null;

    switch (state.mode) {
      case ConnectivityBannerMode.online:
        const title = 'Online';
        final String subtitle;
        if (formattedTime != null) {
          subtitle = 'Datos locales · última sincronización $formattedTime';
        } else {
          subtitle = 'Datos locales · sin sincronización previa';
        }
        return _BannerCopy(
          title: title,
          subtitle: subtitle,
          semanticsLabel: 'Estado de conexión: $title. $subtitle',
        );

      case ConnectivityBannerMode.offline:
        const title = 'Offline';
        final subtitle = formattedTime != null
            ? 'Datos locales · última sincronización $formattedTime'
            : 'Sin datos locales';
        return _BannerCopy(
          title: title,
          subtitle: subtitle,
          semanticsLabel: 'Estado de conexión: $title. $subtitle',
        );

      case ConnectivityBannerMode.serviceUnavailable:
        const title = 'Servicio no disponible';
        final retrySeconds = state.retryInSeconds;
        final String subtitle;
        if (retrySeconds != null && retrySeconds > 0) {
          subtitle =
              'Internet disponible · API sin respuesta · reintento $retrySeconds s';
        } else if (formattedTime != null) {
          subtitle =
              'Internet disponible · API sin respuesta · última sincronización $formattedTime';
        } else {
          subtitle = 'Internet disponible · API sin respuesta';
        }
        return _BannerCopy(
          title: title,
          subtitle: subtitle,
          semanticsLabel: 'Estado de conexión: $title. $subtitle',
        );

      case ConnectivityBannerMode.syncing:
        const title = 'Sincronizando...';
        final subtitle = _buildSyncingSubtitle(
          state: state,
          formattedTime: formattedTime,
        );
        return _BannerCopy(
          title: title,
          subtitle: subtitle,
          semanticsLabel: 'Estado de conexión: $title $subtitle',
        );
    }
  }

  final String title;
  final String subtitle;
  final String semanticsLabel;

  static String _buildSyncingSubtitle({
    required ConnectivityBannerViewState state,
    required String? formattedTime,
  }) {
    if (state.isVerifying) {
      return formattedTime != null
          ? 'Datos locales · última sincronización $formattedTime'
          : 'Verificando disponibilidad del servicio';
    }
    final total = state.totalCount;
    final synced = state.syncedCount;
    if (total != null && total > 0 && synced != null && synced > 0) {
      return 'Actualizando catálogo ($synced de $total) · puedes seguir navegando';
    }
    if (formattedTime != null) {
      return 'Datos locales · última sincronización $formattedTime';
    }
    return 'Actualizando datos locales · puedes seguir navegando';
  }

  static String _formatSyncTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
