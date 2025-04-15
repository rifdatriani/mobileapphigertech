import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/settings/repository/settings_repository.dart';
import 'package:mobileapphigertech/app/routes/app_pages.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';
import 'package:mobileapphigertech/app/modules/settings/controller/settings_controller.dart';

void main() {
  // Registrasi Repository dulu
  Get.put(SettingsRepository());
  // Baru inject controller dengan repository sebagai parameter
  Get.put(SettingsController(Get.find<SettingsRepository>()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final settingsController = Get.find<SettingsController>();

        return Obx(() => GetMaterialApp(
              title: 'Aplikasi Mobile Higertech',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.isDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,
              initialRoute: AppRoute.home,
              getPages: AppPage.pages,
            ));
      },
    );
  }
}
