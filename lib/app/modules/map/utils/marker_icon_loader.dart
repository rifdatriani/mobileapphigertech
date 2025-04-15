import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerIconLoader {
  static Future<BitmapDescriptor> load(String path, {int width = 64, int height = 64}) async {
    try {
      final byteData = await rootBundle.load(path);
      final codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetWidth: width,
        targetHeight: height,
      );
      final frame = await codec.getNextFrame();
      final imageData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.fromBytes(imageData!.buffer.asUint8List());
    } catch (e) {
      debugPrint('Error loading marker icon: $path - $e');
      return BitmapDescriptor.defaultMarker;
    }
  }
}
