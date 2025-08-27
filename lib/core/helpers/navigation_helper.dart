import 'package:get/get.dart';

import '../routes/app_router.dart';

void goToScreenAboveBase({required String targetRoute, dynamic arguments}) {
  Get.offAllNamed(AppRoutes.root);
  Future.delayed(Duration.zero, () {
    Get.toNamed(targetRoute, arguments: arguments);
  });
}
