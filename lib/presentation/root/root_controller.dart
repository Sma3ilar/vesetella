import 'package:get/get.dart';
import '../../core/routes/app_router.dart';
import '../../core/helpers/local_storage.dart';

class RootController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Add a small delay to simulate loading processes like checking storage.
      await Future.delayed(const Duration(seconds: 1));

      // Check if user is authenticated using LocalStorage
      final bool isAuthenticated = LocalStorage.instance.getIsAuth();
      final String token = LocalStorage.instance.getToken();

      if (isAuthenticated && token.isNotEmpty) {
        // User is authenticated, navigate to MainLayout
        Get.offAllNamed(AppRoutes.mainLayout);
      } else {
        // User is not authenticated, navigate to Welcome screen
        Get.offAllNamed(AppRoutes.welcome);
      }
    } catch (e) {
      print('Error in _initializeApp: $e');
      // Fallback navigation in case of error
      Get.offAllNamed(AppRoutes.welcome);
    }
  }
}
