// import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pg_web/core/theme/colors.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'core/helpers/dependency_manager.dart';
import 'core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    // Set URL strategy to path-based (no hash)
    setUrlStrategy(PathUrlStrategy());
  }
  final appBindings = AppBindings();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          // locale: context.locale,
          // supportedLocales: context.supportedLocales,
          // localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue500),
            useMaterial3: true,
          ),
          // Let EasyLocalization handle the text direction automatically
          // textDirection: context.locale.languageCode == 'ar'
          //     ? TextDirection.rtl
          //     : TextDirection.ltr,
          initialBinding: appBindings,
          title: 'Vestella',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.startDesigning,
          getPages: AppRoutes.getPages,
          defaultTransition: Transition.native,
        );
      },
    );
  }
}
