import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_styles.dart';
import '../../core/theme/colors.dart';
import 'app_button.dart';

class JoinUsCard extends StatelessWidget {
  const JoinUsCard(this.title, this.onPress, {super.key});
  final String title;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 23.w, vertical: 32.h),
            width: 360.w,
            height: 136.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppStyles.textStyle700(
                      fontSize: 22.w, color: AppColors.black),
                ),
                12.verticalSpace,
                AppIconButton(
                  buttonColor: const Color(0xFFEAEBF0),
                  height: 24.h,
                  width: 45.w,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.orange500,
                    size: 16.r,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          bottom: 0.0,
          start: 0.0,
          end: 0.0,
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              width: double.infinity,
              height: 4.h,
              decoration: BoxDecoration(color: AppColors.blue500),
            ),
          ),
        ),
      ],
    );
  }
}