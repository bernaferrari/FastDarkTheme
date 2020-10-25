import 'dart:math' as math;
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastdarktheme/example/util/constants.dart';
import 'package:hsluv/hsluvcolor.dart';

import 'mode.dart';

class ColorState extends Equatable {
  const ColorState(
    this.rgbColors,
    this.hsluvColors,
    this.mode,
  );

  final Map<String, Color> rgbColors;
  final Map<String, HSLuvColor> hsluvColors;
  final Mode mode;

  @override
  String toString() => 'ColorState with mode $mode';

  @override
  List<Object> get props => [rgbColors, hsluvColors, mode];
}

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(_initialState());

  static ColorState _initialState({Mode mode = Mode.WhatsApp}) {
    final Map<String, Color> allRgb = {kPrimary: Color(0xff00AB9A)};
    final Map<String, HSLuvColor> allLuv = convertToHSLuv(allRgb);
    convertColors(allLuv, allRgb, mode);

    return ColorState(allRgb, allLuv, mode);
  }

  static Map<String, HSLuvColor> convertToHSLuv(
      Map<String, Color> updatableMap) {
    final Map<String, HSLuvColor> luvMap = <String, HSLuvColor>{};

    for (String key in updatableMap.keys) {
      luvMap[key] = HSLuvColor.fromColor(updatableMap[key]);
    }

    return luvMap;
  }

  static void convertColors(
    Map<String, HSLuvColor> allLuv,
    Map<String, Color> allRgb,
    Mode mode,
  ) {
    if (mode == Mode.WhatsApp) {
      final hue1 = (allLuv[kPrimary].hue + 30) % 360;
      allLuv[kSurface] = HSLuvColor.fromHSL(hue1, 40, 10);
      allRgb[kSurface] = allLuv[kSurface].toColor();

      final double hue2 = (allLuv[kPrimary].hue + 35) % 360;
      allLuv[kBackground] = HSLuvColor.fromHSL(hue2, 40, 5);
      allRgb[kBackground] = allLuv[kBackground].toColor();
    } else if (mode == Mode.Twitter) {
      final double hue = (allLuv[kPrimary].hue + 10) % 360;

      allLuv[kSurface] = HSLuvColor.fromHSL(hue, 35, 15);
      allRgb[kSurface] = allLuv[kSurface].toColor();

      allLuv[kBackground] = HSLuvColor.fromHSL(hue, 30, 10);
      allRgb[kBackground] = allLuv[kBackground].toColor();
    } else if (mode == Mode.Shazam) {
      final double hue = math.max(allLuv[kPrimary].hue - 38, 0);

      allLuv[kSurface] = HSLuvColor.fromHSL(hue, 55, 10);
      allRgb[kSurface] = allLuv[kSurface].toColor();

      allLuv[kBackground] = HSLuvColor.fromHSL(hue, 100, 5);
      allRgb[kBackground] = allLuv[kBackground].toColor();
    }
//    else if (mode == "Mix") {
//      allLuv[kSurface] = HSLuvColor.fromHSL(allLuv[kSurface].hue, 50, 12);
//      allRgb[kSurface] = allLuv[kSurface].toColor();
//
//      allLuv[kBackground] = HSLuvColor.fromHSL(allLuv[kBackground].hue, 25, 7);
//      allRgb[kBackground] = allLuv[kBackground].toColor();
//    }
  }

  void mapAllToState(List<Color> colors) {
    final Map<String, Color> allRgb = Map.from(state.rgbColors);

    int i = 0;
    allRgb.forEach((String title, Color b) {
      allRgb[title] = colors[i];
      i += 1;
    });

    emit(
      ColorState(
        allRgb,
        convertToHSLuv(allRgb),
        state.mode,
      ),
    );
  }

  void mapSingleToState({
    Color color,
    HSLuvColor hsLuvColor,
    Mode mode,
  }) {
    final Map<String, HSLuvColor> allLuv = Map.from(state.hsluvColors);
    final Map<String, Color> allRgb = Map.from(state.rgbColors);

    if (color != null) {
      allLuv[kPrimary] = HSLuvColor.fromColor(color);
      allRgb[kPrimary] = color;
    } else if (hsLuvColor != null) {
      allLuv[kPrimary] = hsLuvColor;
      allRgb[kPrimary] = hsLuvColor.toColor();
    }

    if (mode != null) {
      if (mode == Mode.WhatsApp) {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff00AC99);
      } else if (mode == Mode.Twitter) {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 97, 63);
//        allRgb[kPrimary] = Color(0xff1DA1F2);
      } else if (mode == Mode.Shazam) {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff005CCB);
      }
      allRgb[kPrimary] = allLuv[kPrimary].toColor();
//      allLuv[kPrimary] = HSLuvColor.fromColor(allRgb[kPrimary]);
    }

    final updatedMode = mode ?? state.mode;

    convertColors(allLuv, allRgb, updatedMode);

    emit(
      ColorState(
        allRgb,
        allLuv,
        updatedMode,
      ),
    );
  }
}
