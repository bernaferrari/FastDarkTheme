import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class TwitterPreview extends StatelessWidget {
  const TwitterPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).colorScheme.surface,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              "Who to follow",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            color: Colors.white24,
            height: 1.0,
          ),
          ListTile(
            title: const Text("Shipping"),
            subtitle: const Text("@company"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.truck,
                size: 24.0,
                color: primary,
              ),
            ),
            trailing: SizedBox(
              width: 64.0,
              height: 36.0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0.0,
                  primary: primary,
                  textStyle: TextStyle(color: primary),
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                child: Text(
                  "Follow",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: primary),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            color: Colors.white24,
            height: 1.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              "View more",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: primary),
            ),
          ),
        ],
      ),
    );
  }
}
