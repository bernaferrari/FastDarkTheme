import 'package:fastdarktheme/example/blocs/blocs.dart';
import 'package:fastdarktheme/example/preview/shazam_preview.dart';
import 'package:fastdarktheme/example/preview/twitter_preview.dart';
import 'package:fastdarktheme/example/preview/whatsapp_preview.dart';
import 'package:fastdarktheme/example/select_mode.dart';
import 'package:fastdarktheme/example/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'picker/hue_picker.dart';
import 'util/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

final List<String> selectable = ["Twitter", "WhatsApp", "Shazam"];

class _MainScreenState extends State<MainScreen> {
  final bool contrastMode = true;
  final int currentSegment = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionBloc, SelectionState>(
        builder: (BuildContext builderContext, SelectionState state) {
      final primary = (state as LoadedSelectionState).rgbColors[kPrimary];
      final background = (state as LoadedSelectionState).rgbColors[kBackground];
      final surface = (state as LoadedSelectionState).rgbColors[kSurface];

      final primaryLuv = (state as LoadedSelectionState).hsluvColors[kPrimary];

      final int _character =
          selectable.indexOf((state as LoadedSelectionState).mode);

      return Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.dark(
            primary: primary,
            surface: surface,
            background: background,
          ),
          textTheme: TextTheme(
            button: GoogleFonts.b612Mono(),
          ),
        ).copyWith(
          accentColor: primary,
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 48,
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
                              icon: Icon(FeatherIcons.github),
                              tooltip: "GitHub",
                              onPressed: () async {
                                await launch(
                                    "https://github.com/bernaferrari/fastdarktheme");
                              },
                            ),
                          ),
                        ),
                      ),
                      if (MediaQuery.of(context).size.width < 400)
                        UpperMobileLayout(_character)
                      else
                        Card(
                          margin: EdgeInsets.all(16),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.black,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: SelectableItems(_character),
                              ),
                              Expanded(
                                child: ColorOutput(),
                              ),
                            ],
                          ),
                        ),
//                      Text(
//                        "Preview",
//                        textAlign: TextAlign.center,
//                        style: Theme.of(context).textTheme.headline6,
//                      ),
                      SizedBox(height: 8),
                      if (MediaQuery.of(context).size.width > 650)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                clipBehavior: Clip.antiAlias,
                                color: surface,
                                elevation: 0,
                                child: TwitterPreview(),
                              ),
                            ),
                            Expanded(child: WhatsAppPreview()),
                            if (MediaQuery.of(context).size.width > 940)
                              Expanded(child: ShazamPreview()),
                          ],
                        ),
                      if (MediaQuery.of(context).size.width <= 650) ...[
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.antiAlias,
                          color: surface,
                          elevation: 0,
                          child: TwitterPreview(),
                        ),
                        SizedBox(height: 16),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.antiAlias,
                          color: background,
                          elevation: 0,
                          child: WhatsAppPreview(),
                        ),
                      ],
                      if (MediaQuery.of(context).size.width <= 940) ...[
                        SizedBox(height: 16),
                        ShazamPreview(),
                        SizedBox(height: 16),
                      ],
                      SizedBox(height: 24),
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
