import 'package:get/get.dart';
import 'package:pg_web/repositories/design_repository.dart';
import 'package:pg_web/core/helpers/dio_api_manager.dart';
import 'package:pg_web/core/helpers/token_interceptor.dart';
import 'design_controller.dart';

class DesignBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure DioApiManager and TokenService are available
    Get.lazyPut<DioApiManager>(() => DioApiManager(), fenix: true);
    Get.lazyPut<TokenService>(() => TokenService(), fenix: true);
    
    // Initialize DesignRepository with required dependencies
    Get.lazyPut<DesignRepository>(
      () => DesignRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    // Initialize DesignController with the repository
    Get.lazyPut<DesignController>(
      () => DesignController(designRepository: Get.find()),
      fenix: true,
    );
  }
}
