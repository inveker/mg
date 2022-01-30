part of 'nft_bloc.dart';

abstract class NftEvent {
  const NftEvent();
}

class NftSaveMovedPosition extends NftEvent {
  final List<Vector2> value;

  NftSaveMovedPosition(this.value);
}

class NftChangeVegetation extends NftEvent {
  final double? rate;

  NftChangeVegetation({
    this.rate,
  });
}

class NftNext extends NftEvent {
  const NftNext();
}

class NftChangePalette extends NftEvent {
  final List<Color>? colors;
  final String? name;

  NftChangePalette({
    this.colors,
    this.name,
  });
}

class NftSetPaletteName extends NftEvent {
  final String value;

  NftSetPaletteName(this.value);
}

class NftChangeBud extends NftEvent {
  final double? radius;
  final int? particlesCount;
  final double? innerRadius;
  final PlantType? plantType;
  final bool? isRandom;
  final bool? isRandomSpeed;
  final double? speed;
  final double? angle;

  NftChangeBud({
    this.radius,
    this.particlesCount,
    this.innerRadius,
    this.plantType,
    this.isRandom,
    this.isRandomSpeed,
    this.speed,
    this.angle,
  });
}

class NftRestart extends NftEvent {
  const NftRestart();
}

class NftRebuild extends NftEvent {
  const NftRebuild();
}

class NftAddBud extends NftEvent {
  final Vector2 value;

  NftAddBud(this.value);
}

class NftChangeBudInnerRadius extends NftEvent {
  final double value;

  NftChangeBudInnerRadius(this.value);
}

class NftChangeGrowth extends NftEvent {
  final double? speed;
  final bool? isRandom;

  NftChangeGrowth({
    this.speed,
    this.isRandom,
  });
}

class NftSave extends NftEvent {
  const NftSave();
}

class NftChangePetal extends NftEvent {
  final bool? isRandom;
  final double? angleX;
  final double? angleY;
  final double? angleZ;

  NftChangePetal({
    this.isRandom,
    this.angleX,
    this.angleY,
    this.angleZ,
  });
}
class NftChangeDimension extends NftEvent {
  final bool? isRandom;
  final double? angleX;
  final double? angleY;
  final double? angleZ;

  NftChangeDimension({
    this.isRandom,
    this.angleX,
    this.angleY,
    this.angleZ,
  });
}
class NftChangeBudType extends NftEvent {
  final Bud value;
  NftChangeBudType(this.value);
}
