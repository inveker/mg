import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta_garden/utils/utils.dart';


double radians(num v) {
  return pi * v / 180;
}

class Vector2 {
  final double x;
  final double y;

  Vector2(this.x, this.y);

  Vector2.fromOffset(Offset o):
      x = o.dx,
      y = o.dy;

  Vector2.zero():
    x = 0,
    y = 0;

  Vector2 copy() {
    return Vector2(x, y);
  }

  factory Vector2.random() {
    double x = random.nextBool() ? 1 : -1;
    x *= random.nextInt(100) + 1;
    double y = random.nextBool() ? 1 : -1;
    y *= random.nextInt(100) + 1;

    return Vector2(x, y).normalize();
  }

  bool notZero() {
    return x != 0 && y != 0;
  }

  Offset toOffset() {
    return Offset(x, y);
  }

  double get length {
    return sqrt(pow(x,2) + pow(y, 2));
  }

  Vector2 normalize() {
    var l = length;
    if(l == 0) {
      return Vector2(0,0);
    }
    return Vector2(x / l, y / l);
  }

  Vector2 rotate(double ang) {
    var r1c1 = cos(ang);
    var r1c2 = -sin(ang);
    var r2c1 = -r1c2;
    var r2c2 = r1c1;
    return Vector2(
      r1c1 * x + r1c2 * y,
      r2c1 * x + r2c2 * y,
    );
  }

  double angleFor(Vector2 vector) {
    return angleRadFor(vector) * 180 / pi;
  }

  double angleRadFor(Vector2 vector) {
    return orientation(vector) * acos((x*vector.x + y*vector.y)/length*vector.length);
  }

  @override
  String toString() {
    return 'Vector2 x: $x, y: $y';
  }

  int orientation(Vector2 vector) {
    return x*vector.y - y*vector.x < 0 ? 1 : -1;
  }

  Vector2 operator + (Vector2 other){
    return Vector2(
        x + other.x,
        y + other.y
    );
  }


  Vector2 operator - (Vector2 other){
    return Vector2(
        x - other.x,
        y - other.y
    );
  }

  Vector2 operator * (num a){
    return Vector2(
        x * a,
        y * a
    );
  }

  Map toJson (){
    return {
      'x': x,
      'y': y,
    };
  }

  Vector2.fromJson(Map json): x = json['x'], y = json['y'];
}