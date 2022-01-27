import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/flower.dart';
import 'package:meta_garden/flower/palette.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/flower/vegetation.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/render_tiker.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/vector2.dart';
import 'package:meta_garden/widgets/controllers.dart';
import 'package:meta_garden/widgets/renderer.dart';
import 'package:neon/neon.dart';
import 'package:uuid/uuid.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late final ValueNotifier<double> notifier;
  late Scene _scene;

  late double _lastDt;

  late Nft nft;

  bool isPaused = false;

  @override
  void initState() {
    nft = Nft(
      flower: Flower.random(),
    );
    _scene = Scene(flower: nft.flower);

    _lastDt = 0;
    notifier = ValueNotifier(_lastDt);
    tickerNotifier.addListener(() {
      if (!isPaused) {
        notifier.value = tickerNotifier.value;
      }
      updateMovedPosition();
    });

    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  void changeVegetationRate(double rate) {
    nft = nft.copyWith(
      flower: nft.flower.copyWith(
        vegetation: Vegetation(rate: rate),
      ),
    );
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void next() {
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
    nft = nft.copyWith();
    _scene = Scene(flower: nft.flower);
    setState(() {});
  }

  void rebuild() {
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

    var file = File(r'C:\Users\User\AndroidStudioProjects\meta_garden\lib\'+nft.fileName+'.json');
    file..writeAsString(jsonEncode(nft.toJson()))..createSync(recursive: true);
  }

  void updateMovedPosition() {
    if (movedPosition != null) {
      movedPositions.add(movedPosition!);
    }
  }

  void saveMovedPosition() {
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

  List<Vector2> movedPositions = [];
  Vector2? movedPosition;
  @override
  Widget build(BuildContext context) {
    print('build main');
    return Padding(
      key: ValueKey(nft),
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 120),
              child: Neon(
                text: 'NFT CREATOR',
                color: Colors.blue,
                fontSize: 50,
                font: NeonFont.Cyberpunk,
                flickeringText: true,
                flickeringLetters: [0,1,2],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRect(
                      child: SizedBox(
                        width: Config.pictureWidth.toDouble(),
                        height: Config.pictureHeight.toDouble(),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTapDown: (e) {
                              // addBud(Vector2(e.localPosition.dx, e.localPosition.dy));
                            },
                            onPanUpdate: (e) {
                              setState(() {
                                movedPosition = Vector2(e.localPosition.dx, e.localPosition.dy);
                              });
                            },
                            onPanEnd: (e) {
                              saveMovedPosition();
                            },
                            child: Renderer(
                              scene: _scene,
                              repaint: notifier,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        nft: nft,
                        isRandomGrowth: nft.flower.growth.isRandom,
                        changeRandomGrowth: changeRandomGrowth,
                        plantType: nft.flower.bud.plantType,
                        changePlantType: changePlantType,
                        vegetationRate: nft.flower.vegetation.rate,
                        changeRate: changeVegetationRate,
                        next: next,
                        tickerController: tickerController,
                        colors: nft.flower.palette.colors,
                        updatePalette: updatePalette,
                        setPaletteName: setPaletteName,
                        paletteName: nft.flower.palette.name,
                        budRadius: nft.flower.bud.radius,
                        changeBudRadius: changeBudRadius,
                        budParticlesCount: nft.flower.bud.particlesCount,
                        changeBudParticlesCount: changeBudParticlesCount,
                        restart: restart,
                        rebuild: rebuild,
                        budInnerRadius: nft.flower.bud.innerRadius,
                        changeBudInnerRadius: changeBudInnerRadius,
                        save: save,
                        growthSpeed: nft.flower.growth.speed,
                        changeGrowthSpeed: changeGrowthSpeed,
                        rotationX: nft.flower.dimension.angleX! * nft.flower.dimension.angleDirX!.toInt(),
                        changeRotationX: changeRotationX,
                        rotationY: nft.flower.dimension.angleY! * nft.flower.dimension.angleDirY!.toInt(),
                        changeRotationY: changeRotationY,
                        rotationZ: nft.flower.dimension.angleZ! * nft.flower.dimension.angleDirZ!.toInt(),
                        changeRotationZ: changeRotationZ,
                        changeRandomDimension: changeRandomDimension,
                        isRandomDimension: nft.flower.dimension.isRandom!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Neon(
                text: 'META GARDEN',
                color: Colors.pink,
                fontSize: 36,
                font: NeonFont.Cyberpunk,
                flickeringText: true,
                flickeringLetters: [1,9],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
