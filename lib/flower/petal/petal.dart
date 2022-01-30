import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal_circle.dart';
import 'package:meta_garden/flower/petal/petal_square.dart';
import 'package:meta_garden/flower/petal/petal_triangle.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

abstract class Petal {

  late final bool? isRandom;
  late final double? angleX;
  late final int? angleDirX;
  late final double? angleY;
  late final int? angleDirY;
  late final double? angleZ;
  late final int? angleDirZ;
  late final String type;
  late Map selfRotations;

  // форма лепестка
  void paint(Scene context, Canvas canvas, Size size);

  Petal({
    this.isRandom,
    this.angleX,
    this.angleDirX,
    this.angleY,
    this.angleDirY,
    this.angleZ,
    this.angleDirZ,
  }) {
    type = runtimeType.toString();
    constructor();
  }

  Petal.fromJson(Map<String, dynamic> json) {
    isRandom = json['isRandom'];
    angleX = json['angleX'];
    angleDirX = json['angleDirX'];
    angleY = json['angleY'];
    angleDirY = json['angleDirY'];
    angleZ = json['angleZ'];
    angleDirZ = json['angleDirZ'];
    type = json['type'];
    constructor();
  }
  void constructor() {
    selfRotations = {};
  }


  Petal copyWith({
    bool? isRandom,
    double? angleX,
    int? angleDirX,
    double? angleY,
    int? angleDirY,
    double? angleZ,
    int? angleDirZ,
  });

  Map<String, dynamic> toJson() {
    return {
      'isRandom': isRandom,
      'angleX': angleX,
      'angleDirX': angleDirX,
      'angleY': angleY,
      'angleDirY': angleDirY,
      'angleZ': angleZ,
      'angleDirZ': angleDirZ,
      'type': type,
    };
  }

  static List<Petal Function()> builders = [
        () => PetalCircle.random(),
        () => PetalSquare.random(),
        () => PetalTriangle.random(),
  ];

  factory Petal.random() {
    return builders.rand()();
  }
}