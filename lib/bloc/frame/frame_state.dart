part of 'frame_bloc.dart';

class FrameState extends Equatable {
  late final int currentFrame;
  late final int frameRate;
  double get frameTime => 1000 / frameRate;
  late final int allTime;
  late final int allFrames;
  late final double time;

  FrameState({
    int? currentFrame,
    int? frameRate,
    int? allTime,
    int? allFrames,
    double? time,
  }) {
    this.currentFrame = currentFrame ?? 0;
    this.frameRate = frameRate ?? 60;
    this.allTime = allTime ?? 10;
    this.allFrames = allFrames ?? (this.allTime * this.frameRate);
    this.time = time ?? 0;
  }



  FrameState copyWith({
    int? currentFrame,
    int? frameRate,
    int? allTime,
    int? allFrames,
    double? time,
  }) {
    return FrameState(
      currentFrame: currentFrame ?? this.currentFrame,
      frameRate: frameRate ?? this.frameRate,
      allTime: allTime ?? this.allTime,
      allFrames: allFrames ?? this.allFrames,
      time: time ?? this.time,
    );
  }

  @override
  List<Object> get props => [
        currentFrame,
        frameRate,
        frameTime,
        allTime,
        allFrames,
        time,
      ];
}
