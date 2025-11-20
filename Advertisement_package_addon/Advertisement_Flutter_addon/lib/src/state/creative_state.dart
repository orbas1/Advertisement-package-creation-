part of 'ads_blocs.dart';

class CreativeState extends Equatable {
  const CreativeState._({
    this.creatives = const [],
    this.status = CreativeStatus.idle,
    this.error,
  });

  const CreativeState.idle() : this._(status: CreativeStatus.idle);
  const CreativeState.loading() : this._(status: CreativeStatus.loading);
  const CreativeState.ready(List<Creative> creatives)
      : this._(status: CreativeStatus.ready, creatives: creatives);
  const CreativeState.error(String message)
      : this._(status: CreativeStatus.error, error: message);

  final List<Creative> creatives;
  final CreativeStatus status;
  final String? error;

  @override
  List<Object?> get props => [creatives, status, error];
}

enum CreativeStatus { idle, loading, ready, error }
