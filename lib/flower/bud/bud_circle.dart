import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class BudCircle extends Bud {
  BudCircle.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  BudCircle({
    required int particlesCount,
    required double radius,
    required double innerRadius,
    required List<Vector2> positions,
    required List<List<Vector2>> movedPositions,
    required PlantType plantType,
  }) : super(
          particlesCount: particlesCount,
          radius: radius,
          innerRadius: innerRadius,
          positions: positions,
    movedPositions: movedPositions,
    plantType: plantType,
        );

  factory BudCircle.random() {
    var radius = 30.0 + random.nextInt(71);
    return BudCircle(
      particlesCount: 3 + random.nextInt(8),
      radius: radius,
      innerRadius: random.nextInt((radius * 0.7).toInt()).toDouble(),
      positions: [],
      movedPositions: [],
      plantType: PlantType.random(),
    );
  }

  @override
  void generate(Scene context, double dt) {
    super.generate(context, dt);
    if(currentPositions!.isEmpty) return;
    for (var i = 0; i < particlesCount; i++) {
      var position;
      if(context.flower.bud.isPlant) {
        position = currentPositions![random.nextInt(currentPositions!.length)];
      } else {
        position = Vector2.random() * (random.nextInt(radius!.toInt()) + innerRadius!.toInt()) + currentPositions![random.nextInt(currentPositions!.length)];
      }

      context.particles.add(
        FlowerParticle(
          colors: context.flower.palette.colors,
          position: position,
        ),
      );
    }
  }

  @override
  Bud copyWith({
    int? particlesCount,
    double? radius,
    double? innerRadius,
    List<Vector2>? positions,
    PlantType? plantType,
    List<List<Vector2>>? movedPositions,
    Vector2? velocity,
    double? speed,
    double? angle,
  }) {
    return BudCircle(
      particlesCount: particlesCount ?? this.particlesCount,
      radius: radius ?? this.radius!,
      innerRadius: innerRadius ?? this.innerRadius!,
      positions: positions ?? this.positions,
      movedPositions: movedPositions ?? this.movedPositions,
      plantType: plantType ?? this.plantType,
    );
  }
}
