import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta_garden/bloc/frame/frame_bloc.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/scene.dart';

import '../main.dart';
import 'package:image/image.dart' as img;

class CompileScreen extends StatefulWidget {
  @override
  _CompileScreenState createState() => _CompileScreenState();
}

class _CompileScreenState extends State<CompileScreen> {

  @override
  void initState() {
    recorderFromSavedApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Compile')),
    );
  }
}


Future<void> recorderFromSavedApp() async {

  FrameBloc.i.setFrameRate(50);

  var time = DateTime.now().millisecondsSinceEpoch;
  var dir = Directory(r'C:\Users\User\AndroidStudioProjects\meta_garden\lib\images\');
  var files = dir.listSync().whereType<File>().where((element) => element.path.split('.').last == 'json');

  final double imageWidth = Config.pictureWidth.toDouble();
  final double imageHeight = Config.pictureHeight.toDouble();

  for(var file in files) {
    Nft savedNft = Nft.fromJson(jsonDecode(file.readAsStringSync()));
    var localTime = DateTime.now().millisecondsSinceEpoch;
    String nftName = savedNft.fileName;
    print('RecordedApp $nftName');

    var dirPath = 'C:/Users/User/AndroidStudioProjects/meta_garden/lib/images/${nftName}';
    var q = 1;
    while(Directory(dirPath).existsSync()) {
      dirPath = 'C:/Users/User/AndroidStudioProjects/meta_garden/lib/images/${q}_${nftName}';
      q++;
    }
    Directory(dirPath).createSync();

    Scene scene = Scene(
      flower: savedNft.flower,
    );

    for(var i = 0; i < FrameBloc.i.state.allFrames; i++) {
      await Future.delayed(Duration(milliseconds: FrameBloc.i.state.frameTime.toInt()), () async {
        final recorder = PictureRecorder();
        final canvas = Canvas(recorder, new Rect.fromLTWH(0.0, 0.0, imageWidth, imageHeight));
        scene.paint(canvas, Size(imageWidth, imageHeight));
        scene.update(FrameBloc.i.state.frameTime / 1000);
        final picture = recorder.endRecording();
        final img = await picture.toImage(imageWidth.toInt(), imageHeight.toInt());
        var pngBytes = await img.toByteData(format: ImageByteFormat.png );
        File file = File('${dirPath}/img${i}.png');
        file
          ..writeAsBytes(pngBytes!.buffer.asInt8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes))
          ..createSync(recursive: true);

        print('${(i)  / (FrameBloc.i.state.allFrames) * 100}%');
      });
    }
    print('Success: ${DateTime.now().millisecondsSinceEpoch - localTime}');

  }

  print('All success: ${(DateTime.now().millisecondsSinceEpoch - time) / 1000}sec');
  print('AVG time: ${(DateTime.now().millisecondsSinceEpoch - time) / files.length}ms');
}
