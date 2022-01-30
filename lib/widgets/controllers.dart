import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meta_garden/bloc/nft/nft_bloc.dart';
import 'package:meta_garden/bloc/ticker/ticker_bloc.dart';
import 'package:meta_garden/config.dart';
import 'package:meta_garden/flower/bud/bud.dart';
import 'package:meta_garden/flower/bud/bud_bindweed.dart';
import 'package:meta_garden/flower/bud/bud_center.dart';
import 'package:meta_garden/flower/bud/bud_circle.dart';
import 'package:meta_garden/flower/bud/bud_circle_border.dart';
import 'package:meta_garden/flower/palette.dart';
import 'package:meta_garden/flower/plant_type.dart';
import 'package:meta_garden/nft.dart';
import 'package:meta_garden/scene.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:meta_garden/widgets/compile_screen.dart';
import 'package:provider/src/provider.dart';

class Controllers extends StatelessWidget {
  const Controllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        return DefaultTabController(
            length: 8,
            child: Column(
              children: [
                TabBar(
                  labelStyle: TextStyle(color: Colors.black45),
                  unselectedLabelStyle: TextStyle(color: Colors.black45),
                  tabs: [
                    Tab(
                      child: Text('Vegetation', style: TextStyle(color: Colors.black45),),
                    ),
                    Tab(
                      child: Text('Bud'),
                    ),
                    Tab(
                      child: Text('Dimension'),
                    ),
                    Tab(
                      child: Text('Growth'),
                    ),
                    Tab(
                      child: Text('Petal'),
                    ),
                    Tab(
                      child: Text('Petal'),
                    ),
                    Tab(
                      child: Text('Palette'),
                    ),
                    Tab(
                      child: Text('Plant'),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _ControlButtons(),
                          const SizedBox(height: 20),
                          _BudTypeSelector(),
                          if (state.nft.flower.bud.angle != null) _BudAngleSelector(),
                          _GrowthForm(),
                          _PlantTypeSelector(),
                          _PetalForm(),
                          if (state.nft.flower.dimension.angleX != null) _DimensionForm(),
                          _BudForm(),
                          _VegetationForm(),
                          _PaletteForm(),
                          _GenerateButton(),
                        ],
                      ),
                    ),
                    Center(),
                    Center(),
                    Center(),
                    Center(),
                    Center(),
                    Center(),
                    Center(),
                  ]),
                )
              ],
            ));
      },
    );
  }
}

class _GenerateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return CompileScreen();
        }));
      },
      child: Text('Generate'),
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

class _ControlButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          child: Text('Restart'),
          onPressed: () {
            context.read<NftBloc>().add(const NftRestart());
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          child: Text('Rebuild'),
          onPressed: () {
            context.read<NftBloc>().add(const NftRebuild());
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          child: Text('Pause'),
          onPressed: () {
            context.read<TickerBloc>().add(const TickerPaused());
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          child: Text('Next'),
          onPressed: () {
            context.read<NftBloc>().add(const NftNext());
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          child: Text('Save'),
          onPressed: () {
            context.read<NftBloc>().add(const NftSave());
          },
        ),
      ],
    );
  }
}

class _BudTypeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return Row(
          children: [
            Text('Bud type: '),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'Center',
                style: TextStyle(
                  color: nft.flower.bud is BudCenter ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBudType(BudCenter.random()));
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'Circle',
                style: TextStyle(
                  color: nft.flower.bud is BudCircle ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBudType(BudCircle.random()));
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'CircleBorder',
                style: TextStyle(
                  color: nft.flower.bud is BudCircleBorder ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBudType(BudCircleBorder.random()));
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'BindWeed',
                style: TextStyle(
                  color: nft.flower.bud is BudBindweed ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBudType(BudBindweed.random()));
              },
            ),
          ],
        );
      },
    );
  }
}

class _BudAngleSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return Container(
          width: 500,
          child: Row(
            children: [
              Expanded(
                child: Checkbox(
                  value: nft.flower.bud.isRandom,
                  onChanged: (e) {
                    context.read<NftBloc>().add(NftChangeBud(isRandom: e!));
                  },
                ),
              ),
              Expanded(
                child: Checkbox(
                  value: nft.flower.bud.isRandomSpeed,
                  onChanged: (e) {
                    context.read<NftBloc>().add(NftChangeBud(isRandomSpeed: e!));
                  },
                ),
              ),
              Container(
                width: 200,
                child: TextFormField(
                  initialValue: nft.flower.bud.angle.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(NftChangeBud(angle: double.parse(value)));
                  },
                  decoration: InputDecoration(
                    label: Text('Bud angle'),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: TextFormField(
                  initialValue: nft.flower.bud.speed.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(NftChangeBud(speed: double.parse(value)));
                  },
                  decoration: InputDecoration(
                    label: Text('Bud speed'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GrowthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        return Container(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: Checkbox(
                  value: state.nft.flower.growth.isRandom,
                  onChanged: (e) {
                    context.read<NftBloc>().add(
                          NftChangeGrowth(
                            isRandom: e!,
                          ),
                        );
                  },
                ),
              ),
              Container(
                width: 200,
                child: TextFormField(
                  initialValue: state.nft.flower.growth.speed.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangeGrowth(
                            speed: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('Growth Speed'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlantTypeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final plantType = state.nft.flower.bud.plantType;
        return Row(
          children: [
            Text('Plant type: '),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'Green',
                style: TextStyle(
                  color: plantType == PlantType.green() ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBud(plantType: PlantType.green()));
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'Brown',
                style: TextStyle(
                  color: plantType == PlantType.brown() ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBud(plantType: PlantType.brown()));
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              child: Text(
                'Red',
                style: TextStyle(
                  color: plantType == PlantType.red() ? Colors.redAccent : null,
                ),
              ),
              onPressed: () {
                context.read<NftBloc>().add(NftChangeBud(plantType: PlantType.red()));
              },
            ),
          ],
        );
      },
    );
  }
}

class _PetalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return Container(
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Checkbox(
                  value: nft.flower.petal.isRandom,
                  onChanged: (e) {
                    context.read<NftBloc>().add(
                          NftChangePetal(
                            isRandom: e!,
                          ),
                        );
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: (nft.flower.petal.angleX! * nft.flower.petal.angleDirX!).toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangePetal(
                            angleX: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('PR X'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: (nft.flower.petal.angleY! * nft.flower.petal.angleDirY!).toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangePetal(
                            angleY: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('PR Y'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: (nft.flower.petal.angleZ! * nft.flower.petal.angleDirZ!).toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangePetal(
                            angleZ: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('PR Z'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DimensionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return Container(
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(nft.flower.dimension.type),
              Expanded(
                child: Checkbox(
                  value: nft.flower.dimension.isRandom,
                  onChanged: (e) {
                    context.read<NftBloc>().add(
                          NftChangeDimension(
                            isRandom: e!,
                          ),
                        );
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: nft.flower.dimension.angleX.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangeDimension(
                            angleX: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation X'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: nft.flower.dimension.angleY.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangeDimension(
                            angleY: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation Y'),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: nft.flower.dimension.angleZ.toString(),
                  onChanged: (value) {
                    context.read<NftBloc>().add(
                          NftChangeDimension(
                            angleZ: double.parse(value),
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    label: Text('Rotation Z'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BudForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (nft.flower.bud.radius != null)
              TextFormField(
                initialValue: nft.flower.bud.radius.toString(),
                onChanged: (value) {
                  context.read<NftBloc>().add(
                        NftChangeBud(
                          radius: double.parse(value),
                        ),
                      );
                },
                decoration: InputDecoration(
                  label: Text('Bud radius'),
                ),
              ),
            if (nft.flower.bud.innerRadius != null)
              TextFormField(
                initialValue: nft.flower.bud.innerRadius.toString(),
                onChanged: (value) {
                  context.read<NftBloc>().add(
                        NftChangeBud(
                          innerRadius: double.parse(value),
                        ),
                      );
                },
                decoration: InputDecoration(
                  label: Text('Bud inner radius'),
                ),
              ),
            TextFormField(
              initialValue: nft.flower.bud.particlesCount.toString(),
              onChanged: (value) {
                context.read<NftBloc>().add(
                      NftChangeBud(
                        particlesCount: int.parse(value),
                      ),
                    );
              },
              decoration: InputDecoration(
                label: Text('Bud particles count'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VegetationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        return TextFormField(
          initialValue: nft.flower.vegetation.rate.toString(),
          onChanged: (value) {
            context.read<NftBloc>().add(
                  NftChangeVegetation(
                    rate: double.parse(value),
                  ),
                );
          },
          decoration: InputDecoration(
            label: Text('Vegetation rate'),
          ),
        );
      },
    );
  }
}

class _PaletteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (p, n) => p.nft != n.nft,
      builder: (context, state) {
        final nft = state.nft;
        final colors = nft.flower.palette.colors;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                      context.read<NftBloc>().add(
                            NftChangePalette(
                              colors: Palette.random().colors,
                            ),
                          );
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
                      context.read<NftBloc>().add(
                            NftChangePalette(
                              colors: [...colors, randomRealColor()],
                            ),
                          );
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
                      context.read<NftBloc>().add(
                            NftChangePalette(
                              colors: palette,
                            ),
                          );
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ],
            ),
            TextFormField(
              initialValue: nft.flower.palette.name,
              onChanged: (value) {
                context.read<NftBloc>().add(
                      NftChangePalette(
                        name: value,
                      ),
                    );
              },
              decoration: InputDecoration(
                label: Text('Palette name'),
              ),
            )
          ],
        );
      },
    );
  }
}
