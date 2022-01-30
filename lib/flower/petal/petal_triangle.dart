import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class PetalTriangle extends Petal {
  PetalTriangle.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  PetalTriangle({
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

  factory PetalTriangle.random() {
    return PetalTriangle(
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
        var path = buildTriangle(p.width);
        canvas.drawPath(path, Paint()..color = p.color.withAlpha(150));
      } else if (p.type == FlowerParticleType.light) {
        var path1 = buildTriangle(p.width);

        canvas.drawPath(path1, Paint()..color = context.flower.palette.colors[0].withAlpha(150));

        var path2 = buildTriangle(p.width / 2);
        canvas.drawPath(path2, Paint()
          ..color = p.color.withAlpha(250)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)));
      }

      canvas.restore();
    }
  }

  Map<double, Matrix4> _mtrx = {};

  Path? _triangle;
  Path buildTriangle(double width) {
    _triangle ??= Path()
      ..moveTo(-1 * 2/2, 1 * 2/3)
      ..lineTo(0, -2*1 * 2/3)
      ..lineTo(1 * 2/2, 1 * 2/3)
      ..close();
    if(_mtrx[width] == null) {
      _mtrx[width] = Matrix4(
        width, 0, 0, 0,
        0,  width, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      );
    }
    return _triangle!.transform(_mtrx[width]!.storage);
  }


  @override
  PetalTriangle copyWith({
    bool? isRandom,
    double? angleX,
    int? angleDirX,
    double? angleY,
    int? angleDirY,
    double? angleZ,
    int? angleDirZ,
  }) {
    return PetalTriangle(
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