import 'package:meta_garden/flower/dimension/dimension.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class DimensionAsync extends Dimension {
  DimensionAsync.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  DimensionAsync({
    required bool isRandom,
    required double angleX,
    required double angleY,
    required double angleZ,
  }) : super(
    isRandom: isRandom,
    angleX: angleX,
    angleDirX: 1,
    angleY: angleY,
    angleDirY: 1,
    angleZ: angleZ,
    angleDirZ: 1,
  );

  factory DimensionAsync.random() {
    return DimensionAsync(
      isRandom: random.nextBool(),
      angleX: (30.0 + random.nextInt(150)),
      angleY: (30.0 + random.nextInt(150)),
      angleZ: (30.0 + random.nextInt(150)),
    );
  }

  late Map<FlowerParticle, Map<String, num>> _particliesRotation = {};

  @override
  void update(Scene context, double dt) {
    context.particles.toList().forEach((p) {
      if(p.freezed) return;
      if(_particliesRotation[p] == null) {
        var x = angleX == 0 ? 0 : (random.nextInt(angleX!.toInt()));
        var y = angleY == 0 ? 0 : (random.nextInt(angleY!.toInt()));
        var z = angleZ == 0 ? 0 : (random.nextInt(angleZ!.toInt()));

        _particliesRotation[p] = {
          'angleX': x + 1,
          'dirX': random.sign(),
          'angleY': y + 1,
          'dirY': random.sign(),
          'angleZ': z + 1,
          'dirZ': random.sign(),
        };
      }
      if(isRandom!) {
        p.rotationX += random.nextInt(_particliesRotation[p]!['angleX']!.toInt()) * _particliesRotation[p]!['dirX']! * dt;
        p.rotationY += random.nextInt(_particliesRotation[p]!['angleY']!.toInt()) * _particliesRotation[p]!['dirY']! * dt;
        p.rotationZ += random.nextInt(_particliesRotation[p]!['angleZ']!.toInt()) * _particliesRotation[p]!['dirZ']! * dt;
      } else {
        p.rotationX += _particliesRotation[p]!['angleX']! * _particliesRotation[p]!['dirX']! * dt;
        p.rotationY += _particliesRotation[p]!['angleY']! * _particliesRotation[p]!['dirY']! * dt;
        p.rotationZ += _particliesRotation[p]!['angleZ']! * _particliesRotation[p]!['dirZ']! * dt;
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
    return DimensionAsync(
      isRandom: isRandom ?? this.isRandom!,
      angleX: angleX ?? this.angleX!,
      angleY: angleY ?? this.angleY!,
      angleZ: angleZ ?? this.angleZ!,
    );
  }
}
