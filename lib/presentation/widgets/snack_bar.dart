import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pg_web/core/theme/app_styles.dart';
import 'package:pg_web/core/theme/colors.dart';

void showMessage(String message, bool? good) {
  print('SB: $message');
  Color color = (good == true) ? AppColors.blue400 : Colors.redAccent;
  Get.showSnackbar(
    GetSnackBar(
      // shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8.0.r,
      maxWidth: 400, // Limit max width for web
      margin: EdgeInsets.only(bottom: 12.0.h, left: 0, right: 0),
      icon: Icon(
        good == true ? Icons.check_circle : Icons.info,
        // good == true ? Icons.check_circle : Icons.info,
        color: Colors.white,
        size: 24,
      ),
      message: message,
      messageText: Text(
        message,
        style: AppStyles.textStyle600(color: AppColors.white),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
    ),
  );
}
/*showMessage(String message, bool good) {
  print(message);
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 4,
    backgroundColor: good ? lightGrey : red,
    textColor: primary,
    fontSize: 16,
  );
}*/

/*showMessage(String message, bool? good) {
  print('SB: $message');
  Get.snackbar(
    'تنبيه',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: light_accent,
    dismissDirection: DismissDirection.horizontal,
  );
}*/

/*void showSnackBar(String message) {
  // Get.snackbar(
  //   'تنبيه',
  //   message,
  //   snackPosition: SnackPosition.BOTTOM,
  //   backgroundColor: light_accent,
  //   dismissDirection: DismissDirection.horizontal,
  //   duration:   Duration(seconds: 3),
  //   margin: EdgeInsets.all(8),
  //   borderRadius: 8,
  //   isDismissible: true,
  //   forwardAnimationCurve: Curves.easeOutBack,
  // );
  Get.showSnackbar(GetSnackBar(
    title: 'تنبيه',
    message: message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: light_accent,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    borderRadius: 8,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  ));
}*/

/*
Future<bool> showDelayedMessage(String message, bool? good) {
  print('SB: $message');
  Get.snackbar(
    'تنبيه',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: light_accent,
  );
  return Future.value(true);
}
*/
