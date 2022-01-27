import 'package:meta_garden/flower/dimension/dimension.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class DimensionAll extends Dimension {
  DimensionAll.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  DimensionAll({
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

  factory DimensionAll.random() {
    return DimensionAll(
      isRandom: random.nextBool(),
      angleX: (30.0 + random.nextInt(150)),
      angleY: (30.0 + random.nextInt(150)),
      angleZ: (30.0 + random.nextInt(150)),
      angleDirX: random.sign(),
      angleDirY: random.sign(),
      angleDirZ: random.sign(),
    );
  }

  @override
  void update(Scene context, double dt) {
    context.particles.toList().forEach((p) {
      if(p.freezed) return;
      if(isRandom!) {
        p.rotationX += angleX == 0 ? 0 : random.nextInt(angleX!.toInt()) * angleDirX! * dt;
        p.rotationY += angleY == 0 ? 0 : random.nextInt(angleY!.toInt()) * angleDirY! * dt;
        p.rotationZ += angleZ == 0 ? 0 : random.nextInt(angleZ!.toInt()) * angleDirZ! * dt;
      } else {
        p.rotationX += angleX! * angleDirX! * dt;
        p.rotationY += angleY! * angleDirY! * dt;
        p.rotationZ += angleZ! * angleDirZ! * dt;
      }
    });
  }

  @override
  Dimension copyWith({
    bool? isRandom,
    double? angleX,
    int? angleDirX,
    double? angleY,
    int? angleDirY,
    double? angleZ,
    int? angleDirZ,
  }) {
    return DimensionAll(
      isRandom: isRandom ?? this.isRandom!,
      angleX: angleX ?? this.angleX!,
      angleDirX: angleDirX ?? this.angleDirX!,
      angleY: angleY ?? this.angleY!,
      angleDirY: angleDirY ?? this.angleDirY!,
      angleZ: angleZ ?? this.angleZ!,
      angleDirZ: angleDirY ?? this.angleDirZ!,
    );
  }
}
