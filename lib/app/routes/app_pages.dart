import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/binding/logout_binding.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/view/logout_view.dart';
import 'package:mobileapphigertech/app/modules/screens/splashscreen/binding/splash_binding.dart';
import 'package:mobileapphigertech/app/modules/screens/splashscreen/view/splash_view.dart';
import 'package:mobileapphigertech/app/modules/screens/login/binding/login_binding.dart';
import 'package:mobileapphigertech/app/modules/screens/login/view/login_view.dart';
import 'package:mobileapphigertech/app/modules/home/binding/home_binding.dart';
import 'package:mobileapphigertech/app/modules/settings/binding/settings_binding.dart';
import 'package:mobileapphigertech/app/modules/settings/view/settings_view.dart';
// import 'package:mobileapphigertech/app/modules/home/view/home_view.dart';
import 'package:mobileapphigertech/app/modules/station/binding/station_binding.dart';
import 'package:mobileapphigertech/app/modules/station/view/station_view.dart';
import 'package:mobileapphigertech/app/modules/navbar/view/main_navbar.dart';
// import 'package:mobileapphigertech/app/modules/map/binding/map_binding.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class AppPage {
  static final pages = [
    // Splash Screen
    GetPage(
      name: AppRoute.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),

    // Login Screen
    GetPage(
      name: AppRoute.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),

    // Home Screen (bisa digunakan secara langsung tapi sebaiknya lewat navbar)
    // GetPage(
    //   name: AppRoute.home,
    //   page: () => HomeView(),
    //   binding: HomeBinding(),
    //   transition: Transition.rightToLeft,
    // ),

     GetPage(
      name: AppRoute.home ,
      page: () => MainNavbar(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // Station List
    GetPage(
      name: AppRoute.stations,
      page: () => StationView(),
      binding: StationBinding(),
      transition: Transition.rightToLeft,
    ),

    // Map View
    // GetPage(
    //   name: AppRoute.map,
    //   page: () => MapView(),
    //   binding: MapBinding(),
    //   transition: Transition.rightToLeft,
    // ),

    // Logout View (sebagai pengaturan juga bisa)
    GetPage(
      name: AppRoute.logout,
      page: () => const LogoutView(),
      binding: LogoutBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: '/settings',
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    )

    // Main Navigation Bar
   
  ];
}
