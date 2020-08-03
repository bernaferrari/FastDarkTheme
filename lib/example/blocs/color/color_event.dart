import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hsluv/hsluvcolor.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();

  @override
  List<Object> get props => [];
}

class ColorLoadInitial extends ColorEvent {}

class ColorUpdateSingle extends ColorEvent {
  const ColorUpdateSingle({
    this.color,
    this.hsLuvColor,
    this.mode,
  });

  final Color color;
  final HSLuvColor hsLuvColor;
  final String mode;

  @override
  String toString() => "UpdateColor... $color | $mode | $hsLuvColor";

  @override
  List<Object> get props => [color, hsLuvColor, mode];
}

class ColorUpdateAll extends ColorEvent {
  const ColorUpdateAll({
    this.colors,
  });

  final List<Color> colors;

  @override
  String toString() => "UpdateAllEvent... $colors";

  @override
  List<Object> get props => [colors];
}
