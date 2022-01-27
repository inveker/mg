import 'package:meta_garden/flower/growth/growth.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class GrowthLinear extends Growth {
  GrowthLinear.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  GrowthLinear({
    required double speed,
    required bool isRandom,
  }) : super(
          speed: speed,
          isRandom: isRandom,
        );

  factory GrowthLinear.random() {
    return GrowthLinear(
      speed: 100.0 + random.nextInt(100),
      isRandom: random.nextBool(),
    );
  }

  // движение лепестков
  @override
  void update(Scene context, double dt) {
    context.particles.forEach((element) {
      if (element.freezed) {
        element.speed = 20;
      } else {
        if(isRandom) {
          element.speed = speed == 0 ? 0 : random.nextInt(speed.toInt()).toDouble();
        } else {
          element.speed = speed;
        }
      }
    });
  }

  @override
  Growth copyWith({
    double? speed,
    bool? isRandom,
  }) {
    return GrowthLinear(
      speed: speed ?? this.speed,
      isRandom: isRandom ?? this.isRandom,
    );
  }
}
