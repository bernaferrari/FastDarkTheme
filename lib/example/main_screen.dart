import 'package:fastdarktheme/example/preview/shazam_preview.dart';
import 'package:fastdarktheme/example/preview/twitter_preview.dart';
import 'package:fastdarktheme/example/preview/whatsapp_preview.dart';
import 'package:fastdarktheme/example/select_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'blocs/color_cubit.dart';
import 'blocs/mode.dart';
import 'picker/hue_picker.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  final bool contrastMode = true;
  final int currentSegment = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
        builder: (BuildContext builderContext, ColorState state) {
      final primary = state.rgbColors[SchemeTypes.primary]!;
      final background = state.rgbColors[SchemeTypes.background]!;
      final surface = state.rgbColors[SchemeTypes.surface]!;

      final primaryLuv = state.hsluvColors[SchemeTypes.primary]!;

      final int selectedIndex = Mode.values.indexOf(state.mode);

      return Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.dark(
            primary: primary,
            secondary: primary,
            surface: surface,
            background: background,
          ),
          textTheme: TextTheme(
            button: GoogleFonts.b612Mono(),
              ),
            ).copyWith(
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 48.0,
              ),
              cardTheme: Theme.of(context).cardTheme,
            ),
            child: Scaffold(
              body: Row(
                children: <Widget>[
                  HuePicker(
                    color: primary,
                    hsluvColor: primaryLuv,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(FeatherIcons.github),
                              tooltip: "GitHub",
                              onPressed: () async {
                                await launch(
                                    "https://github.com/bernaferrari/fastdarktheme");
                              },
                            ),
                              ),
                            ),
                          ),
                          if (MediaQuery.of(context).size.width < 400.0)
                            UpperMobileLayout(selectedIndex)
                      else
                            Card(
                              margin: const EdgeInsets.all(16.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.black,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: SelectableItems(selectedIndex)),
                              const Expanded(child: ColorOutput()),
                            ],
                          ),
                        ),
//                      Text(
//                        "Preview",
//                        textAlign: TextAlign.center,
//                        style: Theme.of(context).textTheme.titleLarge,
//                      ),
                      const SizedBox(height: 8.0),
                      if (MediaQuery.of(context).size.width > 650)
                        Row(
                          children: <Widget>[
                            const Expanded(child: TwitterPreview()),
                            const Expanded(child: WhatsAppPreview()),
                            if (MediaQuery.of(context).size.width > 940)
                              const Expanded(child: ShazamPreview()),
                          ],
                        ),
                      if (MediaQuery.of(context).size.width <= 650) ...[
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          clipBehavior: Clip.antiAlias,
                          color: surface,
                          elevation: 0.0,
                          child: const TwitterPreview(),
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          clipBehavior: Clip.antiAlias,
                          color: background,
                          elevation: 0.0,
                          child: const WhatsAppPreview(),
                        ),
                      ],
                      if (MediaQuery.of(context).size.width <= 940) ...[
                        const SizedBox(height: 16.0),
                        const ShazamPreview(),
                        const SizedBox(height: 16.0),
                      ],
                      const SizedBox(height: 24.0),
                    ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
