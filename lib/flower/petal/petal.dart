import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal_circle.dart';
import 'package:meta_garden/flower/petal/petal_square.dart';
import 'package:meta_garden/flower/petal/petal_triangle.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

abstract class Petal {
  // форма лепестка
  void paint(Scene context, Canvas canvas, Size size);

  Petal();



  Petal.fromJson(Map<String, dynamic> json) {
  }

  Map<String, dynamic> toJson() {
    return {
    };
  }

  static List<Petal Function()> builders = [
        () => PetalCircle(),
        () => PetalSquare(),
        () => PetalTriangle(),
  ];

  factory Petal.random() {
    return builders[random.nextInt(builders.length)]();
  }
}