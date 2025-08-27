// import 'dart:ui';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:pg_web/core/helpers/local_storage.dart';
// import '../services/translation_service.dart';
// import '../../presentation/settings/settings_state.dart';

// /*

// // To use translations
// Text('welcome_message'.tr);

// // To check current language
// final currentLang = Get.find<StorageService>().currentLanguage;

// // To change language
// Get.find<LanguageController>().changeLanguage('ar');

// */

// class LanguageController extends GetxController {
//   final TranslationService translationService;
//   final storage = LocalStorage.instance;

//   LanguageController({required this.translationService});

//   SettingsState state = const SettingsState.success();
//   String get currentLanguage => storage.currentLanguage;

//   Future<void> changeLanguage(BuildContext context, String languageCode) async {
//     // await storage.setLanguage(languageCode);

//     // Update EasyLocalization locale
//     await context.setLocale(Locale(languageCode));

//     // Update GetX locale
//     Get.updateLocale(Locale(languageCode));

//     Get.forceAppUpdate();
//   }
// }
