import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/widgets/main.dart';

class Vegetation {
  late final double rate;

  Vegetation({
    required this.rate,
  });

  factory Vegetation.random() {
    return Vegetation(
      rate: 2.0 + random.nextInt(5),
    );
  }

  Vegetation copyWith({double? rate}) {
    return Vegetation(
      rate: rate ?? this.rate,
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
      if (nft.flower.bud.g2) return;
      if (!p.freezed) p.width += (p.width) * rate * dt;
    }
  }
}
