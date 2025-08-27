import 'package:get/get.dart';
import 'package:pg_web/presentation/welcome/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily put the WelcomeController, it will be created when first used.
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
