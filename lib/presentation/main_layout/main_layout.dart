import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/main_app_bar.dart';
import '../../core/routes/app_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEECD),
      appBar: const MainAppBar(),
      // This is the magic widget! It renders the child pages defined in your routes.
      body: GetRouterOutlet(
        // Provide a default route if currentConfiguration is null
        initialRoute: Get.rootDelegate.currentConfiguration?.uri.toString() ?? AppRoutes.startDesigning,
      ),
    );
  }
}
