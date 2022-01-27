import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class PetalSquare extends Petal {
  PetalSquare.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  PetalSquare();
  @override
  void paint(Scene context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ))).storage);

      if (p.type == FlowerParticleType.simple) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width * 2, height: p.width * 2),
          Paint()..color = p.color,
        );
      } else if (p.type == FlowerParticleType.light) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width * 2, height: p.width * 2),
          Paint()
            ..color = context.flower.palette.colors[0].withAlpha(150)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(2)),
        );
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.width * 2 / 2, height: p.width * 2 / 2),
          Paint()..color =  p.color.withAlpha(250),
        );
      }

      canvas.restore();
    }
  }
}