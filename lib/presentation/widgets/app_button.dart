import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_styles.dart';
import '../../core/theme/colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color buttonColor;
  final String text;
  final TextStyle textStyle;
  final double elevation;
  final double height;
  final double width;

  const AppButton({
    super.key,
    this.onPressed,
    this.buttonColor = AppColors.orange500,
    this.text = 'Start',
    this.textStyle = const TextStyle(),
    this.elevation = 2,
    this.height = 36,
    this.width = 84,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            // try to wrap with Fitted box ...
            FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow
                .ellipsis, // Use ellipsis to indicate text is clipped
            maxLines: 1,
            style: (textStyle.isBlank ?? false)
                ? AppStyles.buttonTextStyle()
                : textStyle,
          ),
        ),
      ),
    );
  }

/*Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          maxLines: 1,
          style: (textStyle.isBlank ?? false) ? AppStyles.buttonTextStyle() : textStyle,
        ),
      ),
    );
  }*/
}

class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color buttonColor;
  final Widget child;
  final TextStyle textStyle;
  final double elevation;
  final double height;
  final double width;

  const AppIconButton({
    super.key,
    this.onPressed,
    this.buttonColor = AppColors.orange500,
    this.child = const Icon(Icons.arrow_forward_rounded),
    this.textStyle = const TextStyle(),
    this.elevation = 2,
    this.height = 36,
    this.width = 84,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
