import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta_garden/app.dart';
class FrameManager {
  static int currentFrame = 0;
  static int frameRate = 60;
  static double frameTime = 1000 / frameRate;
  static int allTime = 10;
  static int allFrames = (allTime * frameRate);

  static double time = 0;
  static tick() {
    time += frameTime;
    currentFrame++;
  }
  static reset() {
    time = 0;
    currentFrame = 0;
  }
}


void main() {
  runZoned(() => runApp(App()));
}