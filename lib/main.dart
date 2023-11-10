import 'package:cloverlotto/config/constants.dart';
import 'package:cloverlotto/config/route_names.dart';
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
