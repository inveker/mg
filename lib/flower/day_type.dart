import 'package:meta_garden/utils/utils.dart';

class DayType {
  late final String value;

  static final List<String> values = [
    'dawn',
    'noon',
    'dust',
  ];

  DayType.dawn(): value = values[0];
  DayType.noon(): value = values[1];
  DayType.dust(): value = values[2];

  DayType.random(): value = values[random.nextInt(values.length)];

  DayType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}