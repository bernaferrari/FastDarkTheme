import 'package:fastdarktheme/example/util/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsluv/hsluvcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'blocs/color_cubit.dart';
import 'blocs/mode.dart';

class UpperMobileLayout extends StatelessWidget {
  const UpperMobileLayout(this.character);

  final int character;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final controller = PageController(viewportFraction: 0.8);

    return Column(
      children: <Widget>[
        SizedBox(
          height: 200, // 56 * 3 + 32
          child: PageView(
            controller: controller,
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(right: 8),
                clipBehavior: Clip.antiAlias,
                color: Colors.black,
                child: SelectableItems(character),
              ),
              Card(
                margin: EdgeInsets.only(left: 8),
                clipBehavior: Clip.antiAlias,
                color: Colors.black,
                child: ColorOutput(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: controller,
            count: 2,
            effect: SlideEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: primary,
              dotColor: Colors.white12,
            ),
          ),
        ),
      ],
    );
  }
}

class SelectableItems extends StatelessWidget {
  const SelectableItems(this.character);

  final int character;

  @override
  Widget build(BuildContext context) {
    final selectable = Mode.values;

    // the output of enum is Mode.WhatsApp, so remove the beginning.
    final strSelectable = selectable
        .map((d) => d.toString().replaceFirst("Mode.", ""))
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < selectable.length; i++)
          RadioListTile<int>(
            title: Text(strSelectable[i]),
            value: i,
            groupValue: character,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (int value) {
              context.bloc<ColorCubit>().mapSingleToState(mode: selectable[i]);
            },
          ),
      ],
    );
  }
}

class ColorOutput extends StatefulWidget {
  @override
  _ColorOutputState createState() => _ColorOutputState();
}

class _ColorOutputState extends State<ColorOutput> {
  int currentSegment;

  final Map<int, Widget> children = const <int, Widget>{
    0: Text("HEX"),
    1: Text("RGB"),
    2: Text("HSLuv"),
    3: Text("HSV"),
  };

  @override
  void initState() {
    currentSegment = PageStorage.of(context).readState(
          context,
          identifier: const ValueKey("Selectable"),
        ) ??
        0;

    super.initState();
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text('$text copied'),
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;
    final background = Theme.of(context).colorScheme.background;

    final arr = [primary, surface, background];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoSlidingSegmentedControl<int>(
            children: children,
            backgroundColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.20),
            thumbColor: primary,
            onValueChanged: onValueChanged,
            groupValue: currentSegment,
          ),
          SizedBox(height: 8),
          for (int i = 0; i < arr.length; i++)
            RaisedButton(
              color: arr[i],
              child: Text(arr[i].retrieveColorStr(currentSegment)),
              onPressed: () {
                copyToClipboard(
                    context, arr[i].retrieveColorStr(currentSegment));
              },
            ),
        ],
      ),
    );
  }

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
      PageStorage.of(context).writeState(
        context,
        currentSegment,
        identifier: const ValueKey("Selectable"),
      );
    });
  }
}

extension on Color {
  String retrieveColorStr(int kind) {
    switch (kind) {
      case 0:
        return toHexStr();
      case 1:
        return "R:$red G:$green B:$blue";
      case 2:
        final hsluv = HSLuvColor.fromColor(this);
        return "H:${hsluv.hue.round()} S:${hsluv.saturation.round()} L:${hsluv.lightness.round()}";
      case 3:
        final hsv = HSVColor.fromColor(this);
        return "H:${hsv.hue.round()} S:${(hsv.saturation * 100).round()} V:${(hsv.value * 100).round()}";
      default:
        return "error!";
    }
  }
}
