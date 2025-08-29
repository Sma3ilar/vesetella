import 'package:get/get.dart';
import 'package:pg_web/repositories/design_repository.dart';
import 'design_controller.dart';

class DesignBinding extends Bindings {
  @override
  void dependencies() {
    // The DesignRepository is already registered globally by AppBindings.
    // We only need to register the controller for this specific screen.
    // Get.find() will locate the globally available DesignRepository instance.
    Get.lazyPut<DesignController>(
      () => DesignController(designRepository: Get.find<DesignRepository>()),
      fenix: true,
    );
  }
}
