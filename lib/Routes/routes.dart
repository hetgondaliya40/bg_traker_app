import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../view/screen/home.dart';
import '../view/screen/splash.dart';

class Routes {
  static String splash = '/';
  static String home = '/home';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const splashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: home,
      page: () => const homePage(),
      transition: Transition.cupertino,
    ),
  ];
}
