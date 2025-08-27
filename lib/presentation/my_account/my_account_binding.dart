import 'package:get/get.dart';
import '../../core/helpers/dio_api_manager.dart';
import '../../core/helpers/token_interceptor.dart';
import '../../repositories/auth_repository.dart';
import 'my_account_controller.dart';

class MyAccountBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure DioApiManager and TokenService are available
    if (!Get.isRegistered<DioApiManager>()) {
      Get.lazyPut<DioApiManager>(() => DioApiManager());
    }
    
    if (!Get.isRegistered<TokenService>()) {
      Get.lazyPut<TokenService>(() => TokenService());
    }
    
    // Register AuthRepository with its dependencies
    Get.lazyPut<AuthRepository>(() => AuthRepository(
          apiManager: Get.find<DioApiManager>(),
          tokenService: Get.find<TokenService>(),
        ));
    
    // Register MyAccountController with AuthRepository dependency
    Get.lazyPut<MyAccountController>(() => MyAccountController(
          authRepository: Get.find<AuthRepository>(),
        ));
  }
}
