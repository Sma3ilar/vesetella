import 'package:get/get.dart';
import '../../core/routes/app_router.dart'; // Your routes file

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

      // --- USER AUTHENTICATION LOGIC ---

      // In a real app, you would read this from device storage.
      // e.g., using GetStorage: final userToken = GetStorage().read('user_token');
      // We set it to `null` here to simulate a logged-out user.
      final String? userToken = null;

      if (userToken == null) {
        // Navigate to the Welcome Screen.
        Get.offAllNamed(AppRoutes.welcome);
      } else {
        // Handle the case when user is logged in
        // For now, still navigate to welcome screen
        Get.offAllNamed(AppRoutes.welcome);
      }
    } catch (e) {
      print('Error in _initializeApp: $e');
      // Fallback navigation in case of error
      Get.offAllNamed(AppRoutes.welcome);
    }
  }
}
