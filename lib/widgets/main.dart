import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/flower.dart';
import 'package:meta_garden/flower/palette.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/flower/vegetation.dart';
import 'package:meta_garden/main.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/vector2.dart';
import 'package:meta_garden/widgets/canvas_viewport.dart';
import 'package:meta_garden/widgets/controllers.dart';
import 'package:meta_garden/widgets/renderer.dart';
import 'package:neon/neon.dart';
import 'package:uuid/uuid.dart';

Nft nft = Nft(flower: Flower.random());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late final ValueNotifier<double> notifier;
  late Scene _scene;

  late double _lastDt = 0;

  bool isPaused = false;

  late Ticker renderTicker;

  @override
  void initState() {
    FrameManager.frameRate = 60;
    FrameManager.reset();
    notifier = ValueNotifier(_lastDt);

    renderTicker = Ticker((elapsed) {
      int time = elapsed.inMilliseconds;
      var ms = time / 1000;
      double deltaTime = ms - _lastDt;
      _lastDt = ms;
      if (!isPaused) {
        FrameManager.tick();
        notifier.value = deltaTime;
      }
      updateMovedPosition();
    });

    renderTicker.start();

    nft = Nft(
      flower: Flower.random(),
    );
    _scene = Scene(flower: nft.flower);

    super.initState();
  }

  @override
  void dispose() {
    FrameManager.reset();
    renderTicker.dispose();
    notifier.dispose();
    super.dispose();
  }

  void changeVegetationRate(double rate) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        vegetation: Vegetation(rate: rate),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void next() {
    FrameManager.reset();
    var flower = Flower.random();
    nft = nft.copyWith(
        flower: flower.copyWith(
            bud: flower.bud.copyWith(
              positions: [Vector2(Config.pictureWidth / 2, Config.pictureHeight / 2)],
              movedPositions: [[]],
            )));
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void tickerController() {
    isPaused = !isPaused;
    // _scene.isStop = !_scene.isStop;
    setState(() {

    });
  }

  void updatePalette(List<Color> colors) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        palette: Palette(colors: colors),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void setPaletteName(String name) {
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        palette: nft.flower.palette.copyWith(
          name: name,
        ),
      ),
    );
  }

  void changeBudRadius(double radius) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          radius: radius,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeBudParticlesCount(int count) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          particlesCount: count,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void restart() {
    FrameManager.reset();
    nft = nft.copyWith();
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void rebuild() {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          positions: [],
          movedPositions: [],
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void addBud(Vector2 position) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          positions: [...nft.flower.bud.positions, position],
          movedPositions: [
            ...nft.flower.bud.movedPositions,
            [],
          ],
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeBudInnerRadius(double innerRadius) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          innerRadius: innerRadius,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeGrowthSpeed(double speed) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        growth: nft.flower.growth.copyWith(
          speed: speed,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void save() {
    const uuid = Uuid();
    nft = nft.copyWith(
      fileName: uuid.v1(),
    );

    var file = File(r'C:\Users\User\AndroidStudioProjects\meta_garden\lib\images\'+nft.fileName+'.json');
    file..writeAsString(jsonEncode(nft.toJson()))..createSync(recursive: true);
  }

  void updateMovedPosition() {
    if (movedPosition != null) {
      movedPositions.add(movedPosition!);
    }
  }

  void saveMovedPosition() {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          positions: [...nft.flower.bud.positions, movedPositions.first],
          movedPositions: [
            ...nft.flower.bud.movedPositions,
            movedPositions.sublist(1),
          ],
        ),
      ),
    );
    movedPositions = [];
    movedPosition = null;
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRotationX(double angle) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        dimension: nft.flower.dimension.copyWith(
          angleX: angle.abs(),
          angleDirX: angle.sign.toInt(),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRotationY(double angle) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        dimension: nft.flower.dimension.copyWith(
          angleY: angle.abs(),
          angleDirY: angle.sign.toInt(),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRotationZ(double angle) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        dimension: nft.flower.dimension.copyWith(
          angleZ: angle.abs(),
          angleDirZ: angle.sign.toInt(),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRandomDimension(bool value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        dimension: nft.flower.dimension.copyWith(
          isRandom: value,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changePlantType(String value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          plantType: PlantType.fromJson({'value': value}),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRandomGrowth(bool value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        growth: nft.flower.growth.copyWith(
          isRandom: value,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRandomPetalDimension(bool value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        petal: nft.flower.petal.copyWith(
          isRandom: value,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changePetalRotationX(double value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        petal: nft.flower.petal.copyWith(
          angleX: value.abs(),
          angleDirX: value.sign.toInt(),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changePetalRotationY(double value) {
    FrameManager.reset();
    setState(() {
      nft = nft.copyWith(
        flower: nft.flower.copyWith(
          petal: nft.flower.petal.copyWith(
            angleY: value.abs(),
            angleDirY: value.sign.toInt(),
          ),
        ),
      );

      _scene = Scene(flower: nft.flower);
    });
  }

  void changePetalRotationZ(double value) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        petal: nft.flower.petal.copyWith(
          angleZ: value.abs(),
          angleDirZ: value.sign.toInt(),
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeBudType(Bud bud) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: bud.copyWith(
          positions: [Vector2(Config.pictureWidth / 2, Config.pictureHeight / 2)],
          movedPositions: [[]],
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeBudAngle(double angle) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          angle: angle,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeBudSpeed(double speed) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          speed: speed,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRandomBud(bool isRandom) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          isRandom: isRandom,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void changeRandomSpeedBud(bool isRandom) {
    FrameManager.reset();
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        bud: nft.flower.bud.copyWith(
          isRandomSpeed: isRandom,
        ),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  List<Vector2> movedPositions = [];
  Vector2? movedPosition;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(nft),
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CanvasViewport(),
                  const SizedBox(
                    width: 60,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: Config.pictureWidth.toDouble() - 30,
                      height: 600,
                      color: Color(0xFFF3F4F8),
                      padding: EdgeInsets.all(20),
                      child: Controllers(
                        // nft: nft,
                        // isRandomGrowth: nft.flower.growth.isRandom,
                        // changeRandomGrowth: changeRandomGrowth,
                        // plantType: nft.flower.bud.plantType,
                        // changePlantType: changePlantType,
                        // vegetationRate: nft.flower.vegetation.rate,
                        // changeRate: changeVegetationRate,
                        // next: next,
                        // tickerController: tickerController,
                        // colors: nft.flower.palette.colors,
                        // updatePalette: updatePalette,
                        // setPaletteName: setPaletteName,
                        // paletteName: nft.flower.palette.name,
                        // budRadius: nft.flower.bud.radius,
                        // changeBudRadius: changeBudRadius,
                        // budParticlesCount: nft.flower.bud.particlesCount,
                        // changeBudParticlesCount: changeBudParticlesCount,
                        // restart: restart,
                        // rebuild: rebuild,
                        // budInnerRadius: nft.flower.bud.innerRadius,
                        // changeBudInnerRadius: changeBudInnerRadius,
                        // save: save,
                        // growthSpeed: nft.flower.growth.speed,
                        // changeGrowthSpeed: changeGrowthSpeed,
                        // rotationX: nft.flower.dimension.angleX! * nft.flower.dimension.angleDirX!.toInt(),
                        // changeRotationX: changeRotationX,
                        // rotationY: nft.flower.dimension.angleY! * nft.flower.dimension.angleDirY!.toInt(),
                        // changeRotationY: changeRotationY,
                        // rotationZ: nft.flower.dimension.angleZ! * nft.flower.dimension.angleDirZ!.toInt(),
                        // changeRotationZ: changeRotationZ,
                        // changeRandomDimension: changeRandomDimension,
                        // isRandomDimension: nft.flower.dimension.isRandom!,
                        // changePetalRotationX: changePetalRotationX,
                        // changePetalRotationY: changePetalRotationY,
                        // changePetalRotationZ: changePetalRotationZ,
                        // changeRandomPetalDimension: changeRandomPetalDimension,
                        // changeBudType: changeBudType,
                        // changeBudAngle: changeBudAngle,
                        // changeBudSpeed: changeBudSpeed,
                        // changeRandomBud: changeRandomBud,
                        // changeRandomSpeedBud: changeRandomSpeedBud,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
