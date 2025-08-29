import 'package:get/get.dart';
import 'package:pg_web/presentation/main_layout/main_layout_controller.dart';
import 'package:pg_web/repositories/design_repository.dart';
import 'package:pg_web/repositories/fabric_repository.dart';
import '../../repositories/auth_repository.dart';
import '../services/translation_service.dart';
import 'dio_api_manager.dart';
import 'local_storage.dart';
import 'logout_helper.dart';
import 'token_interceptor.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // ######################## Services ######################## //

    Get.lazyPut<TokenService>(() => TokenService(), fenix: true);
    Get.lazyPut<DioApiManager>(() => DioApiManager(), fenix: true);
    // Get.lazyPut<TranslationService>(() => TranslationService(), fenix: true);

    // ######################## Repositories ######################## //

    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<DesignRepository>(
      () => DesignRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<FabricRepository>(
      () => FabricRepository(
        apiManager: Get.find<DioApiManager>(),
        tokenService: Get.find<TokenService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LogoutHelper>(
      () => LogoutHelper(localStorage: LocalStorage.instance),
    );
    // Uncomment and adapt other controllers if needed
    Get.lazyPut<MainLayoutController>(() => MainLayoutController(), fenix: true);
    // Get.put(TripTimerController(), permanent: true);
  }

  // ServicesRepository servicesRepository = Get.find<ServicesRepository>();
}

// Example usage outside the class (if needed)
// TokenService tokenService = Get.find<TokenService>();
// ServicesRepository servicesRepository = Get.find<ServicesRepository>();
