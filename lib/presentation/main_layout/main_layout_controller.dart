import 'package:get/get.dart';
import '../../core/routes/app_router.dart'; // Your routes file

import 'package:get/get.dart';
import '../../core/routes/app_router.dart';

class MainLayoutController extends GetxController {
  final RxInt activeTabIndex = 2.obs; // Default to "Start designing"

  // **FIXED**: This list now constructs the full, correct paths for navigation.
  final List<String> tabRoutes = [
    '${AppRoutes.mainLayout}/${AppRoutes.myAccount}', // -> /main-layout/my-account
    '${AppRoutes.mainLayout}/${AppRoutes.myDesigns}', // -> /main-layout/my-designs
    '${AppRoutes.mainLayout}/${AppRoutes.startDesigning}', // -> /main-layout/start-designing
    '${AppRoutes.mainLayout}/${AppRoutes.myFabrics}', // -> /main-layout/my-fabrics
  ];

  @override
  void onInit() {
    super.onInit();
    // This listener correctly finds the active tab based on the full route.
    Get.rootDelegate.addListener(() {
      final currentRoute =
          Get.rootDelegate.currentConfiguration?.uri.toString() ?? '';

      final index = tabRoutes.indexWhere((route) => currentRoute == route);

      if (index != -1) {
        activeTabIndex.value = index;
      }
    });
  }

  /// Changes the tab and navigates to the corresponding nested route.
  void changeTab(int index) {
    if (activeTabIndex.value != index) {
      activeTabIndex.value = index;
      // Navigates to the full path, e.g., '/main-layout/my-account'
      Get.rootDelegate.toNamed(tabRoutes[index]);
    }
  }

  /// Logs the user out and navigates to the login screen.
  void logout() {
    // Add your token clearing logic here
    Get.offAllNamed(AppRoutes.login);
  }
}
