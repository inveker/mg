import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class PetalCircle extends Petal {
  PetalCircle.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  PetalCircle({
    required bool isRandom,
    required double angleX,
    required int angleDirX,
    required double angleY,
    required int angleDirY,
    required double angleZ,
    required int angleDirZ,
  }) : super(
    isRandom: isRandom,
    angleX: angleX,
    angleDirX: angleDirX,
    angleY: angleY,
    angleDirY: angleDirY,
    angleZ: angleZ,
    angleDirZ: angleDirZ,
  );

  factory PetalCircle.random() {
    return PetalCircle(
      isRandom: random.nextBool(),
      angleX: random.nextInt(360).toDouble(),
      angleY: random.nextInt(360).toDouble(),
      angleZ: random.nextInt(360).toDouble(),
      angleDirX: random.sign(),
      angleDirY: random.sign(),
      angleDirZ: random.sign(),
    );
  }

  @override
  void paint(Scene context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      var _rotationX = angleX;
      var _rotationY = angleY;
      var _rotationZ = angleZ;
      if(isRandom!) {
        if(selfRotations[p] == null) {
          selfRotations[p] = {
            'x': random.nextInt(1 + angleX!.toInt()).toDouble(),
            'y': random.nextInt(1 + angleY!.toInt()).toDouble(),
            'z': random.nextInt(1 + angleZ!.toInt()).toDouble(),
          };
        }
        _rotationX = selfRotations[p]['x'];
        _rotationY = selfRotations[p]['y'];
        _rotationZ = selfRotations[p]['z'];
      }
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX + _rotationX! * angleDirX!))
        ..rotateY(radians(p.rotationY + _rotationY! * angleDirY!))
        ..rotateZ(radians(p.rotationZ + _rotationZ! * angleDirZ!))).storage);

      if (p.type == FlowerParticleType.simple) {
        canvas.drawCircle(Offset.zero, p.width, Paint()..color = p.color.withAlpha(150));
      } else if (p.type == FlowerParticleType.light) {
        canvas.drawCircle(Offset.zero, p.width, Paint()..color = context.flower.palette.colors[0].withAlpha(150));
        canvas.drawCircle(Offset.zero, p.width / 2, Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }
      canvas.restore();
    }
  }


  @override
  PetalCircle copyWith({
    bool? isRandom,
    double? angleX,
    int? angleDirX,
    double? angleY,
    int? angleDirY,
    double? angleZ,
    int? angleDirZ,
  }) {
    return PetalCircle(
      isRandom: isRandom ?? this.isRandom!,
      angleX: angleX ?? this.angleX!,
      angleDirX: angleDirX ?? this.angleDirX!,
      angleY: angleY ?? this.angleY!,
      angleDirY: angleDirY ?? this.angleDirY!,
      angleZ: angleZ ?? this.angleZ!,
      angleDirZ: angleDirZ ?? this.angleDirZ!,
    );
  }
}