import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pg_web/presentation/root/root_controller.dart';
import 'package:pg_web/presentation/widgets/loading_indicator.dart'; // From your snippet

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Explicitly initialize the controller
    Get.find<RootController>();

    // You can also add your background image here for a seamless transition
    return const Scaffold(body: Center(child: LoadingIndicatorWidget()));
  }
}
