import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloverlotto/config/constants.dart';
import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414,896),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
    return GetMaterialApp( // ios : 쿠퍼치노
      title: 'Flutter Demo',
      // home: AnimatedSplashScreen(
      //   duration: 3000,
      //   splash: Icons.home,
      //   nextScreen: MainPage(),
      //     splashTransition: SplashTransition.fadeTransition,
      //     backgroundColor: Colors.blue
      //
      // ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.MAIN,
      getPages: Constants.APP_PAGES,
    );
        },
    );
  }
}
