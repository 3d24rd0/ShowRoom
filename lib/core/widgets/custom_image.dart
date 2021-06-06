import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:showroom/core/widgets/circular_indicator.dart';

class CustomImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CustomImage(
      {Key? key, required this.path, this.height, this.width, this.fit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(child: CircularIndicator());
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: width,
              height: height,
            );
          case LoadState.failed:
            return Image.asset(
              "assets/notfound.jpeg",
              fit: BoxFit.fill,
            );
        }
      },
    );
  }
}
