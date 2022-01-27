import 'package:meta_garden/utils/utils.dart';

class PlantType {
  late final String value;

  static final List<String> values = [
    'green',
    'brown',
    'red',
  ];

  PlantType.green(): value = values[0];
  PlantType.brown(): value = values[1];
  PlantType.red(): value = values[2];

  PlantType.random(): value = values[random.nextInt(values.length)];

  PlantType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is PlantType && other.value == value;
  }
}