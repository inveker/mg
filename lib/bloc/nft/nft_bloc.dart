import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/flower.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/utils/vector2.dart';
import 'package:uuid/uuid.dart';

part 'nft_event.dart';

part 'nft_state.dart';

class NftBloc extends Bloc<NftEvent, NftState> {
  NftBloc({required Nft nft}) : super(NftState(nft: nft)) {
    on<NftSaveMovedPosition>(_saveMovedPosition);
    on<NftChangeVegetation>(_changeVegetation);
    on<NftNext>(_next);
    on<NftChangePalette>(_changePalette);
    on<NftChangeBud>(_changeBud);
    on<NftRestart>(_restart);
    on<NftRebuild>(_rebuild);
    on<NftAddBud>(_addBud);
    on<NftChangeGrowth>(_changeGrowth);
    on<NftSave>(_save);
    on<NftChangeDimension>(_changeDimension);
    on<NftChangeBudType>(_changeBudType);
    on<NftChangePetal>(_changePetal);
  }

  void _saveMovedPosition(NftSaveMovedPosition event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(state.copyWith(
      nft: nft.copyWith(
        flower: nft.flower.copyWith(
          bud: nft.flower.bud.copyWith(
            positions: [...nft.flower.bud.positions, event.value.first],
            movedPositions: [
              ...nft.flower.bud.movedPositions,
              event.value.sublist(1),
            ],
          ),
        ),
      ),
    ));
  }

  void _changeVegetation(NftChangeVegetation event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            vegetation: nft.flower.vegetation.copyWith(
              rate: event.rate,
            ),
          ),
        ),
      ),
    );
  }

  void _next(NftNext event, Emitter<NftState> emit) {
    final nft = state.nft;
    final flower = Flower.random();
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: flower.copyWith(
            bud: flower.bud.copyWith(
              positions: [Vector2(Config.pictureWidth / 2, Config.pictureHeight / 2)],
              movedPositions: [[]],
            ),
          ),
        ),
      ),
    );
  }

  void _changePalette(NftChangePalette event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            palette: nft.flower.palette.copyWith(
              colors: event.colors,
              name: event.name,
            ),
          ),
        ),
      ),
    );
  }

  void _changeBud(NftChangeBud event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            bud: nft.flower.bud.copyWith(
              radius: event.radius,
              particlesCount: event.particlesCount,
              innerRadius: event.innerRadius,
              plantType: event.plantType,
              isRandom: event.isRandom,
              isRandomSpeed: event.isRandomSpeed,
              speed: event.speed,
              angle: event.angle,
            ),
          ),
        ),
      ),
    );
  }

  void _restart(NftRestart event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(),
      ),
    );
  }

  void _rebuild(NftRebuild event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower:
          nft.flower.copyWith(
            bud: nft.flower.bud.copyWith(
              positions: [],
              movedPositions: [],
            ),
          ),
        ),
      ),
    );
  }

  void _addBud(NftAddBud event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            bud: nft.flower.bud.copyWith(
              positions: [...nft.flower.bud.positions, event.value],
              movedPositions: [
                ...nft.flower.bud.movedPositions,
                [],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeGrowth(NftChangeGrowth event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            growth: nft.flower.growth.copyWith(
              speed: event.speed,
              isRandom: event.isRandom,
            ),
          ),
        ),
      ),
    );
  }

  void _save(NftSave event, Emitter<NftState> emit) {
    final nft = state.nft;
    const uuid = Uuid();
    final newNft = nft.copyWith(
      fileName: uuid.v1(),
    );

    var file = File(r'C:\Users\User\AndroidStudioProjects\meta_garden\lib\images\' + nft.fileName + '.json');
    file
      ..writeAsString(jsonEncode(nft.toJson()))
      ..createSync(recursive: true);

    emit(
      state.copyWith(
        nft: newNft,
      ),
    );
  }

  void _changeDimension(NftChangeDimension event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            dimension: nft.flower.dimension.copyWith(
              isRandom: event.isRandom,
              angleX: event.angleX?.abs(),
              angleDirX: event.angleX?.sign.toInt(),
              angleY: event.angleY?.abs(),
              angleDirY: event.angleY?.sign.toInt(),
              angleZ: event.angleZ?.abs(),
              angleDirZ: event.angleZ?.sign.toInt(),
            ),
          ),
        ),
      ),
    );
  }

  void _changePetal(NftChangePetal event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            petal: nft.flower.petal.copyWith(
              isRandom: event.isRandom,
              angleX: event.angleX?.abs(),
              angleDirX: event.angleX?.sign.toInt(),
              angleY: event.angleY?.abs(),
              angleDirY: event.angleX?.sign.toInt(),
              angleZ: event.angleZ?.abs(),
              angleDirZ: event.angleX?.sign.toInt(),
            ),
          ),
        ),
      ),
    );
  }

  void _changeBudType(NftChangeBudType event, Emitter<NftState> emit) {
    final nft = state.nft;
    emit(
      state.copyWith(
        nft: nft.copyWith(
          flower: nft.flower.copyWith(
            bud: event.value.copyWith(
              positions: [Vector2(Config.pictureWidth / 2, Config.pictureHeight / 2)],
              movedPositions: [[]],
            ),
          ),
        ),
      ),
    );
  }
}
