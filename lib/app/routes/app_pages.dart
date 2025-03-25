import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/splashscreen/binding/splash_binding.dart';
import 'package:mobileapphigertech/app/modules/screens/splashscreen/view/splash_view.dart';
import 'package:mobileapphigertech/app/modules/screens/login/binding/login_binding.dart';
import 'package:mobileapphigertech/app/modules/screens/login/view/login_view.dart';
import 'package:mobileapphigertech/app/modules/home/binding/home_binding.dart';
import 'package:mobileapphigertech/app/modules/home/view/home_view.dart';
import 'package:mobileapphigertech/app/modules/station/binding/station_binding.dart';
import 'package:mobileapphigertech/app/modules/station/view/station_view.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class AppPage {
  static final pages = [
    // Splash Screen
    // GetPage(
    //   name: AppRoute.splash,
    //   page: () => SplashView(),
    //   binding: SplashBinding(),
    //   transition: Transition.fadeIn,
    // ),

    // Login Screen
    GetPage(
      name: AppRoute.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),

    // Home Screen
    GetPage(
      name: AppRoute.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),

    // Station List
    GetPage(
      name: AppRoute.stations,
      page: () => StationView(),
      binding: StationBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
