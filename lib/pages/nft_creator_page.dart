import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_garden/bloc/nft/nft_bloc.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/widgets/canvas_viewport.dart';
import 'package:meta_garden/widgets/controllers.dart';
import 'package:meta_garden/widgets/main.dart';
import 'package:meta_garden/widgets/main_background.dart';
import 'package:neon/neon.dart';

class NftCreatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MainBackground(
              child: Center(),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  _NeonHeader(),
                  const SizedBox(height: 40),
                  _Main(),
                  const SizedBox(height: 40),
                  _NeonFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _NeonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neon(
      key: ValueKey('neon1'),
      text: 'NFT CREATOR',
      color: Colors.blue,
      fontSize: 50,
      font: NeonFont.Cyberpunk,
      flickeringText: true,
      flickeringLetters: [0,1,2],
    );
  }
}

class _NeonFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neon(
      key: ValueKey('neon2'),
      text: 'META   GARDEN',
      color: Colors.pink,
      fontSize: 36,
      font: NeonFont.Cyberpunk,
      flickeringText: true,
      flickeringLetters: [1,9],
    );
  }
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      builder: (context, state) {
        return Row(
          key: ValueKey(state.nft),
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
                decoration: BoxDecoration(
                  color: Color(0xFFF3F4F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(20),
                child: Controllers(),
              ),
            ),
          ],
        );
      },
    );
  }
}