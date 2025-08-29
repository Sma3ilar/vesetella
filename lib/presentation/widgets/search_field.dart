import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';

import '../../core/constants/tr_keys.dart';
import '../../core/theme/app_styles.dart';
import '../../core/theme/colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? textController;
  final Function(String query)? onChanged;

  const SearchField({super.key, this.textController, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        style: AppStyles.textStyle400(fontSize: 14.sp, color: AppColors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 12.h,
          ),
          hintText: TrKeys.search,
          hintStyle: AppStyles.textStyle400(
            fontSize: 14.sp,
            color: const Color(0xFFBABABA),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20.r,
            color: const Color(0xFFBABABA),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: const BorderSide(color: Color(0xFFBABABA), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: const BorderSide(color: Color(0xFFBABABA), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: const BorderSide(color: AppColors.blue500, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class TappableSearchField extends StatelessWidget {
  final VoidCallback onTap;

  const TappableSearchField({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        width: 326.w,
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFBABABA), // light gray from Figma
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 20.r, color: const Color(0xFFBABABA)),
            SizedBox(width: 12.w),
            Text(
              TrKeys.search,
              style: AppStyles.textStyle400(
                fontSize: 14.sp,
                color: const Color(0xFFBABABA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
