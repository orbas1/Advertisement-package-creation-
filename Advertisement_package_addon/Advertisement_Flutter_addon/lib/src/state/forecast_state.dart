part of 'ads_blocs.dart';

class ForecastState extends Equatable {
  const ForecastState._({
    this.forecast,
    this.status = ForecastStatus.idle,
    this.error,
  });

  const ForecastState.idle() : this._();
  const ForecastState.loading() : this._(status: ForecastStatus.loading);
  const ForecastState.ready(Forecast forecast)
      : this._(status: ForecastStatus.ready, forecast: forecast);
  const ForecastState.error(String message)
      : this._(status: ForecastStatus.error, error: message);

  final Forecast? forecast;
  final ForecastStatus status;
  final String? error;

  @override
  List<Object?> get props => [forecast, status, error];
}

enum ForecastStatus { idle, loading, ready, error }
