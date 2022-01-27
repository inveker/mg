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
import 'package:meta_garden/widgets/main.dart';
import 'package:meta_garden/widgets/main_background.dart';
import 'package:meta_garden/widgets/renderer.dart';
import 'package:uuid/uuid.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    renderTicker.start();
    super.initState();
  }

  @override
  void dispose() {
    renderTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: MainBackground(key: ValueKey('111'),child: Center(),)),
            Positioned.fill(
              child: Main(),
            ),
          ],
        ),
      ),
    );
  }
}
