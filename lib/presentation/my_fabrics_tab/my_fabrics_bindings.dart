import 'package:get/get.dart';
import 'package:pg_web/repositories/design_repository.dart';
import '../../../core/helpers/dio_api_manager.dart';
import '../../../core/helpers/token_interceptor.dart';
import 'my_fabrics_controller.dart';

class MyFabricsBinding extends Bindings {
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
    Get.lazyPut<DesignRepository>(
      () => DesignRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    // Register the controller with the repository
    Get.lazyPut<MyFabricsController>(
      () => MyFabricsController(designRepository: Get.find<DesignRepository>()),
    );
  }
}
