import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:cloverlotto/model/loto.dart';
import 'package:cloverlotto/random/controller/random_controller.dart';
import 'package:cloverlotto/retrofit/retrofit_client.dart';
import 'package:cloverlotto/sqllite/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:cp949_codec/cp949_codec.dart';

import '../../model/qrpage.dart';

class BottomNaviController extends GetxController {
  RxInt currentIndex = 3.obs;
  late PageController pageController;

  PageController get(){
   pageController =  PageController(initialPage: 0);
   return pageController;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }


}
