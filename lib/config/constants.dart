import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/binding/main_binding.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:cloverlotto/random/binding/random_binding.dart';
import 'package:cloverlotto/random/view/random_page.dart';
import 'package:cloverlotto/self/binding/self_binding.dart';
import 'package:cloverlotto/self/view/self_page.dart';
import 'package:get/get.dart';

class Constants{
  static final List<GetPage> APP_PAGES = [
    GetPage(
        name: RouteNames.MAIN,
        page: ()=> MainPage(),
        binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.RANDOM,
      page: ()=> RandomPage(),
      binding: RandomBinding(),
    ),
    GetPage(
    name: RouteNames.SELF,
    page: ()=>SelfPage(),
    binding: SelfBinding())
  ];
}