import 'package:flutter/material.dart';
import 'package:meta_garden/scene.dart';

class Renderer extends StatelessWidget {
  final Scene scene;
  final ValueNotifier repaint;

  const Renderer({
    Key? key,
    required this.scene,
    required this.repaint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: RendererPainter(
          scene: scene,
          repaint: repaint,
        ),
      ),
    );
  }
}

class RendererPainter extends CustomPainter {
  final ValueNotifier repaint;
  final Scene scene;

  RendererPainter({
    required this.repaint,
    required this.scene,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    scene
      ..paint(canvas, size)
      ..update(repaint.value);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
