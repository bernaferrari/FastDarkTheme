import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsluv/hsluvcolor.dart';

class ColorLuvLum {
  ColorLuvLum(this.color, this.luv) : lum = color.computeLuminance();

  final Color color;
  final HSLuvColor luv;
  final double lum;
}
