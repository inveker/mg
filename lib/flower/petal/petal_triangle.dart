import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class PetalTriangle extends Petal {
  PetalTriangle.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  PetalTriangle();
  @override
  void paint(Scene context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ))).storage);

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
}