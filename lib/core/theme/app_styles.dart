import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppStyles {

  static const appFont = 'Cairo';

  
  // Reusable text styles


  static TextStyle textStyle400({
    double? fontSize,
    Color? color,

  }) =>
      TextStyle(
        fontSize: (fontSize ?? 14).w,
        fontFamily: appFont,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.grey, // Define grey in AppColors
      );

  static TextStyle textStyle500({
    double? fontSize,
    Color? color,

  }) =>
      TextStyle(
        fontSize: (fontSize ?? 14).w,
        fontFamily: appFont,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black, // Define grey in AppColors
      );

  static TextStyle textStyle600({
    double? fontSize,
    Color? color,

  }) =>
      TextStyle(
        fontSize: (fontSize ?? 14).w,
        fontFamily: appFont,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.black, // Define grey in AppColors
      );

  static TextStyle textStyle700({
    double? fontSize,
    Color? color,

  }) =>
      TextStyle(
        fontSize: (fontSize ?? 14).w,
        fontFamily: appFont,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.blue500,
      );

  static TextStyle buttonTextStyle({
    double? fontSize = 14,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSize?.w,
        fontFamily: appFont,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? AppColors.white,
      );





}