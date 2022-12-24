import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;

  final Duration? placeholderFadeInDuration;

  final Duration? fadeOutDuration;

  final Curve? fadeOutCurve;

  final Duration? fadeInDuration;

  final Curve? fadeInCurve;

  final double? height;
  final double? width;

  final BoxFit? fit;

  final Alignment alignment;

  final ImageRepeat? repeat;

  final bool? matchTextDirection;

  final Map<String, String>? httpHeaders;

  final bool? useOldImageOnUrlChange;

  final Color? color;

  final BlendMode? colorBlendMode;

  final FilterQuality? filterQuality;

  final int? memCacheWidth;

  final int? memCacheHeight;

  final int? maxWidthDiskCache;

  final int? maxHeightDiskCache;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.httpHeaders,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imageUri = imageUrl.contains('bodyremix')
        ? imageUrl.replaceFirst('https', 'http')
        : imageUrl;
    // return ExtendedImage.network(
    //   imageUrl,
    //   alignment: alignment,
    //   fit: fit,
    //   height: height,
    //   width: width,
    //   color: color,
    // );
    // log('imageUrl: ${imageUri}');
    return imageUri.isEmpty
        ? Center(
            child: SvgPicture.asset(
            Constants.imagePlaceholder,
            height: height,
            width: width,
          ))
        : CachedNetworkImage(
            imageUrl: imageUri,

            fit: fit,
            height: height,
            width: width,
            color: color,
            // placeholder: placeholder,
            alignment: alignment,
            // loadingBuilder: (context, child, loadingProgress) {
            //   return Center(
            //       child: SvgPicture.asset(
            //     Constants.imagePlaceholder,
            //   ));
            // },
            errorWidget: (context, url, error) {
              return Center(
                  child: SvgPicture.asset(
                Constants.imagePlaceholder,
              ));
            },
          );
    // return Image(
    //     fit: fit,
    //     height: height,
    //     width: width,
    //     color: color,
    //     loadingBuilder: (context, child, loadingProgress) =>
    //         loadingProgress == null
    //             ? child
    //             : Center(
    //                 child: CustomCircularProgressIndicator(
    //                 color: UIColors.BROWN,
    //                 // value: loadingProgress.cumulativeBytesLoaded /
    //                 //     loadingProgress.expectedTotalBytes
    //               )),
    //     alignment: alignment,
    //     errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
    //     image: NetworkImage(imageUrl));
  }
}
