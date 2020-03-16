import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hsluv/hsluvcolor.dart';
import 'package:infinite_listview/infinite_listview.dart';

import 'color_luv_lum.dart';
import 'picker_item.dart';

class PickerList extends StatelessWidget {
  const PickerList({
    this.currentValue,
    this.sectionIndex,
    this.listSize,
    this.colorsList,
    this.onColorPressed,
  });

  final Function(HSLuvColor) onColorPressed;

  final List<ColorLuvLum> colorsList;
  final int currentValue;
  final int sectionIndex;
  final int listSize;

  Widget colorCompare(int index) {
    return PickerItem(
      colorLuvLum: colorsList[index],
      currentValue: currentValue,
      onPressed: () => onColorPressed(colorsList[index].luv),
    );
  }

  @override
  Widget build(BuildContext context) {
    // todo works when scrolling/dragging, but still buggy.
//    return Stack(
//      children: <Widget>[
//        _CupertinoPicker(
//          listSize: listSize,
//          colorsList: colorsList,
//          title: title,
//          onColorPressed: onColorPressed,
//        ),
//        IgnorePointer(
//          child: Center(
//            child: Container(
//              color: Colors.white38,
//              constraints: BoxConstraints.expand(
//                height: 60,
//              ),
//            ),
//          ),
//        ),
//      ],
//    );

//    return CupertinoTheme(
//      data: CupertinoThemeData(brightness: Brightness.dark),
//      child: CupertinoPicker.builder(
//          itemExtent: 80,
//          itemBuilder: (BuildContext context, int absoluteIndex) {
//            return colorCompare(absoluteIndex % listSize);
//          },
//          childCount: listSize,
//          onSelectedItemChanged: (value) {
//            onColorPressed(colorsList[value].inter);
//            print("selected value is $value");
//          }),
//    );

    return InfiniteListView.builder(
      scrollDirection: Axis.vertical,
      key: PageStorageKey<String>("$sectionIndex"),
      itemBuilder: (BuildContext context, int absoluteIndex) {
        return colorCompare(absoluteIndex % listSize);
      },
    );
  }
}
