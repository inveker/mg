import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta_garden/nft.dart';

part 'frame_state.dart';

class FrameBloc {

  late FrameState state;

  static FrameBloc? _instance;

  static FrameBloc get i => _instance!;

  factory FrameBloc({
    int? frameRate,
    int? allTime,
  }) {
    _instance ??= FrameBloc._(
        frameRate: frameRate,
        allTime: allTime,
      );
    return _instance!;
  }

  FrameBloc._({
    int? frameRate,
    int? allTime,
  }) {
    state = FrameState(
      frameRate: frameRate,
      allTime: allTime,
    );
  }

  void tick() {
    state = state.copyWith(
      time: state.time + state.frameTime,
      currentFrame: state.currentFrame + 1,
    );
  }

  void reset() {
    state = state.copyWith(
      time: 0,
      currentFrame: 0,
    );
  }

  void setFrameRate(int rate) {
    state = state.copyWith(
      frameRate: rate,
    );
  }
}
