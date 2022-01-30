import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/bud/bud_bindweed.dart';
import 'package:meta_garden/flower/bud/bud_circle.dart';
import 'package:meta_garden/flower/day_type.dart';
import 'package:meta_garden/flower/dimension/dimension.dart';
import 'package:meta_garden/flower/dimension/dimension_all.dart';
import 'package:meta_garden/flower/dimension/dimension_not.dart';
import 'package:meta_garden/flower/growth/growth.dart';
import 'package:meta_garden/flower/growth/growth_linear.dart';
import 'package:meta_garden/flower/petal/petal.dart';
import 'package:meta_garden/flower/petal/petal_circle.dart';
import 'package:meta_garden/flower/petal/petal_square.dart';
import 'package:meta_garden/flower/petal/petal_triangle.dart';
import 'package:meta_garden/flower/vegetation.dart';
import 'bud/bud_center.dart';
import 'bud/bud_circle_border.dart';
import 'dimension/dimension_async.dart';
import 'palette.dart';

class Flower {
  final Bud bud;
  final Palette palette;
  final Petal petal;
  final Dimension dimension;
  final Growth growth;
  final DayType dayType;
  final Vegetation vegetation;

  Flower({
    required this.bud,
    required this.palette,
    required this.petal,
    required this.dimension,
    required this.growth,
    required this.dayType,
    required this.vegetation,
  });

  factory Flower.random() {
    return Flower(
      bud: Bud.random(),
      palette: Palette.random(),
      petal: Petal.random(),
      dimension: Dimension.random(),
      growth: Growth.random(),
      dayType: DayType.random(),
      vegetation: Vegetation.random(),
    );
  }

  factory Flower.fromJson(Map<String, dynamic> json) {

    final budType = json['bud']['type'];
    late Bud bud;
    if(budType == 'BudBindweed') bud = BudBindweed.fromJson(json['bud']);
    else if(budType == 'BudCenter') bud = BudCenter.fromJson(json['bud']);
    else if(budType == 'BudCircle') bud = BudCircle.fromJson(json['bud']);
    else if(budType == 'BudCircleBorder') bud = BudCircleBorder.fromJson(json['bud']);

    final petalType = json['petal']['type'];
    late Petal petal;
    if(petalType == 'PetalCircle') petal = PetalCircle.fromJson(json['petal']);
    else if(petalType == 'PetalSquare') petal = PetalSquare.fromJson(json['petal']);
    else if(petalType == 'PetalTriangle') petal = PetalTriangle.fromJson(json['petal']);

    final dimensionType = json['dimension']['type'];
    late Dimension dimension;
    if(dimensionType == 'DimensionNot') dimension = DimensionNot.fromJson(json['dimension']);
    else if(dimensionType == 'DimensionAll') dimension = DimensionAll.fromJson(json['dimension']);
    else if(dimensionType == 'DimensionAsync') dimension = DimensionAsync.fromJson(json['dimension']);

    final growthType = json['growth']['type'];
    late Growth growth;
    if(growthType == 'GrowthLinear') growth = GrowthLinear.fromJson(json['growth']);


    return Flower(
      bud: bud,
      palette: Palette.fromJson(json['palette']),
      petal: petal,
      dimension: dimension,
      growth: growth,
      dayType: DayType.fromJson(json['dayType']),
      vegetation: Vegetation.fromJson(json['vegetation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bud': bud.toJson(),
      'palette': palette.toJson(),
      'petal': petal.toJson(),
      'dimension': dimension.toJson(),
      'growth': growth.toJson(),
      'dayType': dayType.toJson(),
      'vegetation': vegetation.toJson(),
    };
  }

  Flower copyWith({
    Bud? bud,
    Palette? palette,
    Petal? petal,
    Dimension? dimension,
    Growth? growth,
    DayType? dayType,
    Vegetation? vegetation,
  }) {
    return Flower(
      bud: bud ?? this.bud.copyWith(),
      palette: palette ?? this.palette,
      petal: petal ?? this.petal,
      dimension: dimension ?? this.dimension,
      growth: growth ?? this.growth,
      dayType: dayType ?? this.dayType,
      vegetation: vegetation ?? this.vegetation,
    );
  }
}
