import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hsluv/hsluvcolor.dart';

import '../mode.dart';

abstract class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

class ColorInitialState extends ColorState {}

class LoadedColorState extends ColorState {
  const LoadedColorState(
    this.rgbColors,
    this.hsluvColors,
    this.mode,
  );

  final Map<String, Color> rgbColors;
  final Map<String, HSLuvColor> hsluvColors;
  final Mode mode;

  @override
  String toString() => 'MDCLoadedState state with selected: $mode';

  @override
  List<Object> get props => [rgbColors, hsluvColors, mode];
}
