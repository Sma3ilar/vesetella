import 'package:get/get.dart';
import 'package:pg_web/repositories/auth_repository.dart';
import 'package:pg_web/core/helpers/dio_api_manager.dart';
import 'package:pg_web/core/helpers/token_interceptor.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure DioApiManager and TokenService are available
    Get.lazyPut<DioApiManager>(() => DioApiManager(), fenix: true);
    Get.lazyPut<TokenService>(() => TokenService(), fenix: true);
    
    // Initialize AuthRepository with required dependencies
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LoginController>(
      () => LoginController(authRepository: Get.find()),
      fenix: true,
    );
  }
}
