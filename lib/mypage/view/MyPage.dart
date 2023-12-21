import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyPage extends GetView<MyPageController> {
  List<numInfo>? numBox = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Obx(
                  () =>
                  ListView.builder(
                      itemCount: controller.dblist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Column(children: [
                            Text(('${controller.dblist[index].serial}')), // 회차
                            FutureBuilder(
                              future: controller.getResults(controller.dblist[index]),
                              builder: (context, snapshot) {
                                if(snapshot.data !=null && snapshot.hasData){
                                  numBox = snapshot.data;
                                }
                                return Container(
                                  color: Colors.grey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: List.generate(numBox!.length, (indexs) {
                                      return Expanded(
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          margin: EdgeInsets.only(left: 5, right: 5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: numBox![indexs].color,
                                          ),
                                          child: Center(
                                              child:
                                              Text('${ numBox![indexs].number}',
                                                style: TextStyle(
                                                  color: Colors.black, // 텍스트 색상 설정
                                                  fontSize: 24.0, // 텍스트 크기 설정
                                                ),)),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              }
                            )
                          ]),
                        );
                      })
          ),
        ));
  }
}
