import 'package:flutter/material.dart';
import 'package:meta_garden/utils/utils.dart';
import 'package:palette/palette.dart';

class Palette {
  late final String name;
  late final List<Color> colors;

  Palette({
    required this.colors,
    this.name = 'unknown',
  });

  factory Palette.random() {
    var colors = <Color>[];

    colors = [
      Color(0xFF8C0000),
      Color(0xFFBD2000),
      Color(0xFFFF005C),
      Color(0xFFFFF600),
    ];
    // colors = [
    //   Color(0xFF26001B),
    //   Color(0xFF810034),
    //   Color(0xFFFF005C),
    //   Color(0xFFFFF600),
    // ];
    // colors = [
    //   Color(0xFF000000),
    //   Color(0xFF52057B),
    //   Color(0xFF892CDC),
    //   Color(0xFFBC6FF1),
    // ];
    // colors = [
    //   Color(0xFF252525),
    //   Color(0xFF80FFDB),
    //   Color(0xFF6930C3),
    //   Color(0xFF64DFDF),
    // ];
    // colors = [
    //   Color(0xFFF7FD04),
    //   Color(0xFFF9B208),
    //   Color(0xFFF98404),
    //   Color(0xFFFC5404),
    // ];
    // colors = [
    //   Color(0xFF0CECDD),
    //   Color(0xFFFFF338),
    //   Color(0xFFFF67E7),
    //   Color(0xFFC400FF),
    // ];
    // colors = [
    //   Color(0xFFF7E6AD),
    //   Color(0xFF28FFBF),
    //   Color(0xFFBCFFB9),
    //   Color(0xFFF5FDB0),
    // ];

    // colors = [
    //   Color(0xFF99FEFF),
    //   Color(0xFFB983FF),
    //   Color(0xFF94B3FD),
    //   Color(0xFF94DAFF),
    // ];


    // colors = [
    //   Color(0xFFCFFFDC),
    //   Color(0xFF7900FF),
    //   Color(0xFF548CFF),
    //   Color(0xFF93FFD8),
    // ];
    List<Color> p;
    if(random.nextBool()) {
      p = a[u++];
      if(u == a.length) u = 0;
    } else {
      p = [randomRealColor(), randomRealColor()];
    }

    print(a.length);
    return Palette(
      // colors: randomPalette(),
      colors: random.percent(70) ? a.rand() : [randomRealColor(), randomRealColor()],
    );
  }

  static var u = 0;

  Palette copyWith({
    String? name,
    List<Color>? colors,
  }) {
    return Palette(
      name: name ?? this.name,
      colors: colors ?? this.colors,
    );
  }

  Palette.fromJson(List json) {
    colors = [];
    json.forEach((i) {
      colors.add(Color.fromARGB(i[0], i[1], i[2], i[3]));
    });
  }

  List toJson() {
    return [
      for(var color in colors)
        [color.alpha, color.red, color.green, color.blue],
    ];
  }
}

var a = [
  [Color(0xFFFFE162), Color(0xFFFF6464), Color(0xFF91C483), Color(0xFFEEEEEE)],
  [Color(0xFF000000), Color(0xFF5800FF), Color(0xFFE900FF), Color(0xFFFFC600)],
  [Color(0xFFFF008E), Color(0xFFD22779), Color(0xFF612897), Color(0xFF0C1E7F)],
  [Color(0xFFFF6363), Color(0xFFFFAB76), Color(0xFFFFFDA2), Color(0xFFBAFFB4)],
  [Color(0xFFF9D371), Color(0xFFF47340), Color(0xFFEF2F88), Color(0xFF8843F2)],
  [Color(0xFF7900FF), Color(0xFF548CFF), Color(0xFF93FFD8), Color(0xFFCFFFDC)],
  [Color(0xFFFF1700), Color(0xFFFF8E00), Color(0xFFFFE400), Color(0xFF06FF00)],
  [Color(0xFFF90716), Color(0xFFFF5403), Color(0xFFFFCA03), Color(0xFFFFF323)],
  [Color(0xFFB983FF), Color(0xFF94B3FD), Color(0xFF94DAFF), Color(0xFF99FEFF)],
  [Color(0xFFFBF46D), Color(0xFFB4FE98), Color(0xFF77E4D4), Color(0xFF998CEB)],
  [Color(0xFF000D6B), Color(0xFF9C19E0), Color(0xFFFF5DA2), Color(0xFF99DDCC)],
  [Color(0xFF49FF00), Color(0xFFFBFF00), Color(0xFFFF9300), Color(0xFFFF0000)],
  [Color(0xFFFF0075), Color(0xFF172774), Color(0xFF77D970), Color(0xFFEEEEEE)],
  [Color(0xFF1DB9C3), Color(0xFF7027A0), Color(0xFFC32BAD), Color(0xFFF56FAD)],
  [Color(0xFFFF00E4), Color(0xFFED50F1), Color(0xFFFDB9FC), Color(0xFFFFEDED)],
  [Color(0xFFEB92BE), Color(0xFFFFEF78), Color(0xFFA8E7E9), Color(0xFFB1FFFD)],
  [Color(0xFF3B0000), Color(0xFFFF0000), Color(0xFFFF95C5), Color(0xFFFFF6CD)],
  [Color(0xFF1E3163), Color(0xFF2D46B9), Color(0xFFF037A5), Color(0xFFF8F8F8)],
  [Color(0xFF170055), Color(0xFF3E00FF), Color(0xFFAE00FB), Color(0xFFB5FFD9)],
  [Color(0xFFFF4848), Color(0xFFFFD371), Color(0xFFC2FFD9), Color(0xFF9DDAC6)],
  [Color(0xFF28FFBF), Color(0xFFBCFFB9), Color(0xFFF5FDB0), Color(0xFFF7E6AD)],
  [Color(0xFF0CECDD), Color(0xFFFFF338), Color(0xFFFF67E7), Color(0xFFC400FF)],
  [Color(0xFF7C83FD), Color(0xFF96BAFF), Color(0xFF7DEDFF), Color(0xFF88FFF7)],
  [Color(0xFF78DEC7), Color(0xFFD62AD0), Color(0xFFFB7AFC), Color(0xFFFBC7F7)],
  [Color(0xFFF0D9E7), Color(0xFFFF94CC), Color(0xFFA239EA), Color(0xFF5C33F6)],
  [Color(0xFF04009A), Color(0xFF77ACF1), Color(0xFF3EDBF0), Color(0xFFF0EBCC)],
  [Color(0xFF00EAD3), Color(0xFFFFF5B7), Color(0xFFFF449F), Color(0xFF005F99)],
  [Color(0xFF480032), Color(0xFF005792), Color(0xFFFC92E3), Color(0xFFF2F4C3)],
  [Color(0xFFF7FD04), Color(0xFFF9B208), Color(0xFFF98404), Color(0xFFFC5404)],
  [Color(0xFF233E8B), Color(0xFF1EAE98), Color(0xFFA9F1DF), Color(0xFFFFFFC7)],
  [Color(0xFF04009A), Color(0xFF77ACF1), Color(0xFF3EDBF0), Color(0xFFC0FEFC)],
  [Color(0xFFF5F7B2), Color(0xFF1CC5DC), Color(0xFF890596), Color(0xFFCF0000)],
  [Color(0xFF23049D), Color(0xFFAA2EE6), Color(0xFFFF79CD), Color(0xFFFFDF6B)],
  [Color(0xFF72147E), Color(0xFFF21170), Color(0xFFFA9905), Color(0xFFFF5200)],
  [Color(0xFF542E71), Color(0xFFFB3640), Color(0xFFFDCA40), Color(0xFFA799B7)],
  [Color(0xFFC67ACE), Color(0xFFD8F8B7), Color(0xFFFF9A8C), Color(0xFFCE1F6A)],
  [Color(0xFFFEFFDE), Color(0xFFDDFFBC), Color(0xFF91C788), Color(0xFF52734D)],
  [Color(0xFF9EDE73), Color(0xFFF7EA00), Color(0xFFE48900), Color(0xFFBE0000)],
  [Color(0xFFCCFFBD), Color(0xFF7ECA9C), Color(0xFF40394A), Color(0xFF1C1427)],
  [Color(0xFF440A67), Color(0xFF93329E), Color(0xFFB4AEE8), Color(0xFFFFE3FE)],
  [Color(0xFFE4FBFF), Color(0xFFB8B5FF), Color(0xFF7868E6), Color(0xFFEDEEF7)],
  [Color(0xFF26001B), Color(0xFF810034), Color(0xFFFF005C), Color(0xFFFFF600)],
  [Color(0xFF8C0000), Color(0xFFBD2000), Color(0xFFFA1E0E), Color(0xFFFFBE0F)],
  [Color(0xFFF6F6F6), Color(0xFFC7FFD8), Color(0xFF98DED9), Color(0xFF161D6F)],
  [Color(0xFF845EC2), Color(0xFFFFC75F), Color(0xFFF9F871), Color(0xFFFF5E78)],
  [Color(0xFFFFE227), Color(0xFFEB596E), Color(0xFF4D375D), Color(0xFF121013)],
  [Color(0xFF252525), Color(0xFF6930C3), Color(0xFF64DFDF), Color(0xFF80FFDB)],
  [Color(0xFF00AF91), Color(0xFF007965), Color(0xFFF58634), Color(0xFFFFCC29)],
  [Color(0xFFFF577F), Color(0xFFFF884B), Color(0xFFFFC764), Color(0xFFCDFFFC)],
  [Color(0xFF111D5E), Color(0xFFC70039), Color(0xFFF37121), Color(0xFFC0E218)],
  [Color(0xFFF1F1F1), Color(0xFFFDB827), Color(0xFF21209C), Color(0xFF23120B)],
  [Color(0xFF153E90), Color(0xFF0E49B5), Color(0xFF54E346), Color(0xFFFFFAA4)],
  [Color(0xFF222831), Color(0xFF393E46), Color(0xFFFFD369), Color(0xFFEEEEEE)],
  [Color(0xFF120078), Color(0xFF9D0191), Color(0xFFFD3A69), Color(0xFFFECD1A)],
  [Color(0xFF000000), Color(0xFF52057B), Color(0xFF892CDC), Color(0xFFBC6FF1)],
  [Color(0xFFFCF876), Color(0xFFCEE397), Color(0xFF8BCDCD), Color(0xFF3797A4)],
  [Color(0xFF7579E7), Color(0xFF9AB3F5), Color(0xFFA3D8F4), Color(0xFFB9FFFC)],
  [Color(0xFFE8FFFF), Color(0xFFA6F6F1), Color(0xFF41AEA9), Color(0xFF213E3B)],
  [Color(0xFFEEEEEE), Color(0xFF32E0C4), Color(0xFF0D7377), Color(0xFF212121)],
  [Color(0xFF28DF99), Color(0xFF99F3BD), Color(0xFFD2F6C5), Color(0xFFF6F7D4)],
  [Color(0xFF2EC1AC), Color(0xFF3E978B), Color(0xFFD2E603), Color(0xFFEFF48E)],
  [Color(0xFFCFFFFE), Color(0xFFF9F7D9), Color(0xFFFCE2CE), Color(0xFFFFC1F3)],
  [Color(0xFF1B262C), Color(0xFF0F4C75), Color(0xFF00B7C2), Color(0xFFFDCB9E)],
  [Color(0xFFFA26A0), Color(0xFF05DFD7), Color(0xFFA3F7BF), Color(0xFFFFF591)],
  [Color(0xFFEEEEEE), Color(0xFF393E46), Color(0xFF76EAD7), Color(0xFFC4FB6D)],
  [Color(0xFFB6EB7A), Color(0xFFF7F7EE), Color(0xFFFB7813), Color(0xFF17706E)],
  [Color(0xFFEEEEEE), Color(0xFF32E0C4), Color(0xFF393E46), Color(0xFF222831)],
  [Color(0xFFFAEEE7), Color(0xFFF54291), Color(0xFF4CD3C2), Color(0xFF0A97B0)],
  [Color(0xFF2FC4B2), Color(0xFF12947F), Color(0xFFE71414), Color(0xFFF17808)],
  [Color(0xFFFF5200), Color(0xFF6F0000), Color(0xFF00263B), Color(0xFF00A1AB)],
  [Color(0xFFF7F7F7), Color(0xFF43D8C9), Color(0xFF95389E), Color(0xFF100303)],
  [Color(0xFFEFA8E4), Color(0xFFF8E1F4), Color(0xFFFFF0F5), Color(0xFF97E5EF)],
  [Color(0xFF00BDAA), Color(0xFF400082), Color(0xFFFE346E), Color(0xFFF1E7B6)],
  [Color(0xFFD7FFFD), Color(0xFFA1E6E3), Color(0xFFECA0B6), Color(0xFFFAFBA4)],
  [Color(0xFF4D089A), Color(0xFF323EDD), Color(0xFFDC2ADE), Color(0xFFE8F044)],
  [Color(0xFFF35588), Color(0xFF05DFD7), Color(0xFFA3F7BF), Color(0xFFFFF591)],
  [Color(0xFF381460), Color(0xFFB21F66), Color(0xFFFE346E), Color(0xFFFFBD69)],
  [Color(0xFFEDEDED), Color(0xFFFFA41B), Color(0xFFFF5151), Color(0xFF9818D6)],
  [Color(0xFFFFD5E5), Color(0xFFFFFFDD), Color(0xFFA0FFE6), Color(0xFF81F5FF)],
  [Color(0xFF8CBA51), Color(0xFFDEFF8B), Color(0xFFFBCEB5), Color(0xFFFF5D6C)],
  [Color(0xFFF0134D), Color(0xFFFF6F5E), Color(0xFFF5F0E3), Color(0xFF40BFC1)],
  [Color(0xFFFFBA5A), Color(0xFFC0FFB3), Color(0xFF52DE97), Color(0xFF2C7873)],
  [Color(0xFFFA163F), Color(0xFF12CAD6), Color(0xFF0FABBC), Color(0xFFE4F9FF)],
  [Color(0xFF018383), Color(0xFF02A8A8), Color(0xFF42E6A4), Color(0xFFF5DEA3)],
  [Color(0xFFF65C78), Color(0xFFFFD271), Color(0xFFFFF3AF), Color(0xFFC3F584)],
  [Color(0xFFFA697C), Color(0xFFE13A9D), Color(0xFF9B45E4), Color(0xFFFCC169)],
  [Color(0xFF51EAEA), Color(0xFFFFDBC5), Color(0xFFFF9D76), Color(0xFFEF4339)],
  [Color(0xFF3FC5F0), Color(0xFF42DEE1), Color(0xFF6DECB9), Color(0xFFEEF5B2)],
  [Color(0xFF851DE0), Color(0xFFAA26DA), Color(0xFFC355F5), Color(0xFFF1FA3C)],
  [Color(0xFF6807F9), Color(0xFF9852F9), Color(0xFFC299FC), Color(0xFFFFD739)],
  [Color(0xFFECFCFF), Color(0xFFB2FCFF), Color(0xFF5EDFFF), Color(0xFF3E64FF)],
  [Color(0xFF443737), Color(0xFF272121), Color(0xFFFF0000), Color(0xFFFF4D00)],
  [Color(0xFF3B064D), Color(0xFF8105D8), Color(0xFFED0CEF), Color(0xFFFE59D7)],
  [Color(0xFF000272), Color(0xFF341677), Color(0xFFA32F80), Color(0xFFFF6363)],
  [Color(0xFFB6FFEA), Color(0xFFFCE2AE), Color(0xFFFFB3B3), Color(0xFFFFDCF7)],
  [Color(0xFF61F2F5), Color(0xFFFFFFFF), Color(0xFFE0E0E0), Color(0xFF723881)],
  [Color(0xFF08FFC8), Color(0xFFFFF7F7), Color(0xFFDADADA), Color(0xFF204969)],
  [Color(0xFF252525), Color(0xFFFF0000), Color(0xFFAF0404), Color(0xFF414141)],
  [Color(0xFFF5B5FC), Color(0xFF96F7D2), Color(0xFFF0F696), Color(0xFFFCB1B1)],
  [Color(0xFFF38EFF), Color(0xFFFF00C8), Color(0xFFFFCECE), Color(0xFFFFF0F0)],
  [Color(0xFFF4FF61), Color(0xFFA8FF3E), Color(0xFF32FF6A), Color(0xFF27AA80)],
  [Color(0xFF090088), Color(0xFF930077), Color(0xFFE4007C), Color(0xFFFFBD39)],
  [Color(0xFFF2F4F6), Color(0xFF1EE3CF), Color(0xFF6B48FF), Color(0xFF0D3F67)],
  [Color(0xFFF1F4DF), Color(0xFF10EAF0), Color(0xFF0028FF), Color(0xFF24009C)],
  [Color(0xFF8A00D4), Color(0xFFD527B7), Color(0xFFFF82C3), Color(0xFFFFC46B)],
  [Color(0xFFF7FF56), Color(0xFF94FC13), Color(0xFF4BE3AC), Color(0xFF032D3C)],
  [Color(0xFF22EACA), Color(0xFFB31E6F), Color(0xFFEE5A5A), Color(0xFFFF9E74)],
  [Color(0xFFE41749), Color(0xFFF5587B), Color(0xFFFF8A5C), Color(0xFFFFF591)],
  [Color(0xFFFFF3A3), Color(0xFFFF7BB0), Color(0xFFFF3E6D), Color(0xFF7572F4)],
  [Color(0xFF444444), Color(0xFFF30067), Color(0xFF00D1CD), Color(0xFFEAEAEA)],
  [Color(0xFFC5FAD9), Color(0xFFACEACF), Color(0xFFF77FEE), Color(0xFFDB66E4)],
  [Color(0xFF302387), Color(0xFFFF3796), Color(0xFF00FAAC), Color(0xFFFFFDAF)],
  [Color(0xFFF9FD50), Color(0xFF85EF47), Color(0xFF00BD56), Color(0xFF207DFF)],
  [Color(0xFFFF5D9E), Color(0xFF8F71FF), Color(0xFF82ACFF), Color(0xFF8BFFFF)],
  [Color(0xFFFAF562), Color(0xFFF36A7B), Color(0xFFB824A4), Color(0xFFAAAAAA)],
  [Color(0xFF51EAEA), Color(0xFFFFFDE1), Color(0xFFFF9D76), Color(0xFFFB3569)],
  [Color(0xFFF68787), Color(0xFFF8A978), Color(0xFFF1EB9A), Color(0xFFA4F6A5)],
  [Color(0xFF6927FF), Color(0xFF837DFF), Color(0xFFBF81FF), Color(0xFFFFD581)],
  [Color(0xFFF5F5F5), Color(0xFF30E3CA), Color(0xFF2F89FC), Color(0xFF40514E)],
  [Color(0xFFEEF2F5), Color(0xFFEA168E), Color(0xFF612570), Color(0xFF1EAFED)],
  [Color(0xFFD34848), Color(0xFFFF8162), Color(0xFFFFCD60), Color(0xFFFFFA67)],
  [Color(0xFF0C005A), Color(0xFFBC2525), Color(0xFFFF0000), Color(0xFFEAEAEA)],
  [Color(0xFF3A0088), Color(0xFF930077), Color(0xFFE61C5D), Color(0xFFFFE98A)],
  [Color(0xFF6EFFBF), Color(0xFFDCAEE8), Color(0xFFFFC5E6), Color(0xFFFCF2DB)],
  [Color(0xFFEBFFFB), Color(0xFF7EFAFF), Color(0xFF13ABC4), Color(0xFF3161A3)],
  [Color(0xFFFA86BE), Color(0xFFA275E3), Color(0xFF9AEBED), Color(0xFFFFFCAB)],
  [Color(0xFFC9F658), Color(0xFFDBFF3D), Color(0xFF55968F), Color(0xFF8ACBBB)],
  [Color(0xFFF2F4FB), Color(0xFFD22780), Color(0xFFF8B500), Color(0xFF5E227F)],
  [Color(0xFFFDF1DB), Color(0xFFA6CB12), Color(0xFFE00543), Color(0xFF84253E)],
  [Color(0xFFEAEC96), Color(0xFF43C0AC), Color(0xFFA93199), Color(0xFFFA0559)],
  [Color(0xFFB8FFD0), Color(0xFFECFFC1), Color(0xFFFFE6CC), Color(0xFFDFBAF7)],
  [Color(0xFF033FFF), Color(0xFF4A9FF5), Color(0xFF5FF4EE), Color(0xFFC2FCF6)],
  [Color(0xFF73DBC4), Color(0xFFFAF7E6), Color(0xFFFF008B), Color(0xFFFFF8A1)],
  [Color(0xFFFF1F5A), Color(0xFFFFD615), Color(0xFFF9FF21), Color(0xFF1E2A78)],
  [Color(0xFFA3F3EB), Color(0xFFF1FFAB), Color(0xFFFBD341), Color(0xFFFB9A40)],
  [Color(0xFFF5E965), Color(0xFFFF9668), Color(0xFFDB456F), Color(0xFFA74FAF)],
  [Color(0xFF35013F), Color(0xFFB643CD), Color(0xFFFF5DA2), Color(0xFF99DDCC)],
  [Color(0xFF89F8CE), Color(0xFFF5FAC7), Color(0xFFDEC8ED), Color(0xFFCC99F9)],
  [Color(0xFFFFF6DA), Color(0xFF84F2D6), Color(0xFFFC6B3F), Color(0xFF262525)],
  [Color(0xFF35D0BA), Color(0xFFF8C43A), Color(0xFFC93D1B), Color(0xFF04322E)],
  [Color(0xFF7C203A), Color(0xFFF85959), Color(0xFFFF9F68), Color(0xFFFEFF89)],
  [Color(0xFFFAFAF6), Color(0xFF00FFF0), Color(0xFF00D1FF), Color(0xFF3D6CB9)],
  [Color(0xFF78FEE0), Color(0xFF4BC2C5), Color(0xFF3B9A9C), Color(0xFFFEF4A9)],
  [Color(0xFFFFFB97), Color(0xFF97FFCF), Color(0xFF2FE1D6), Color(0xFF38C6BD)],
  [Color(0xFFFCFCFC), Color(0xFF83FFE6), Color(0xFFFF5F5F), Color(0xFF2C2C2C)],
  [Color(0xFF5628B4), Color(0xFFD80E70), Color(0xFFE7455F), Color(0xFFF7B236)],
  [Color(0xFFF4F4F4), Color(0xFF65EEB7), Color(0xFFFF5722), Color(0xFF474744)],
  [Color(0xFFECFEFF), Color(0xFF00B7C2), Color(0xFF128494), Color(0xFF4EF037)],
  [Color(0xFF08085E), Color(0xFFA2EF44), Color(0xFFFFF07A), Color(0xFFE8FCF6)],
  [Color(0xFF071A52), Color(0xFF086972), Color(0xFF17B978), Color(0xFFA7FF83)],
  [Color(0xFFFCF9F9), Color(0xFFF1F864), Color(0xFFBCEB3C), Color(0xFF7CBD1E)],
  [Color(0xFF1FFFFF), Color(0xFFFFFDE1), Color(0xFFFF9D76), Color(0xFFFF4273)],
  [Color(0xFFE9007F), Color(0xFF7CDFFF), Color(0xFFD5FFFB), Color(0xFFFCFFC8)],
  [Color(0xFFF7F7F8), Color(0xFF4EEAF6), Color(0xFFC82586), Color(0xFF291F71)],
  [Color(0xFF432160), Color(0xFFFF7A5A), Color(0xFF50E3C2), Color(0xFFFCF4D9)],
  [Color(0xFFFEFF9A), Color(0xFF6FE8C8), Color(0xFF85FEDE), Color(0xFFB7ABFB)],
  [Color(0xFF9FFBFB), Color(0xFFA100FF), Color(0xFFDB97FF), Color(0xFFFFB6FF)],
  [Color(0xFFC7F5FE), Color(0xFFFCC8F8), Color(0xFFEAB4F8), Color(0xFFF3F798)],
  [Color(0xFF7EFFDB), Color(0xFFB693FE), Color(0xFF8C82FC), Color(0xFFFF9DE2)],
  [Color(0xFFFF6F6F), Color(0xFFFFF46E), Color(0xFFF6F6F6), Color(0xFFA58BFF)]
];