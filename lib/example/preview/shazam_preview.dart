import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ShazamPreview extends StatelessWidget {
  const ShazamPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(child: _Song("Heidi", "Kurt Darren")),
              Expanded(child: _Song("Helium", "Sia")),
            ],
          ),
          ListTile(
            title: Text(
              "Suggestions",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18.0),
            ),
            trailing: Text(
              "342",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16.0,
                    color: primary,
                  ),
            ),
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FeatherIcons.coffee,
                size: 24.0,
                color: Colors.white38,
              ),
            ),
          ),
          const Divider(indent: 72.0, height: 1.0),
          ListTile(
            title: Text(
              "Playlists For You",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18.0),
            ),
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
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

class _Song extends StatelessWidget {
  final String title;
  final String band;

  const _Song(this.title, this.band, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.white24,
            height: 60.0,
            width: 60.0,
            child: const Icon(
              FeatherIcons.disc,
              size: 36.0,
              color: Colors.white38,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    band,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
