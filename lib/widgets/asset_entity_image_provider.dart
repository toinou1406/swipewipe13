import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetEntityImageProvider extends ImageProvider<AssetEntityImageProvider> {
  final AssetEntity assetEntity;
  final double scale;

  AssetEntityImageProvider(this.assetEntity, {this.scale = 1.0});

  @override
  Future<AssetEntityImageProvider> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(AssetEntityImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
    );
  }

  Future<ui.Codec> _loadAsync(AssetEntityImageProvider key) async {
    assert(key == this);
    final Uint8List? bytes = await key.assetEntity.originBytes;
    if (bytes == null) {
      throw Exception('Failed to load image');
    }
    final a = await ui.instantiateImageCodec(bytes);
    return a;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetEntityImageProvider &&
          runtimeType == other.runtimeType &&
          assetEntity == other.assetEntity &&
          scale == other.scale;

  @override
  int get hashCode => assetEntity.hashCode ^ scale.hashCode;
}
