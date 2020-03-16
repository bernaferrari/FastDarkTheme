import 'package:fastdarktheme/example/util/constants.dart';
import 'package:flutter/material.dart';

import 'color_luv_lum.dart';

class PickerItem extends StatelessWidget {
  const PickerItem({
    this.colorLuvLum,
    this.onPressed,
    this.currentValue,
  });

  final ColorLuvLum colorLuvLum;
  final Function onPressed;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    final Color textColor = (colorLuvLum.lum < kLumContrast)
        ? Colors.white.withOpacity(0.87)
        : Colors.black87;

    return SizedBox(
      height: 56,
      child: MaterialButton(
        elevation: 0,
        padding: EdgeInsets.zero,
        color: currentValue == colorLuvLum.luv.hue
            ? Colors.black38
            : colorLuvLum.color,
        shape: const RoundedRectangleBorder(),
        onPressed: onPressed,
        child: Text(
          colorLuvLum.luv.hue.round().toString(),
          style: Theme.of(context).textTheme.caption.copyWith(color: textColor),
        ),
      ),
    );
  }
}
