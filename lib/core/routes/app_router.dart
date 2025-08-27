import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pg_web/presentation/root/root_binding.dart';
import 'package:pg_web/presentation/root/root_screen.dart';
import 'package:pg_web/presentation/welcome/welcome_binding.dart';
import 'package:pg_web/presentation/welcome/welcome_page.dart';
import 'package:pg_web/presentation/signup/signup_binding.dart';
import 'package:pg_web/presentation/signup/signup_page.dart';
import 'package:pg_web/presentation/login/login_binding.dart';
import 'package:pg_web/presentation/login/login_page.dart';

class AppRoutes {
  static const String root = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static final List<GetPage> getPages = [
    GetPage(
      name: '/', // This is now your main entry point
      page: () => const RootScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome, // Define this constant in your AppRoutes file
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.native,
    ),
  ];
}

/*
// Define route with parameter
GetPage(
name: '${Routes.login}/:id', // Dynamic route
page: () => const LoginScreen(),
),

// Navigate with parameter
Get.toNamed('${Routes.login}/123');

// Access parameter in LoginScreen
String? id = Get.parameters['id']; // '123'
*/
