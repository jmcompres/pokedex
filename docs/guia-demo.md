# Guía de demostración — API no disponible y recuperación periódica (PFL-19)

Esta guía describe cómo demostrar los escenarios **PA-08**, **IND-02** e **IND-03** sin necesidad de bloquear PokeAPI a nivel de red externa.

## Requisitos previos

- Ejecutar la aplicación en **modo debug** (`flutter run` o botón Run/Debug del IDE).
- Contar con conexión a Internet activa (Wi-Fi o datos móviles) y haber cargado al menos una vez el catálogo para observar la continuidad offline-first.

> En compilaciones **release** (`flutter run --release`, `flutter build apk --release`), `kDebugMode` es `false` y la sección de herramientas de depuración se oculta automáticamente en **Ajustes**.

---

## 1. Simular API no disponible con red activa (PA-08, IND-02)

1. Con Internet activo, abrir la aplicación y comprobar que el indicador global (`ConnectivityBanner`) muestra **Online**.
2. Ir a la pestaña **Ajustes** en la barra de navegación inferior.
3. En la sección **Herramientas de depuración (PA-08)**, activar el interruptor **«Simular API caída»**.

### Resultado esperado

- `simulateApiOutageProvider` cambia a `true`.
- El interruptor dispara `serviceAvailabilityMonitorProvider.recheck()` de forma inmediata.
- `PokeApiGraphQLHealthCheck` reporta que el servicio no está saludable y `GraphQLService` lanza `ServerFailure` (HTTP `503`) en cualquier consulta mientras la red del dispositivo sigue activa.
- El indicador global transiciona a **Servicio no disponible** (`Internet disponible · API sin respuesta`).
- Al volver al **Catálogo**, los Pokémon ya guardados en SQLite siguen visibles y navegables; un intento de actualización manual falla sin borrar datos locales.

---

## 2. Recuperación de la API y verificación periódica (IND-03)

1. Con la red activa y el banner en **Servicio no disponible**, volver a la pestaña **Ajustes**.
2. Desactivar el interruptor **«Simular API caída»**.

### Resultado esperado

- `recheck()` ejecuta una nueva comprobación GraphQL real (`__typename`).
- El monitor pasa por `verifying` y recupera el estado **Online**.
- Al pasar de `serviceUnavailable` a `online`, `ServiceAvailabilityMonitor` invoca `onReconnected` para reanudar cualquier sincronización pendiente.

> **Nota sobre caídas reales:** si PokeAPI falla temporalmente en producción (sin usar el interruptor de debug), `CatalogSyncCoordinator` llama a `onSyncFailed` para ejecutar `recheck()` al fallar la sincronización, y `ServiceAvailabilityMonitor` vuelve a comprobar el servicio automáticamente cada **30 segundos** (`periodicCheckInterval`) mientras haya red activa hasta detectar la recuperación.
