import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/nft.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {

  late final Ticker ticker;
  late double _lastDt;

  TickerBloc() : super(TickerState()) {
    on<TickerTicked>(_tick);
    on<TickerPaused>(_pause);
    _lastDt = 0;
    ticker = Ticker((elapsed) {
      int time = elapsed.inMilliseconds;
      var ms = time / 1000;
      double deltaTime = ms - _lastDt;
      _lastDt = ms;

      add(TickerTicked(deltaTime));
    })..start();
  }

  void _tick(TickerTicked event, Emitter<TickerState> emit) {
    emit(state.copyWith(
      dt: event.dt,
    ));
  }

  void _pause(TickerPaused event, Emitter<TickerState> emit) {
    emit(state.copyWith(
      isPaused: !state.isPaused,
    ));
  }

  @override
  Future<void> close() {
    ticker.dispose();
    return super.close();
  }
}
