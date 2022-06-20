import 'dart:math' as math;
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hsluv/hsluvcolor.dart';

import 'mode.dart';

class ColorState extends Equatable {
  const ColorState(
    this.rgbColors,
    this.hsluvColors,
    this.mode,
  );

  final Map<SchemeTypes, Color> rgbColors;
  final Map<SchemeTypes, HSLuvColor> hsluvColors;
  final Mode mode;

  @override
  String toString() => 'ColorState with mode $mode';

  @override
  List<Object> get props => [rgbColors, hsluvColors, mode];
}

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(_initialState());

  static ColorState _initialState({Mode mode = Mode.whatsapp}) {
    final Map<SchemeTypes, Color> allRgb = {
      SchemeTypes.primary: const Color(0xff00AB9A)
    };
    final Map<SchemeTypes, HSLuvColor> allLuv = convertToHSLuv(allRgb);
    convertColors(allLuv, allRgb, mode);

    return ColorState(allRgb, allLuv, mode);
  }

  static Map<SchemeTypes, HSLuvColor> convertToHSLuv(
      Map<SchemeTypes, Color> updatableMap) {
    final Map<SchemeTypes, HSLuvColor> luvMap = <SchemeTypes, HSLuvColor>{};

    for (SchemeTypes key in updatableMap.keys) {
      luvMap[key] = HSLuvColor.fromColor(updatableMap[key]!);
    }

    return luvMap;
  }

  static void convertColors(
    Map<SchemeTypes, HSLuvColor> allLuv,
    Map<SchemeTypes, Color> allRgb,
    Mode mode,
  ) {
    if (mode == Mode.whatsapp) {
      final hue1 = (allLuv[SchemeTypes.primary]!.hue + 30) % 360;
      allLuv[SchemeTypes.surface] = HSLuvColor.fromHSL(hue1, 40, 10);
      allRgb[SchemeTypes.surface] = allLuv[SchemeTypes.surface]!.toColor();

      final double hue2 = (allLuv[SchemeTypes.primary]!.hue + 35) % 360;
      allLuv[SchemeTypes.background] = HSLuvColor.fromHSL(hue2, 40, 5);
      allRgb[SchemeTypes.background] =
          allLuv[SchemeTypes.background]!.toColor();
    } else if (mode == Mode.twitter) {
      final double hue = (allLuv[SchemeTypes.primary]!.hue + 10) % 360;

      allLuv[SchemeTypes.surface] = HSLuvColor.fromHSL(hue, 35, 15);
      allRgb[SchemeTypes.surface] = allLuv[SchemeTypes.surface]!.toColor();

      allLuv[SchemeTypes.background] = HSLuvColor.fromHSL(hue, 30, 10);
      allRgb[SchemeTypes.background] =
          allLuv[SchemeTypes.background]!.toColor();
    } else if (mode == Mode.shazam) {
      final double hue = math.max(allLuv[SchemeTypes.primary]!.hue - 38, 0);

      allLuv[SchemeTypes.surface] = HSLuvColor.fromHSL(hue, 55, 10);
      allRgb[SchemeTypes.surface] = allLuv[SchemeTypes.surface]!.toColor();

      allLuv[SchemeTypes.background] = HSLuvColor.fromHSL(hue, 100, 5);
      allRgb[SchemeTypes.background] =
          allLuv[SchemeTypes.background]!.toColor();
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
    final Map<SchemeTypes, Color> allRgb = Map.from(state.rgbColors);

    int i = 0;
    allRgb.forEach((SchemeTypes key, Color b) {
      allRgb[key] = colors[i];
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
    Color? color,
    HSLuvColor? hsLuvColor,
    Mode? mode,
  }) {
    final Map<SchemeTypes, HSLuvColor> allLuv = Map.from(state.hsluvColors);
    final Map<SchemeTypes, Color> allRgb = Map.from(state.rgbColors);

    if (color != null) {
      allLuv[SchemeTypes.primary] = HSLuvColor.fromColor(color);
      allRgb[SchemeTypes.primary] = color;
    } else if (hsLuvColor != null) {
      allLuv[SchemeTypes.primary] = hsLuvColor;
      allRgb[SchemeTypes.primary] = hsLuvColor.toColor();
    }

    if (mode != null) {
      if (mode == Mode.whatsapp) {
        allLuv[SchemeTypes.primary] =
            HSLuvColor.fromHSL(allLuv[SchemeTypes.primary]!.hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff00AC99);
      } else if (mode == Mode.twitter) {
        allLuv[SchemeTypes.primary] =
            HSLuvColor.fromHSL(allLuv[SchemeTypes.primary]!.hue, 97, 63);
//        allRgb[kPrimary] = Color(0xff1DA1F2);
      } else if (mode == Mode.shazam) {
        allLuv[SchemeTypes.primary] =
            HSLuvColor.fromHSL(allLuv[SchemeTypes.primary]!.hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff005CCB);
      }
      allRgb[SchemeTypes.primary] = allLuv[SchemeTypes.primary]!.toColor();
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
