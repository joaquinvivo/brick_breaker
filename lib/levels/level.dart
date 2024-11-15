import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {
  Level({required this.levelName});

  final String levelName;
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnpoint in spawnPointsLayer!.objects) {
      switch (spawnpoint.class_) {
        case 'Player':
          final player = Player(
              character: 'Ninja Frog',
              position: Vector2(spawnpoint.x, spawnpoint.y));
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
