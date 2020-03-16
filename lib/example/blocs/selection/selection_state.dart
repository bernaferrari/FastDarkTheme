import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hsluv/hsluvcolor.dart';

abstract class SelectionState extends Equatable {
  const SelectionState();
}

class LoadedSelectionState extends SelectionState {
  const LoadedSelectionState(
    this.rgbColors,
    this.hsluvColors,
    this.mode,
  );

  final Map<String, Color> rgbColors;
  final Map<String, HSLuvColor> hsluvColors;
  final String mode;

  @override
  String toString() => 'MDCLoadedState state with selected: $mode';

  @override
  List<Object> get props => [rgbColors, hsluvColors, mode];
}
