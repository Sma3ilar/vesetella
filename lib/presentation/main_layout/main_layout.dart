import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/main_app_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEECD),
      appBar: const MainAppBar(),
      // This is the magic widget! It renders the child pages defined in your routes.
      body: GetRouterOutlet(
        // Use the uri property and convert it to a string.
        initialRoute: Get.rootDelegate.currentConfiguration!.uri.toString(),
      ),
    );
  }
}
