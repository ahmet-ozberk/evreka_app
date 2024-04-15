import 'package:evreka_app/app/extension/widget_extension.dart';
import 'package:evreka_app/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MarkerWidget extends StatelessWidget {
  final bool isActive;
  const MarkerWidget({super.key, this.isActive = false});

  static const _size = Size(121, 160);

  static Future<BitmapDescriptor> getIcon({bool isActive = false, double? opacity}) async {
    return await MarkerWidget(isActive: isActive).opaque(opacity: opacity ?? 1.0)
        .toBitmapDescriptor(logicalSize: _size, imageSize: _size);
  }

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Image.asset(
        Assets.image.imActivePinPNG,
        width: _size.width,
        height: _size.height,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        Assets.image.imDefaultPinPNG,
        width: _size.width,
        height: _size.height,
        fit: BoxFit.cover,
      );
    }
  }
}
