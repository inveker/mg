import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class Vegetation {
  late final double rate;

  Vegetation({
    required this.rate,
  });

  factory Vegetation.random() {
    return Vegetation(
      rate: 3.0 + random.nextInt(5),
    );
  }

  Vegetation.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
    };
  }

  void update(Scene context, double dt) {
    for (var p in context.particles) {
      if(!p.freezed)
      p.width += (p.width) * rate * dt;
    }
  }
}