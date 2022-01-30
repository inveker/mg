import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_garden/bloc/ticker/ticker_bloc.dart';
import 'package:meta_garden/utils/vector2.dart';
import '../bloc/nft/nft_bloc.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/widgets/renderer.dart';

class CanvasViewport extends StatefulWidget {
  const CanvasViewport({
    Key? key,
  }) : super(key: key);

  @override
  State<CanvasViewport> createState() => _CanvasViewportState();
}

class _CanvasViewportState extends State<CanvasViewport> {
  late final ValueNotifier<double> _notifier;

  @override
  void initState() {
    _notifier = ValueNotifier(0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TickerBloc, TickerState>(
      listener: (context, state) {
        if (!state.isPaused) {
          _notifier.value = state.dt;
        }
      },
      child: _Decoration(
        child: _Controllers(
          child: BlocBuilder<NftBloc, NftState>(
            buildWhen: (p, n) => p.nft != n.nft,
            builder: (context, state) {
              return Renderer(
                key: ValueKey(state.nft),
                scene: Scene(
                  flower: state.nft.flower,
                ),
                repaint: _notifier,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Controllers extends StatefulWidget {
  final Widget child;

  const _Controllers({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<_Controllers> createState() => _ControllersState();
}

class _ControllersState extends State<_Controllers> {
  Vector2? _movedPosition;
  late List<Vector2> _movedPositions;
  NftBloc? _nftBloc;

  @override
  void initState() {
    _movedPositions = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nftBloc ??= context.read<NftBloc>();
    return BlocListener<TickerBloc, TickerState>(
      listener: (context, state) {
        if (_movedPosition != null) {
          _movedPositions.add(_movedPosition!);
          _movedPosition = null;
        }
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: widget.child,
      ),
    );
  }

  void _onTapDown(TapDownDetails e) {
    // addBud(Vector2(e.localPosition.dx, e.localPosition.dy));
  }

  void _onPanUpdate(DragUpdateDetails e) {
    setState(() {
      _movedPosition = Vector2(e.localPosition.dx, e.localPosition.dy);
    });
  }

  void _onPanEnd(DragEndDetails e) {
    _nftBloc!.add(NftSaveMovedPosition(_movedPositions));
  }
}

class _Decoration extends StatelessWidget {
  final Widget child;

  const _Decoration({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: child,
          ),
        ),
      ),
    );
  }
}
