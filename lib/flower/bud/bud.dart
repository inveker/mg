import 'package:flutter/material.dart';
import 'package:meta_garden/flower/bud/bud_bindweed.dart';
import 'package:meta_garden/flower/bud/bud_center.dart';
import 'package:meta_garden/flower/bud/bud_circle.dart';
import 'package:meta_garden/flower/bud/bud_circle_border.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/main.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

abstract class Bud {
  late final int particlesCount;
  late final List<Vector2> positions;
  late final List<List<Vector2>> movedPositions;
  late final double? radius;
  late final double? innerRadius;
  late final Vector2? velocity;
  late final double? speed;
  late final double? angle;
  late final String type;
  late final PlantType plantType;
  late final bool? isRandom;
  late final bool? isRandomSpeed;

  List<Vector2>? currentPositions;
  List<int> currentFrames = [];
  bool isPlant = false;

  var g = false;
  var g2 = false;

  Bud({
    required this.particlesCount,
    required this.positions,
    required this.movedPositions,
    required this.plantType,
    this.radius,
    this.innerRadius,
    this.velocity,
    this.speed,
    this.angle,
    this.isRandom,
    this.isRandomSpeed,
  }) {
    type = runtimeType.toString();
    constructor();
  }

  void constructor() {
    currentPositions = positions.map((e) => e.copy()).toList();
    currentFrames = [
      for (var p in currentPositions!) 0,
    ];
  }

  Bud.fromJson(Map<String, dynamic> json) {
    particlesCount = json['particlesCount'];
    positions = [
      for (var e in json['positions']) Vector2.fromJson(e),
    ];
    movedPositions = [
      for (var e in json['movedPositions'])
        [
          for (var i in e) Vector2.fromJson(i),
        ],
    ];
    radius = json['radius'];
    innerRadius = json['innerRadius'];
    velocity = json['velocity'] == null ? null : Vector2.fromJson(json['velocity']);
    speed = json['speed'];
    angle = json['angle'];
    isRandom = json['isRandom'];
    isRandomSpeed = json['isRandomSpeed'];
    type = json['type'];
    plantType = PlantType.fromJson(json['plantType']);
    constructor();
  }

  Map<String, dynamic> toJson() {
    return {
      'particlesCount': particlesCount,
      'positions': [
        for (var e in positions) e.toJson(),
      ],
      'movedPositions': [
        for (var e in movedPositions)
          [
            for (var i in e) i.toJson(),
          ],
      ],
      'radius': radius,
      'innerRadius': innerRadius,
      'velocity': velocity,
      'speed': speed,
      'angle': angle,
      'type': type,
      'isRandom': isRandom,
      'isRandomSpeed': isRandomSpeed,
      'plantType': plantType.toJson(),
    };
  }

  bool isInit = false;

  void generate(Scene context, double dt) {
    if(FrameManager.time > 1000 * 7) {
      g = true;
    }
    if(FrameManager.time > 1000 * 7 + 1000 * 1) {
      g2 = true;
    }
    if (g2) return;
    for (var i = 0; i < currentPositions!.length; i++) {
      if (movedPositions[i].isNotEmpty) {
        isPlant = true;
        if (currentFrames[i] < movedPositions[i].length - 1) {
          currentPositions![i] = movedPositions[i][currentFrames[i]];
          currentFrames[i]++;

          for (var j = 1; j < 5; j++) {
            var position = currentPositions![i];
            context.particles.add(FlowerParticle(
              colors: context.flower.palette.colors,
              position: position,
            ));
          }

          if (currentFrames[i] > 0 && random.percent(50)) {
            var v = movedPositions[i][currentFrames[i]] - movedPositions[i][currentFrames[i] - 1];
            v = v.rotate(radians(random.sign() * (30 + random.nextInt(61)))).normalize();
            for (var j = 1; j < 2 + random.nextInt(3); j++) {
              var position = currentPositions![i];

              context.particles.add(FlowerParticle(
                colors: context.flower.palette.colors,
                position: position,
              )..velocity = v * j * 2
                  // ..color = random.nextBool() ? Colors.lightGreenAccent : Colors.lightGreen
                  // ..freezed = true
                  // ..speed = 10
                  // ..width *= 0.7,
                  );
            }
          }

          context.particles.forEach((element) {
            if (plantType == PlantType.green()) {
              element.color = random.nextBool() ? Colors.lightGreenAccent : Colors.lightGreen;
            } else if (plantType == PlantType.brown()) {
              element.color = random.nextBool() ? Colors.brown[400]! : Colors.brown[900]!;
            } else if (plantType == PlantType.red()) {
              element.color = random.nextBool() ? Colors.red[400]! : Colors.red[900]!;
            }
            if (element.freezed) return;

            element.freezed = true;
            element.speed = 10;
            element.width *= 0.7;
          });
        } else {
          isPlant = false;
          context.particles.forEach((element) {
            if (element.freezed) {
              if (plantType == PlantType.green()) {
                element.color = random.nextBool() ? Colors.lightGreenAccent : Colors.lightGreen;
              } else if (plantType == PlantType.brown()) {
                element.color = random.nextBool() ? Colors.brown[400]! : Colors.brown[900]!;
              } else if (plantType == PlantType.red()) {
                element.color = random.nextBool() ? Colors.red[400]! : Colors.red[900]!;
              }
            }
          });
        }
      }
    }
  }

  Bud copyWith({
    int? particlesCount,
    double? radius,
    double? innerRadius,
    List<Vector2>? positions,
    PlantType? plantType,
    List<List<Vector2>>? movedPositions,
    Vector2? velocity,
    double? speed,
    double? angle,
    bool? isRandom,
    bool? isRandomSpeed,
  });

  factory Bud.random() {
    final randomIndex = random.nextInt(4);
    switch (randomIndex) {
      case 0:
        return BudCenter.random();
      case 1:
        return BudCircle.random();
      case 2:
        return BudCircleBorder.random();
      case 3:
        return BudBindweed.random();

      default:
        return BudCenter.random();
    }
  }
}
