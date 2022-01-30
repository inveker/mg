part of 'frame_bloc.dart';

abstract class FrameEvent {
  const FrameEvent();
}


class FrameTicked extends FrameEvent {
  const FrameTicked();
}

class FrameReset extends FrameEvent {
  const FrameReset();
}