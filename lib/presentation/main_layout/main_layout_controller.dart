import 'package:get/get.dart';
import '../../core/routes/app_router.dart'; // Your routes file

class MainLayoutController extends GetxController {
  // An observable to track the currently active tab index.
  final RxInt activeTabIndex = 2.obs; // Default to "Start designing"

  // A list of the routes for your tabs. The order MUST match the tabs in your UI.
  final List<String> tabRoutes = [
    AppRoutes.myAccount,
    AppRoutes.myDesigns,
    AppRoutes.startDesigning,
    AppRoutes.myFabrics,
  ];

  @override
  void onInit() {
    super.onInit();
    // This is the corrected way to listen for route changes.
    // We add a listener directly to the GetX router delegate.
    Get.rootDelegate.addListener(() {
      // Get the current route from the delegate's configuration.
      final currentRoute =
          Get.rootDelegate.currentConfiguration?.uri.path ?? '';

      // Find the index of the current route in our list of tab routes.
      final index = tabRoutes.indexWhere(
        (route) => currentRoute.startsWith(route),
      );

      // If a match is found, update the active tab index.
      if (index != -1) {
        activeTabIndex.value = index;
      }
    });
  }

  /// Changes the tab and navigates to the corresponding nested route.
  void changeTab(int index) {
    // Prevent navigating to the same page again
    if (activeTabIndex.value != index) {
      activeTabIndex.value = index;
      Get.toNamed(tabRoutes[index]);
    }
  }

  /// Logs the user out and navigates to the login screen.
  void logout() {
    // Add your token clearing logic here
    Get.offAllNamed(AppRoutes.login);
  }
}
