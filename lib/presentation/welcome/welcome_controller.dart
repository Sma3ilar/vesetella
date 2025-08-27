import 'package:get/get.dart';
import 'package:pg_web/core/routes/app_router.dart';

class WelcomeController extends GetxController {
  // This method will be called when the user clicks the "GET STARTED" button.
  // It navigates to the next screen in your app.
  void navigateToNextPage() {
    // Replace AppRoutes.HOME with the actual route you want to navigate to.
    Get.toNamed(AppRoutes.signup);
  }
}
