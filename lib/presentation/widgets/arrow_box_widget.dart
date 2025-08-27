import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/colors.dart';

class ArrowBoxWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const ArrowBoxWidget({super.key,
    this.width = 45,
    this.height = 24,
    this.backgroundColor = AppColors.orange500,
    this.icon = Icons.arrow_forward,
    this.iconColor = AppColors.white,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Icon(
        icon,
        color: iconColor,
        size: iconSize.w,
      ),
    );
  }
}
