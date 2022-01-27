import 'dart:math';

import 'package:flutter/material.dart';



final Random random = Random();

extension RandomExtension on Random {
  int sign() {
    return nextBool() ? 1 : -1;
  }

  bool percent(double p) {
    return nextInt(101) > 100 - p;
  }
}

int lastColor = -1;

Color randomColor() {

  List<Color> colors = [
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.yellowAccent,
    Colors.lightBlueAccent,
    Colors.deepOrange,
    Colors.purpleAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.deepPurpleAccent,
    Colors.cyanAccent,
    Colors.limeAccent
  ];

  var newColor;
  do {
    newColor = random.nextInt(colors.length);
  } while (newColor == lastColor);

  lastColor = newColor;

  return colors[newColor];

  return Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
}


Color randomRealColor() {
  return Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
}


double convertRadiusToSigma(double radius) {
  return radius * 0.57735 + 0.5;
}

List<Color> randomPalette() {
  return [
    for (var i = 0; i < random.nextInt(4) + 2; i++)
      randomRealColor(),
  ];
}


extension ListExt<T> on List<T> {
  T rand() => this[random.nextInt(this.length)];
}