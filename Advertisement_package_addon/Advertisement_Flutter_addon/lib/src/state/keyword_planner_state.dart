part of 'ads_blocs.dart';

class KeywordPlannerState extends Equatable {
  const KeywordPlannerState._({
    this.keyword,
    this.prices = const [],
    this.status = KeywordPlannerStatus.idle,
    this.error,
  });

  const KeywordPlannerState.idle() : this._();
  const KeywordPlannerState.loading() : this._(status: KeywordPlannerStatus.loading);
  const KeywordPlannerState.ready(String keyword, List<KeywordPrice> prices)
      : this._(status: KeywordPlannerStatus.ready, keyword: keyword, prices: prices);
  const KeywordPlannerState.error(String message)
      : this._(status: KeywordPlannerStatus.error, error: message);

  final String? keyword;
  final List<KeywordPrice> prices;
  final KeywordPlannerStatus status;
  final String? error;

  @override
  List<Object?> get props => [keyword, prices, status, error];
}

enum KeywordPlannerStatus { idle, loading, ready, error }
