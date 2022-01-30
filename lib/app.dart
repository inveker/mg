import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_garden/bloc/frame/frame_bloc.dart';
import 'package:meta_garden/bloc/nft/nft_bloc.dart';
import 'package:meta_garden/bloc/ticker/ticker_bloc.dart';
import 'package:meta_garden/flower/flower.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/pages/nft_creator_page.dart';
import 'package:meta_garden/pages/nft_generator_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Bloc(
      child: _App(),
    );
  }
}

class _Bloc extends StatelessWidget {
  final Widget child;

  const _Bloc({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FrameBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TickerBloc(),
        ),
        BlocProvider(
          create: (context) => NftBloc(nft: Nft(flower: Flower.random())),
        ),
      ],
      child: child,
    );
  }
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'creator',
      routes: {
        'creator': (context) => NftCreatorPage(),
        'builder': (context) => NftGeneratorPage(),
      },
    );
  }
}
