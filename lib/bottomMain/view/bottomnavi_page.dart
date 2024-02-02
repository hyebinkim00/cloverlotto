import 'package:cloverlotto/bottomMain/controller/bottom_controller.dart';
import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:cloverlotto/main/view/main_page.dart';
import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mypage/view/mypage_page.dart';
import 'package:cloverlotto/random/view/random_page.dart';
import 'package:cloverlotto/scan/view/scan_page.dart';
import 'package:cloverlotto/self/controller/self_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../config/route_names.dart';
import '../../main/view/main_stspage.dart';
import '../../self/view/self_page.dart';


class BottomNaviPage extends GetView<BottomNaviController>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
        controller: controller.get(),
        onPageChanged: (index) {
          controller.changePage(index);
        },
        children: [
          MainPage2(),
          RandomPage(),
          MainPage2(),
          MainPage2()
        ],
      ),
      // body: Obx(
      //       () {
      //     return IndexedStack(
      //       index: controller.currentIndex.value,
      //       children: [
      //         MainPage(),
      //         RandomPage(),
      //         SelfPage(),
      //         ScanPage(),
      //       ],
      //     );
      //   },
      // ),

        //https://pub.dev/packages/circular_bottom_navigation
      bottomNavigationBar:
        Obx(()=>
            BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap:(index) {
            controller.changePage(index);
          },
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'Random',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 32, // 아이콘 크기 조절
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // 원의 배경색
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white, // 아이콘 색상
                  ),
                ),
              ),
              label: 'Self',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Scan',
            ),
          ],
        ),)
    );
  }
}