import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/palette.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';

class Controllers extends StatelessWidget {
  final Nft nft;
  final double vegetationRate;
  final void Function(double value) changeRate;
  final void Function() next;
  final void Function() tickerController;
  final List<Color> colors;
  final void Function(List<Color> colors) updatePalette;
  final void Function(String) setPaletteName;
  final String paletteName;
  final double? budRadius;
  final void Function(double) changeBudRadius;
  final int? budParticlesCount;
  final void Function(int) changeBudParticlesCount;
  final void Function() restart;
  final void Function() rebuild;
  final double? budInnerRadius;
  final void Function(double) changeBudInnerRadius;
  final void Function() save;
  final double? growthSpeed;
  final void Function(double) changeGrowthSpeed;
  final double? rotationX;
  final void Function(double) changeRotationX;
  final double? rotationY;
  final void Function(double) changeRotationY;
  final double? rotationZ;
  final void Function(double) changeRotationZ;
  final bool isRandomDimension;
  final void Function(bool) changeRandomDimension;
  final PlantType plantType;
  final void Function(String) changePlantType;
  final bool isRandomGrowth;
  final void Function(bool) changeRandomGrowth;

  const Controllers({
    Key? key,
    required this.nft,
    required this.plantType,
    required this.changePlantType,
    required this.vegetationRate,
    required this.changeRate,
    required this.next,
    required this.tickerController,
    required this.colors,
    required this.updatePalette,
    required this.setPaletteName,
    required this.paletteName,
    required this.budRadius,
    required this.changeBudRadius,
    required this.budParticlesCount,
    required this.changeBudParticlesCount,
    required this.restart,
    required this.rebuild,
    required this.budInnerRadius,
    required this.changeBudInnerRadius,
    required this.save,
    required this.growthSpeed,
    required this.changeGrowthSpeed,
    required this.rotationX,
    required this.changeRotationX,
    required this.rotationY,
    required this.changeRotationY,
    required this.rotationZ,
    required this.changeRotationZ,
    required this.isRandomDimension,
    required this.changeRandomDimension,
    required this.isRandomGrowth,
    required this.changeRandomGrowth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              child: Text('Restart'),
              onPressed: restart,
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              child: Text('Rebuild'),
              onPressed: rebuild,
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              child: Text('Pause'),
              onPressed: tickerController,
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              child: Text('Next'),
              onPressed: next,
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: save,
            ),
          ],
        ),
        if (growthSpeed != null)
          Container(
            width: 300,
            child: Row(
              children: [
                Expanded(
                  child: Checkbox(
                    value: isRandomGrowth,
                    onChanged: (e) => changeRandomGrowth(e!),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    initialValue: growthSpeed.toString(),
                    onChanged: (value) {
                      changeGrowthSpeed(double.parse(value));
                    },
                    decoration: InputDecoration(
                      label: Text('Growth Speed'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            Text('Plant type: '),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text('Green', style: TextStyle(color: plantType == PlantType.green() ? Colors.redAccent : null,)),
              onPressed: () {
                changePlantType('green');
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text('Brown', style: TextStyle(color: plantType == PlantType.brown() ? Colors.redAccent : null,)),
              onPressed: () {
                changePlantType('brown');
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text('Red', style: TextStyle(color: plantType == PlantType.red() ? Colors.redAccent : null,)),
              onPressed: () {
                changePlantType('red');
              },
            ),
          ],
        ),
        if(rotationX != null)
        Container(
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(nft.flower.dimension.type),
              Expanded(
                child: Checkbox(
                  value: isRandomDimension,
                  onChanged: (e) => changeRandomDimension(e!),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: rotationX.toString(),
                  onChanged: (value) {
                    changeRotationX(double.parse(value));
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation X'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: rotationY.toString(),
                  onChanged: (value) {
                    changeRotationY(double.parse(value));
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation Y'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: rotationZ.toString(),
                  onChanged: (value) {
                    changeRotationZ(double.parse(value));
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation Z'),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (budRadius != null)
          TextFormField(
            initialValue: budRadius.toString(),
            onChanged: (value) {
              changeBudRadius(double.parse(value));
            },
            decoration: InputDecoration(
              label: Text('Bud radius'),
            ),
          ),
        if (budInnerRadius != null)
          TextFormField(
            initialValue: budInnerRadius.toString(),
            onChanged: (value) {
              changeBudInnerRadius(double.parse(value));
            },
            decoration: InputDecoration(
              label: Text('Bud inner radius'),
            ),
          ),
        TextFormField(
          initialValue: budParticlesCount.toString(),
          onChanged: (value) {
            changeBudParticlesCount(int.parse(value));
          },
          decoration: InputDecoration(
            label: Text('Bud particles count'),
          ),
        ),
        TextFormField(
          initialValue: vegetationRate.toString(),
          onChanged: (value) {
            changeRate(double.parse(value));
          },
          decoration: InputDecoration(
            label: Text('Vegetation rate'),
          ),
        ),
        Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const Center(
                      child: Text('R'),
                    ),
                  ),
                ),
                onTap: () {
                  updatePalette(Palette.random().colors);
                },
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const Center(
                      child: Text('+'),
                    ),
                  ),
                ),
                onTap: () {
                  updatePalette([...colors, randomRealColor()]);
                },
              ),
            ),
            for (var i = 0; i < colors.length; i++) ...[
              ColorSelector(
                color: colors[i],
                changeColor: (color) {
                  var palette = <Color>[];
                  for (var j = 0; j < colors.length; j++) {
                    if (i != j) {
                      palette.add(colors[j]);
                    } else if (color != null) {
                      palette.add(color);
                    }
                  }
                  updatePalette(palette);
                },
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ],
        ),
        TextFormField(
          initialValue: paletteName,
          onChanged: setPaletteName,
          decoration: InputDecoration(
            label: Text('Palette name'),
          ),
        ),
      ],
    );
  }
}

class ColorSelector extends StatefulWidget {
  final Color color;
  final void Function(Color? color) changeColor;

  const ColorSelector({
    Key? key,
    required this.color,
    required this.changeColor,
  }) : super(key: key);

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color color;

  @override
  void initState() {
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipOval(
        child: Container(
          width: 30,
          height: 30,
          color: widget.color,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: color,
                onColorChanged: (color) {
                  this.color = color;
                },
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Delete'),
                onPressed: () {
                  widget.changeColor(null);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  widget.changeColor(color);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
