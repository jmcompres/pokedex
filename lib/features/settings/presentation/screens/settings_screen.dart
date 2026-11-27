import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pokedex/core/network/api_outage_simulator.dart';
import 'package:pokedex/core/network/network_providers.dart';
import 'package:pokedex/core/presentation/placeholder_view.dart';
import 'package:pokedex/core/presentation/pokedex_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key, this.debugModeOverride});

  @visibleForTesting
  final bool? debugModeOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDebugTools = debugModeOverride ?? kDebugMode;

    if (!showDebugTools) {
      return const PokedexScaffold(
        title: 'Ajustes',
        body: PlaceholderView(
          icon: Icons.settings_outlined,
          title: 'Ajustes en implementación',
          message: 'Los ajustes aparecerán aquí.',
        ),
      );
    }

    final isSimulated = ref.watch(simulateApiOutageProvider);

    return PokedexScaffold(
      title: 'Ajustes',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Herramientas de depuración',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              key: const Key('simulate_api_outage_switch'),
              title: const Text('Simular API caída'),
              subtitle: const Text(
                'Mantiene la red activa, pero bloquea consultas GraphQL y health checks',
              ),
              value: isSimulated,
              onChanged: (value) {
                ref
                    .read(simulateApiOutageProvider.notifier)
                    .setSimulated(value);
                unawaited(
                  ref.read(serviceAvailabilityMonitorProvider).recheck(),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const PlaceholderView(
            icon: Icons.settings_outlined,
            title: 'Ajustes en implementación',
            message: 'Las preferencias de idioma y tema aparecerán aquí.',
          ),
        ],
      ),
    );
  }
}
