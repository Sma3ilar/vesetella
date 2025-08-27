import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pg_web/core/theme/colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.action});

  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // color: const Color(0xFF323232),
      icon: Icon(Icons.arrow_back_ios_new, size: 24, color: AppColors.blue500),
      onPressed: () {
        if (action != null) {
          action!();
        } else {
          Get.back();
        }
      },
    );
  }
}
