import 'package:fastdarktheme/example/blocs/color_cubit.dart';
import 'package:fastdarktheme/example/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsluv/hsluvcolor.dart';

import 'color_luv_lum.dart';
import 'picker_list.dart';

class HuePicker extends StatelessWidget {
  const HuePicker({
    this.color,
    this.hsluvColor,
  });

  final Color color;
  final HSLuvColor hsluvColor;

  List<HSLuvColor> hsluvAlternatives(HSLuvColor luv, [int n = 6]) {
    final int div = (360 / n).round();
    return [for (int i = 0; i < n; i++) luv.withHue((div * i) % 360.0)];
  }

  List<ColorLuvLum> parseHue() {
    return hsluvAlternatives(hsluvColor, 90).map((HSLuvColor hsluv) {
      final color = hsluv.toColor();
      return ColorLuvLum(color, hsluv);
    }).toList();
  }

  void contrastColorSelected(BuildContext context, HSLuvColor color) {
    context.bloc<ColorCubit>().mapSingleToState(
          hsLuvColor: HSLuvColor.fromHSL(
            color.hue,
            color.saturation,
            color.lightness,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final hue = parseHue();
    final hueLen = hue.length;

    return Theme(
      data: ThemeData.from(
        colorScheme: (color.computeLuminance() > kLumContrast)
            ? ColorScheme.light(surface: color)
            : ColorScheme.dark(surface: color),
        textTheme: TextTheme(
          caption: GoogleFonts.b612Mono(),
        ),
      ),
      child: SizedBox(
        // make items larger on iPad
        width: MediaQuery.of(context).size.shortestSide < 600 ? 72 : 80,
        child: PickerList(
          currentValue: hsluvColor.hue.round(),
          sectionIndex: 0,
          listSize: hueLen,
          colorsList: hue,
          onColorPressed: (HSLuvColor c) => contrastColorSelected(context, c),
        ),
      ),
    );
  }
}
