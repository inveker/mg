import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/utils/vector2.dart';


class MainBackground extends StatefulWidget {

  final Widget child;

  const MainBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _MainBackgroundState createState() => _MainBackgroundState();
}

Color randomColor() {
  var rand = Random();
  return Color.fromARGB(
    150,
    rand.nextInt(255),
    rand.nextInt(255),
    rand.nextInt(255),
  );
}

class _MainBackgroundState extends State<MainBackground> {

  late ValueNotifier animationNotifier;
  late List<CircleParticle> particles;


  double _lastDt = 0;


  late Ticker renderTicker;


  @override
  void initState() {
    animationNotifier = ValueNotifier(_lastDt);

    renderTicker = Ticker((elapsed) {
      int time = elapsed.inMilliseconds;
      var ms = time / 1000;
      double deltaTime = ms - _lastDt;
      _lastDt = ms;
      animationNotifier.value = deltaTime;
    });

    renderTicker.start();

    particles = [];


      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if(particles.length > 1000) {
          particles.removeRange(0, 500);
        }
        for(var i = 0; i < 5; i++) {
          var b1 = Random().nextBool();
          var x = Random().nextDouble();
          x = b1 ? x : -x;
          var b2 = Random().nextBool();
          var y = Random().nextDouble();
          y = b2 ? y : -y;
          var velocity = Vector2(x, y).normalize();
          // var q = (Random().nextDouble() * 3 + 1) * 0.001;
          var q = 0.001;
          velocity = Vector2(velocity.x * q, velocity.y * q);

          var b3 = Random().nextBool();
          var x2 = Random().nextDouble();
          x2 = b3 ? x2 : -x2;
          var b4 = Random().nextBool();
          var y2 = Random().nextDouble();
          y2 = b4 ? y2 : -y2;
          var position = Vector2(x, y).normalize();
          var a = Random().nextInt(1000);
          position = Vector2(position.x * (500 + a), position.y * (500 + a));

          var c = Random().nextInt(1000);
          var p = Paint();
          if(c > 300) {
            p.color = Colors.lightBlueAccent;
          } else if(c > 200) {
            p.color = Colors.lightBlue;
          } else if(c > 50) {
            p.color = Colors.white;
          } else if(c > 5) {
            p.color = Colors.deepOrange;
          }


          particles.add(
              CircleParticle(
                  position: position,
                  radius: 0.1,
                  color:  p ,//randomColor(),
                  velocity: velocity
              )
          );
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: BackgroundPainter(
          repaint: animationNotifier,
              particles: particles
        ),
        child: widget.child,
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {

  ValueListenable repaint;
  List<CircleParticle> particles;

  BackgroundPainter({
    required this.repaint,
    required this.particles
  }):
        assert(repaint != null),
        super(repaint: repaint);



  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black);
    // print(repaint.value);
    if(repaint.value > 0) {
      for(var particle in particles) {
        var position = Offset(particle.position.x + size.width / 2, particle.position.y + size.height / 2);

        canvas.drawCircle(position, particle.radius, particle.color);


        particle.position += particle.velocity;
        particle.velocity = Vector2(particle.velocity.x * 1.1, particle.velocity.y * 1.1);//.rotate(pi * 4 /(180 ));
        particle.radius *= 1.03;
      }
    }



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class CircleParticle {
  Vector2 position;
  double radius;
  Paint color;
  Vector2 velocity;

  CircleParticle({
    required this.position,
    required this.radius,
    required this.color,
    required this.velocity,
  });
}

class Provider {
  static FrameLoop? _frameLoop;

  static FrameLoop frameLoop() {
    if(_frameLoop == null) {
      _frameLoop = FrameLoop(
        controller: StreamController.broadcast(),
      );
      _frameLoop!.start();
    }
    return _frameLoop!;
  }
}


enum FrameLoopStatus {
  running,
  stopped
}


class FrameLoop {

  late FrameLoopStatus status;
  final StreamController<double> controller;


  FrameLoop({
    required this.controller,
  }) {
    status = FrameLoopStatus.stopped;
  }

  void start() {
    if(status == FrameLoopStatus.stopped) {
      status = FrameLoopStatus.running;
      _loop();
    }
  }

  void stop() {
    if(status == FrameLoopStatus.running) {
      status = FrameLoopStatus.stopped;
    }
  }

  void close() {
    controller.close();
  }

  int _lastTime = 0;

  void _loop() {
    if(status == FrameLoopStatus.running) {
      SchedulerBinding.instance?.scheduleFrameCallback((Duration timeStamp) {
        int time = timeStamp.inMilliseconds;
        double deltaTime = (time - _lastTime) / 1000;
        _lastTime = time;
        controller.add(deltaTime);
        _loop();
      });
    } else if(status == FrameLoopStatus.stopped) {
      _lastTime = 0;
    }
  }
}