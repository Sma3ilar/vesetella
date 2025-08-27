import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_web/core/constants/app_assets.dart';
import 'loading_indicator.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = 392,
    this.height = 360,
    this.fit = BoxFit.cover,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width.w,
      height: height.h,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider, fit: fit),
          boxShadow: const [
            BoxShadow(
              color: Color(
                0x1F000000,
              ), // reduce opacity (0x1F = ~12% opacity vs 0x3F = ~25%)
              blurRadius: 2, // less blur
              offset: Offset(0, 2), // smaller offset
              spreadRadius: 0,
            ),
          ],
        ),
      ),
      placeholder: (context, url) =>
          const LoadingIndicatorWidget(), // Loading state
      errorWidget: (context, url, error) =>
          Image.asset(AppAssets.logoPng, width: width.w, height: height.h),
      // errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
