part of 'ticker_bloc.dart';

class TickerState {
  final bool isPaused;
  final double dt;

  TickerState({
    this.dt = 0,
    this.isPaused = false,
  });

  TickerState copyWith({
    bool? isPaused,
    double? dt,
  }) {
    return TickerState(
      isPaused: isPaused ?? this.isPaused,
      dt: dt ?? this.dt,
    );
  }
}
