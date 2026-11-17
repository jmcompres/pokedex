# ADR-0001: Drift (SQLite) como base local

## Contexto

La interfaz solo lee de la base local, así que necesitábamos una base que:

- guarde datos relacionados (especies, Pokémon, formas, tipos…);
- avise cuando cambia, para que la pantalla se actualice sola;
- tenga transacciones, para no dejar páginas a medias;
- proteja los favoritos de lo que haga la sincronización;
- permita buscar y filtrar rápido.

## Decisión

Usamos **Drift** sobre SQLite:

- Las tablas son clases de Dart, y los errores de nombres o tipos salen al compilar.
- `watch()` vuelve a emitir cada vez que la sync escribe, y la pantalla se redibuja.
- Cada página se guarda en un `batch` (una transacción) junto con su progreso.
- Hay claves foráneas (`PRAGMA foreign_keys = ON`) e índices.
- Guardamos con `insertAllOnConflictUpdate` (*upsert*) y nunca con `InsertMode.replace`,
  que borra y reinserta la fila y dispararía los borrados en cascada.

## Alternativas

- **Hive / shared_preferences:** son clave-valor, sin relaciones ni filtros.
- **sqflite:** es el mismo SQLite, pero con SQL en texto, sin tipos y sin consultas
  observables.
- **Isar / ObjectBox:** las relaciones son más limitadas, y el paquete original de Isar quedó
  sin mantenimiento.
- **Caché del cliente GraphQL:** guarda respuestas, no un modelo de datos, y ataría la
  interfaz a la API (OF-17).

## Consecuencias

- La interfaz se actualiza sola, la sync puede reanudarse sin datos a medias y la FK de
  `favorite` (sin cascada) impide perder un favorito.
- Las pruebas usan una base en memoria (`NativeDatabase.memory()`).
- Hay que regenerar código (`build_runner`) cada vez que cambia una tabla o un DAO.
- El *App Inspection* de Android Studio no ve la base, porque Drift trae su propia
  SQLite. Hay que usar la extensión de Drift para DevTools.
- Cambiar el esquema implica subir `schemaVersion` y escribir la migración.