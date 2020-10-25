import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class TwitterPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      color: surface,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              "Who to follow",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: Text("Shipping"),
            subtitle: Text("@company"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.truck,
                size: 24,
                color: primary,
              ),
            ),
            trailing: SizedBox(
              width: 64,
              height: 36,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  primary: primary,
                  textStyle: TextStyle(color: primary),
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  "Follow",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: primary),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            color: Colors.white24,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              "View more",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: primary),
            ),
          ),
        ],
      ),
    );
  }
}
