import 'package:flutter/material.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class PetalCircle extends Petal {
  PetalCircle.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  PetalCircle();
  @override
  void paint(Scene context, Canvas canvas, Size size) {
    for (final p in context.particles) {
      canvas.save();
      canvas.translate(p.position.x, p.position.y);

      canvas.transform((Matrix4.rotationX(radians(p.rotationX))..rotateY(radians(p.rotationY))..rotateZ(radians(p.rotationZ))).storage);

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
}