import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:fastdarktheme/example/util/constants.dart';
import 'package:hsluv/hsluvcolor.dart';

import 'color.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitialState());

  @override
  Stream<ColorState> mapEventToState(
    ColorEvent event,
  ) async* {
    if (event is ColorLoadInitial) {
      yield* _mapInitialToState(event);
    } else if (event is ColorUpdateAll) {
      yield* _mapAllToState(event);
    } else if (event is ColorUpdateSingle) {
      yield* _mapSingleToState(event);
    }
  }

  Stream<ColorState> _mapInitialToState(ColorLoadInitial load) async* {
    final Map<String, Color> allRgb = {kPrimary: Color(0xff00AB9A)};
    final Map<String, HSLuvColor> allLuv = convertToHSLuv(allRgb);

    const mode = "WhatsApp";

    convertColors(allLuv, allRgb, mode);

    yield LoadedColorState(
      allRgb,
      allLuv,
      mode,
    );
  }

  Stream<ColorState> _mapSingleToState(ColorUpdateSingle load) async* {
    final currentState = state as LoadedColorState;

    final Map<String, HSLuvColor> allLuv = Map.from(currentState.hsluvColors);
    final Map<String, Color> allRgb = Map.from(currentState.rgbColors);

    if (load.color != null) {
      allLuv[kPrimary] = HSLuvColor.fromColor(load.color);
      allRgb[kPrimary] = load.color;
    } else if (load.hsLuvColor != null) {
      allLuv[kPrimary] = load.hsLuvColor;
      allRgb[kPrimary] = load.hsLuvColor.toColor();
    }

    if (load.mode != null) {
      if (load.mode == "WhatsApp") {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff00AC99);
      } else if (load.mode == "Twitter") {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 97, 63);
//        allRgb[kPrimary] = Color(0xff1DA1F2);
      } else if (load.mode == "Shazam") {
        allLuv[kPrimary] = HSLuvColor.fromHSL(allLuv[kPrimary].hue, 100, 63);
//        allRgb[kPrimary] = Color(0xff005CCB);
      }
      allRgb[kPrimary] = allLuv[kPrimary].toColor();
//      allLuv[kPrimary] = HSLuvColor.fromColor(allRgb[kPrimary]);
    }

    final mode = load.mode ?? (state as LoadedColorState).mode;

    convertColors(allLuv, allRgb, mode);

    yield LoadedColorState(
      allRgb,
      allLuv,
      mode,
    );
  }

  void convertColors(
    Map<String, HSLuvColor> allLuv,
    Map<String, Color> allRgb,
    String mode,
  ) {
    if (mode == "WhatsApp") {
      final hue1 = (allLuv[kPrimary].hue + 30) % 360;
      allLuv[kSurface] = HSLuvColor.fromHSL(hue1, 40, 10);
      allRgb[kSurface] = allLuv[kSurface].toColor();

      final double hue2 = (allLuv[kPrimary].hue + 35) % 360;
      allLuv[kBackground] = HSLuvColor.fromHSL(hue2, 40, 5);
      allRgb[kBackground] = allLuv[kBackground].toColor();
    } else if (mode == "Twitter") {
      final double hue = (allLuv[kPrimary].hue + 10) % 360;

      allLuv[kSurface] = HSLuvColor.fromHSL(hue, 35, 15);
      allRgb[kSurface] = allLuv[kSurface].toColor();

      allLuv[kBackground] = HSLuvColor.fromHSL(hue, 30, 10);
      allRgb[kBackground] = allLuv[kBackground].toColor();
    } else if (mode == "Shazam") {
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

  Stream<ColorState> _mapAllToState(ColorUpdateAll load,) async* {
    final currentState = state as LoadedColorState;

    final Map<String, Color> allRgb = Map.from(currentState.rgbColors);

    int i = 0;
    allRgb.forEach((String title, Color b) {
      allRgb[title] = load.colors[i];
      i += 1;
    });

    yield LoadedColorState(
      allRgb,
      convertToHSLuv(allRgb),
      currentState.mode,
    );
  }

  Map<String, HSLuvColor> convertToHSLuv(Map<String, Color> updatableMap) {
    final Map<String, HSLuvColor> luvMap = <String, HSLuvColor>{};

    for (String key in updatableMap.keys) {
      luvMap[key] = HSLuvColor.fromColor(updatableMap[key]);
    }

    return luvMap;
  }
}
