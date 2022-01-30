import 'package:meta_garden/flower/dimension/dimension_all.dart';
import 'package:meta_garden/flower/dimension/dimension_async.dart';
import 'package:meta_garden/flower/dimension/dimension_not.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

abstract class Dimension {
  late final bool? isRandom;
  late final double? angleX;
  late final int? angleDirX;
  late final double? angleY;
  late final int? angleDirY;
  late final double? angleZ;
  late final int? angleDirZ;
  late final String type;

  Dimension({
    this.isRandom,
    this.angleX,
    this.angleDirX,
    this.angleY,
    this.angleDirY,
    this.angleZ,
    this.angleDirZ,
  }) {
    type = runtimeType.toString();
  }


  Dimension.fromJson(Map<String, dynamic> json) {
    isRandom = json['isRandom'];
    angleX = json['angleX'];
    angleDirX = json['angleDirX'];
    angleY = json['angleY'];
    angleDirY = json['angleDirY'];
    angleZ = json['angleZ'];
    angleDirZ = json['angleDirZ'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'isRandom': isRandom,
      'angleX': angleX,
      'angleDirX': angleDirX,
      'angleY': angleY,
      'angleDirY': angleDirY,
      'angleZ': angleZ,
      'angleDirZ': angleDirZ,
      'type': type,
    };
  }

  Dimension copyWith({
    bool? isRandom,
    double? angleX,
    int? angleDirX,
    double? angleY,
    int? angleDirY,
    double? angleZ,
    int? angleDirZ,
});
  // {
  //   return Dimension(
  //     isRandom: isRandom ?? this.isRandom,
  //     angleX: angleX ?? this.angleX,
  //     angleDirX: angleDirX ?? this.angleDirX,
  //     angleY: angleY ?? this.angleY,
  //     angleDirY: angleDirY ?? this.angleDirY,
  //     angleZ: angleZ ?? this.angleZ,
  //     angleDirZ: angleDirY ?? this.angleDirZ,
  //   );


  void update(Scene context, double dt) {}

  static List<Dimension Function()> builders = [
    () => DimensionAll.random(),
    () => DimensionAsync.random(),
  ];

  factory Dimension.random() {
    return builders.rand()();
  }
}
