import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ShazamPreview extends StatelessWidget {
  Widget song(BuildContext context, String title, String band) {
    final surface = Theme.of(context).colorScheme.surface;

    return Card(
      elevation: 0.0,
      color: surface,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.white24,
            height: 60.0,
            width: 60.0,
            child: Icon(FeatherIcons.disc, size: 36.0, color: Colors.white38),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    band,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: song(context, "Heidi", "Kurt Darren"),
              ),
              Expanded(
                child: song(context, "Helium", "Sia"),
              ),
            ],
          ),
          ListTile(
            title: Text(
              "Suggestions",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 18.0),
            ),
            trailing: Text(
              "342",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 16.0,
                    color: primary,
                  ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.coffee,
                size: 24.0,
                color: Colors.white38,
              ),
            ),
          ),
          Divider(indent: 72.0, height: 1.0),
          ListTile(
            title: Text(
              "Playlists For You",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 18.0),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.music,
                size: 24.0,
                color: Colors.white38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
