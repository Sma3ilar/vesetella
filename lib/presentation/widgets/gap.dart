import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget symmetricPadding({double? h, double? w, Widget? child}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: h?.h ?? 0, horizontal: w?.w ?? 0),
    child: child,
  );
}

Widget onlyPadding(
    {double? top, double? bottom, double? right, double? left, Widget? child}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(
        top: top?.h ?? 0,
        bottom: bottom?.h ?? 0,
        end: right?.w ?? 0,
        start: left?.w ?? 0),
    child: child,
  );
}
