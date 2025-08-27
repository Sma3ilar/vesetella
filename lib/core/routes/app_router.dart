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

import '../../presentation/create_design_tab/design_binding.dart';
import '../../presentation/create_design_tab/design_screen.dart';
import '../../presentation/main_layout/main_layout.dart';
import '../../presentation/main_layout/main_layout_binding.dart';
import '../../presentation/my_account/my_account_binding.dart';
import '../../presentation/my_account/my_account_screen.dart';
import '../../presentation/my_designs_tab/my_designs_binding.dart';
import '../../presentation/my_designs_tab/my_designs_screen.dart';
import '../../presentation/my_fabrics_tab/my_fabrics_bindings.dart';
import '../../presentation/my_fabrics_tab/my_fabrics_screen.dart';

class AppRoutes {
  static const String root = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String mainLayout = '/main-layout';
  static const String myAccount = '/my-account';
  static const String myDesigns = '/my-designs';
  static const String startDesigning = '/start-designing';
  static const String myFabrics = '/my-fabrics';

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
    // Fix the route names in the children section
    GetPage(
      name: AppRoutes.mainLayout,
      page: () => const MainLayout(),
      binding: MainLayoutBinding(),
      children: [
        GetPage(
          name: AppRoutes.myAccount, // Use the constant directly
          page: () => const MyAccountScreen(),
          binding: MyAccountBinding(),
        ),
        GetPage(
          name: AppRoutes.startDesigning, // Use the constant directly
          page: () => const DesignScreen(),
          binding: DesignBinding(),
        ),
        GetPage(
          name: AppRoutes.myDesigns, // Use the constant directly
          page: () => const MyDesignsScreen(),
          binding: MyDesignsBinding(),
        ),
        GetPage(
          name: AppRoutes.myFabrics, // Add the MyFabrics route
          page: () => const MyFabricsScreen(),
          binding: MyFabricsBinding(),
        ),
      ],
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
