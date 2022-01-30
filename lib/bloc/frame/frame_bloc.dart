import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/nft.dart';

part 'frame_event.dart';

part 'frame_state.dart';

class FrameBloc extends Bloc<FrameEvent, FrameState> {
  FrameBloc({
    int? frameRate,
    int? allTime,
  }) : super(FrameState(
          frameRate: frameRate,
          allTime: allTime,
        )) {
    on<FrameTicked>(_tick);
    on<FrameReset>(_reset);
  }

  void _tick(FrameTicked event, Emitter<FrameState> emit) {
    emit(state.copyWith(
      time: state.time + state.frameTime,
      currentFrame: state.currentFrame + 1,
    ));
  }

  void _reset(FrameReset event, Emitter<FrameState> emit) {
    emit(state.copyWith(
      time: 0,
      currentFrame: 0,
    ));
  }
}
