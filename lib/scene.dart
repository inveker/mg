import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_garden/flower/flower.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class Scene {
  final Flower flower;
  List<FlowerParticle> particles = [];

  Scene({
    required this.flower,
  });

  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black);
    flower.petal.paint(this, canvas, size);

    final textStyle = GoogleFonts.dancingScript().copyWith(
      color: Colors.black.withOpacity(0.1),
      fontSize: 30,
    );

    final textSpan = TextSpan(
      text: 'Meta Garden',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(size.width - 148, size.height - 40);
    textPainter.paint(canvas, offset);
  }

  void update(double dt) {
    flower
      ..bud.generate(this, dt)
      ..vegetation.update(this, dt)
      ..dimension.update(this, dt)
      ..growth.update(this, dt);

    particles.toList().forEach((p) {

      p.position += (p.velocity) * dt * p.speed;

      if(flower.bud.g2) {
        p.opacitySpeed += 10 * dt;
        p.width *= 0.8 * 60 * dt;
      }

      var newOpacity = p.color.opacity - p.opacitySpeed * dt;
      if (newOpacity < 0) newOpacity = 0;
      p.color = p.color.withOpacity(newOpacity);


      bool notOpacity = p.color.opacity == 0;
      bool notSize = p.width <= 0;
      if (notOpacity || notSize) {
        particles.remove(p);
      }
      if(flower.bud.g2 && p.freezed) particles.remove(p);
    });
    if(flower.bud.g) {
      if(particles.length > 20) {
        particles = particles.sublist((particles.length / 20).toInt());
      } else if(particles.length > 1){
        particles = particles.sublist(1);
      }
    }
  }
}


enum FlowerParticleType {
  simple,
  light,
}

class FlowerParticle {
  late Color color;
  late List<Color> colors;
  Vector2 position;
  late Vector2 velocity;
  late double width;
  late double speed;
  late FlowerParticleType type;
  late double rotationY;
  late double rotationX;
  late double rotationZ;
  late bool freezed;
  late double opacitySpeed;

  FlowerParticle({ required this.colors, required this.position}) {
    rotationY = 0;
    rotationX = 0;
    rotationZ = 0;
    velocity = Vector2.random();
    width = 10;
    speed = 100;
    opacitySpeed = 0.3;
    freezed = false;
    if (random.percent(30)) {
      type = FlowerParticleType.light;
    } else {
      type = FlowerParticleType.simple;
    }
    color = colors.sublist(1)[random.nextInt(colors.length-1)];
  }
}