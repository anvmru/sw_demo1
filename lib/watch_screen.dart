import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

class WatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return mode == WearMode.active
                ? ActiveWatchFace(shape: shape)
                : AmbientWatchFace(shape: shape);
          },
        );
      },
    );
  }
}

class ActiveWatchFace extends StatelessWidget {
  const ActiveWatchFace({super.key, required this.shape});
  final WearShape shape;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Active mode ($shape)"));
  }
}

class AmbientWatchFace extends StatelessWidget {
  const AmbientWatchFace({super.key, required this.shape});
  final WearShape shape;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Ambient mode ($shape)"));
  }
}
