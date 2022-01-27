import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/utils/vector2.dart';

class BudBindweed extends Bud {
  late Vector2 currentVelocity;

  BudBindweed.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  BudBindweed({
    required int particlesCount,
    required List<Vector2> positions,
    required List<List<Vector2>> movedPositions,
    required Vector2 velocity,
    required double speed,
    required double angle,
    required PlantType plantType,
  }) : super(
          particlesCount: particlesCount,
          positions: positions,
          movedPositions: movedPositions,
          velocity: velocity,
          speed: speed,
          angle: angle,
          plantType: plantType,
        ) {
    currentVelocity = velocity.copy();
  }


  factory BudBindweed.random() {
    return BudBindweed(
        particlesCount: 1 + random.nextInt(5),
        positions: [],
        movedPositions: [],
        velocity: Vector2.random(),
        speed: 150.0,
        angle: 360,
      plantType: PlantType.random(),
        );
  }

  @override
  void generate(Scene context, double dt) {
    super.generate(context, dt);
    if (currentPositions!.isEmpty) return;
    currentVelocity = currentVelocity.rotate(radians(angle! * dt));

    for (var i = 0; i < currentPositions!.length; i++) {

      currentPositions![i] += currentVelocity * speed! * dt;
    }

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
    return BudBindweed(
      particlesCount: particlesCount ?? this.particlesCount,
      positions: positions ?? this.positions,
      movedPositions: movedPositions ?? this.movedPositions,
      velocity: velocity ?? this.velocity!,
      speed: speed ?? this.speed!,
      angle: angle ?? this.angle!,
      plantType: plantType ?? this.plantType,
    );
  }
}
