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
      // The GetRouterOutlet renders the child pages defined in your routes.
      body: GetRouterOutlet(
        // Fixed: Use a direct route string instead of the current URI
        initialRoute: AppRoutes.startDesigning,
      ),
    );
  }
}
