import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pg_web/core/constants/app_assets.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.isGif = false,
    this.isLottie = false,
    this.isSvg = false,
  });

  final bool isGif, isLottie, isSvg;

  @override
  Widget build(BuildContext context) {
    if (isGif) {
      return Image.asset(AppAssets.logoGif, height: 392.w, width: 392.w);
    } else if (isLottie) {
      return SizedBox.shrink();
    } else if (isSvg) {
      return SvgPicture.asset(AppAssets.logoSVG, fit: BoxFit.cover);
    } else {
      return Image.asset(
        AppAssets.logoPng,
        fit: BoxFit.contain,
        height: 200.w,
        width: 200.w,
      );
    }
  }
}
