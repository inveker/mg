import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class BudCenter extends Bud {
  BudCenter.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  BudCenter({
    required int particlesCount,
    required List<Vector2> positions,
    required List<List<Vector2>> movedPositions,
    required PlantType plantType,
  }) : super(
          particlesCount: particlesCount,
          positions: positions,
    movedPositions: movedPositions,
    plantType: plantType,
        );

  var a = random.nextInt(100);

  factory BudCenter.random() {
    return BudCenter(
      particlesCount: 1 + random.nextInt(5),
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
      var position = currentPositions![random.nextInt(currentPositions!.length)];

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
    return BudCenter(
      particlesCount: particlesCount ?? this.particlesCount,
      positions: positions ?? this.positions,
      movedPositions: movedPositions ?? this.movedPositions,
      plantType: plantType ?? this.plantType,
    );
  }
}
