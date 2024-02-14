import 'package:cloverlotto/bottomMain/binding/bottomnavi_binding.dart';
import 'package:cloverlotto/bottomMain/view/bottomnavi_page.dart';
import 'package:cloverlotto/bottomMain/view/bottomnavi_stful.dart';
import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/binding/main_binding.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:cloverlotto/mynum/binding/mynum_binding.dart';
import 'package:cloverlotto/mynum/view/mynum_page.dart';
import 'package:cloverlotto/mypage/binding/mypage_binding.dart';
import 'package:cloverlotto/mypage/view/mypage_page.dart';
import 'package:cloverlotto/random/binding/random_binding.dart';
import 'package:cloverlotto/random/view/random_page.dart';
import 'package:cloverlotto/random2/binding/random2_binding.dart';
import 'package:cloverlotto/random2/view/random2_page.dart';
import 'package:cloverlotto/scan/binding/scan_binding.dart';
import 'package:cloverlotto/scan/view/scan_page.dart';
import 'package:cloverlotto/self/binding/self_binding.dart';
import 'package:cloverlotto/self/view/self_page.dart';
import 'package:cloverlotto/spinning/circlespin_binding.dart';
import 'package:cloverlotto/spinning/circlespin_page.dart';
import 'package:get/get.dart';

import '../main/view/main_stspage.dart';

class Constants {
  static final List<GetPage> APP_PAGES = [
    GetPage(
      name: RouteNames.BOTTOM,
      page: () => BottomNaviPage(),
      binding: BottomNaviBinding(),
    ),
    GetPage(
      name: RouteNames.MAIN,
      page: () => MainPage2(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.RANDOM,
      page: () => RandomPage(),
      binding: RandomBinding(),
    ),
    GetPage(
      name: RouteNames.SELF,
      page: () => SelfPage(),
      binding: SelfBinding(),
    ),
    GetPage(
      name: RouteNames.SCAN,
      page: () => ScanPage(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: RouteNames.MYPAGE,
      page: () => MyNumPage(),
      binding: MyNumBinding(),
    ),
    GetPage(
      name: RouteNames.RANDOM2,
      page: () => Random2Page(),
      binding: Random2Binding(),
    ),
    GetPage(
      name: RouteNames.SPINNING,
      page: () => CircleSpinPage(),
      binding: CircleSpinBinding(),
    )
  ];
}