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

  // Parent route is absolute
  static const String mainLayout = '/main-layout';

  static const String myAccount = '/main-layout/my-account';
  static const String myDesigns = '/main-layout/my-designs';
  static const String startDesigning = '/main-layout/start-designing';
  static const String myFabrics = '/main-layout/my-fabrics';

  static final List<GetPage> getPages = [
    GetPage(name: root, page: () => const RootScreen(), binding: RootBinding()),
    GetPage(
      name: welcome,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.native,
    ),
    // This is the parent route for our nested layout
    GetPage(
      name: mainLayout,
      page: () => const MainLayout(),
      binding: MainLayoutBinding(),
      // The default page to show in the GetRouterOutlet
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          name: myAccount, // Now uses the relative 'my-account'
          page: () => const MyAccountScreen(),
          binding: MyAccountBinding(),
        ),
        GetPage(
          name: startDesigning, // Uses 'start-designing'
          page: () => const DesignScreen(),
          binding: DesignBinding(),
        ),
        GetPage(
          name: myDesigns, // Uses 'my-designs'
          page: () => const MyDesignsScreen(),
          binding: MyDesignsBinding(),
        ),
        GetPage(
          name: myFabrics, // Uses 'my-fabrics'
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
