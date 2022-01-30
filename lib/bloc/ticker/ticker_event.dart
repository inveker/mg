part of 'ticker_bloc.dart';

abstract class TickerEvent {
  const TickerEvent();
}


class TickerTicked extends TickerEvent {
  final double dt;
  TickerTicked(this.dt);
}

class TickerPaused extends TickerEvent {
  const TickerPaused();
}