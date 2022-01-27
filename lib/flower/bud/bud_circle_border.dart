import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class BudCircleBorder extends Bud {
  BudCircleBorder.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  BudCircleBorder({
    required int particlesCount,
    required double radius,
    required List<Vector2> positions,
    required List<List<Vector2>> movedPositions,
    required PlantType plantType,
  }) : super(
          particlesCount: particlesCount,
          radius: radius,
    positions: positions,
    movedPositions: movedPositions,
    plantType: plantType,
        );

  factory BudCircleBorder.random() {
    return BudCircleBorder(
      particlesCount: 3 + random.nextInt(8),
      radius: 30.0 + random.nextInt(71),
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
        position = Vector2.random() * radius! + currentPositions![random.nextInt(currentPositions!.length)];
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
    return BudCircleBorder(
      particlesCount: particlesCount ?? this.particlesCount,
      radius: radius ?? this.radius!,
      positions: positions ?? this.positions,
      movedPositions: movedPositions ?? this.movedPositions,
      plantType: plantType ?? this.plantType,
    );
  }
}
