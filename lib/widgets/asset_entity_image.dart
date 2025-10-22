import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetEntityImage extends StatelessWidget {
  final AssetEntity assetEntity;
  final BoxFit? fit;

  const AssetEntityImage({super.key, required this.assetEntity, this.fit});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: assetEntity.thumbnailData,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            fit: fit,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
