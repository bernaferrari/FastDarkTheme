import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class WhatsAppPreview extends StatelessWidget {
  const WhatsAppPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: <Widget>[
        Text(
          "11 participants",
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(color: primary),
        ),
        const SizedBox(height: 8.0),
        ListTile(
          title: const Text("Bernardo"),
          subtitle: const Text("How are you doing?"),
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
          title: const Text("Leonardo di Catrio"),
          subtitle: const Text("Meaw"),
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
    );
  }
}
