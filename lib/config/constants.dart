import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/binding/main_binding.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:get/get.dart';

class Constants{
  static final List<GetPage> APP_PAGES = [
    GetPage(
        name: RouteNames.MAIN,
        page: ()=> MainPage(),
        binding: MainBinding(),
    )

  ];
}