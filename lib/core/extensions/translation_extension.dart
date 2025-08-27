import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../services/translation_service.dart';

extension StringTranslation on String {
  String get trn {
    // Handle null safety
    if (Get.isRegistered<TranslationService>()) {
      // Get a fresh translation each time this is called
      return Get.find<TranslationService>().get(this);
    }
    return this;
  }
}
