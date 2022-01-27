import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/flower.dart';

class Nft {
  final Flower flower;
  final String fileName;
  final int startFrame;
  final int pictureWidth;
  final int pictureHeight;

  Nft({
    required this.flower,
    this.fileName = 'unknown',
    this.startFrame = 0,
    this.pictureWidth = Config.pictureWidth,
    this.pictureHeight = Config.pictureHeight,
  });

  factory Nft.fromJson(Map<String, dynamic> json) {
    return Nft(
      flower: Flower.fromJson(json['flower']),
      fileName: json['fileName'],
      startFrame: json['startFrame'],
      pictureWidth: json['pictureWidth'],
      pictureHeight: json['pictureHeight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flower': flower.toJson(),
      'fileName': fileName,
      'startFrame': startFrame,
      'pictureWidth': pictureWidth,
      'pictureHeight': pictureHeight,
    };
  }

  Nft copyWith({
    Flower? flower,
    String? fileName,
    int? startFrame,
    int? pictureWidth,
    int? pictureHeight,
  }) {
    return Nft(
      flower: flower ?? this.flower.copyWith(),
      fileName: fileName ?? this.fileName,
      startFrame: startFrame ?? this.startFrame,
      pictureWidth: pictureWidth ?? this.pictureWidth,
      pictureHeight: pictureHeight ?? this.pictureHeight,
    );
  }
}