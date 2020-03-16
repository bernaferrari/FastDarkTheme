import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hsluv/hsluvcolor.dart';

abstract class SelectionEvent extends Equatable {
  const SelectionEvent();
}

class UpdateSelectedColor extends SelectionEvent {
  const UpdateSelectedColor({
    this.color,
    this.hsLuvColor,
    this.mode,
  });

  final Color color;
  final HSLuvColor hsLuvColor;
  final String mode;

  @override
  String toString() => "MDCUpdateColor... $color | $mode | $hsLuvColor";

  @override
  List<Object> get props => [color, hsLuvColor, mode];
}

class UpdateAllSelectedColors extends SelectionEvent {
  const UpdateAllSelectedColors({
    this.colors,
  });

  final List<Color> colors;

  @override
  String toString() => "MDCUpdateAllEvent... $colors";

  @override
  List<Object> get props => [colors];
}
