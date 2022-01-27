import 'package:meta_garden/flower/growth/growth_linear.dart';
import 'package:meta_garden/scene.dart';

abstract class Growth {
  late final double speed;
  late final bool isRandom;

  // движение лепестков
  void update(Scene context, double dt) {}

  Growth({
    required this.speed,
    required this.isRandom,
  });

  Growth.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    isRandom = json['isRandom'];
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'isRandom': isRandom,
    };
  }

  Growth copyWith({
    double? speed,
    bool? isRandom,
  });

  static List<Growth Function()> builders = [
    () => GrowthLinear.random(),
  ];

  factory Growth.random() {
    return builders[0]();
    // return builders[random.nextInt(builders.length)]();
  }
}
