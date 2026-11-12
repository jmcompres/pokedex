import 'package:equatable/equatable.dart';
import 'package:pokedex/core/errors/failures.dart';

sealed class SyncStatus extends Equatable {
  const SyncStatus();

  @override
  List<Object?> get props => const [];
}

final class SyncIdle extends SyncStatus {
  const SyncIdle();
}

final class SyncInProgress extends SyncStatus {
  const SyncInProgress({required this.synced, this.total});

  final int synced;
  final int? total;

  double? get progress {
    final total = this.total;
    if (total == null || total == 0) return null;
    return synced / total;
  }

  @override
  List<Object?> get props => [synced, total];
}

final class SyncCompleted extends SyncStatus {
  const SyncCompleted();
}

final class SyncFailed extends SyncStatus {
  const SyncFailed(this.failure);
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
