import 'package:get/get.dart';
import 'package:pg_web/core/helpers/local_storage.dart';

class TranslationService extends GetxService {
  final storage = LocalStorage.instance;
  TranslationService();

  String get(String key) {
    return storage.translations[key] ?? key;
  }
}
