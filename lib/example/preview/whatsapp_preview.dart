import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class WhatsAppPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "11 participants",
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(color: primary),
          ),
          SizedBox(height: 8.0),
          ListTile(
            title: Text("Bernardo"),
            subtitle: Text("How are you doing?"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.smile,
                size: 24.0,
                color: primary,
              ),
            ),
            trailing: Icon(
              FeatherIcons.check,
              size: 16.0,
              color: primary,
            ),
          ),
          ListTile(
            title: Text("Leonardo di Catrio"),
            subtitle: Text("Meaw"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.github,
                size: 24.0,
                color: primary,
              ),
            ),
            trailing: Icon(
              FeatherIcons.x,
              size: 16.0,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}
