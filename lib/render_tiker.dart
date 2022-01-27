import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
double _lastDt = 0;

ValueNotifier<double> tickerNotifier = ValueNotifier(_lastDt);
var renderTicker = Ticker((elapsed) {
  int time = elapsed.inMilliseconds;
  var ms = time / 1000;
  double deltaTime = ms - _lastDt;
  _lastDt = ms;
  tickerNotifier.value = deltaTime;
});