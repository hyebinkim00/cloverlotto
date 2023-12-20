import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyPage extends GetView<MyPageController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() =>
          ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
               child: Column(children: [
                 Text(('${controller.list[index].serial}')), // 회차
                 Text('고른 번호 + 당첨번호 비교 한 값'),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: List.generate(controller.ballList.length, (indexs) {
                     return Expanded(
                       child: Container(
                         width: 50.0,
                         height: 50.0,
                         margin: EdgeInsets.only(left: 5,right: 5),
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: controller.ballList[indexs].color,
                         ),
                         child: Center(
                             child:
                             Text(
                               '${controller.ballList[indexs].number}',
                               style: TextStyle(
                                 color: Colors.white, // 텍스트 색상 설정
                                 fontSize: 24.0, // 텍스트 크기 설정
                               ),)),
                       ),
                     );
                   }),
                 )
               ]),
            );
          })
      ),
    ));
  }
}
