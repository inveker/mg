import 'package:meta_garden/flower/dimension/dimension.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class DimensionNot extends Dimension {
  DimensionNot.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  DimensionNot();
  @override
  void update(Scene context, double dt) {}

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
    return DimensionNot();
  }
}
