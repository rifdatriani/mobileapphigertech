import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/routes/app_pages.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823), // ukuran umun desain referensi Android 
      minTextAdapt: true, // auto scale text
      splitScreenMode: true, // support mode multi-window
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Aplikasi Mobile Higertech',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          initialRoute: AppRoute.home,
          getPages: AppPage.pages,
        );
      },
    );
  }
}
