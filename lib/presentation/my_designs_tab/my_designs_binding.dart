import 'package:get/get.dart';

import '../../../repositories/design_repository.dart';
import '../../../core/helpers/dio_api_manager.dart';
import '../../../core/helpers/token_interceptor.dart';
import 'my_desings_controller.dart';

class MyDesignsBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure the dependencies are available
    if (!Get.isRegistered<DioApiManager>()) {
      Get.lazyPut<DioApiManager>(() => DioApiManager(), fenix: true);
    }
    
    if (!Get.isRegistered<TokenService>()) {
      Get.lazyPut<TokenService>(() => TokenService(), fenix: true);
    }
    
    // Register the repository with its dependencies
    Get.lazyPut<DesignRepository>(() => DesignRepository(
          apiManager: Get.find<DioApiManager>(),
          tokenService: Get.find<TokenService>(),
        ), fenix: true);
    
    // Register the controller with the repository
    Get.lazyPut<MyDesignsController>(() => MyDesignsController(
          designRepository: Get.find<DesignRepository>(),
        ));
  }
}
