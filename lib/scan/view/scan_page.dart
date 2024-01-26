import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/scan_controller.dart';

class ScanPage extends GetView<ScanController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child: Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                if(await controller.getLastNo()){
                 showAlert(controller.winNumList);
                }
              },
              child: Text('Alert!!!')),
          Obx(() => Text(
                '${controller.alertMessage.value}',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ))
        ],
      ),
    ));
  }
}


// ScanPage


void showAlert(List<Map<String, dynamic>> lists) {
  Get.dialog(AlertDialog(
    title: Text('로또 결과'),
    content: Container(
      child: Column(
        children: [
          Text('data'),
          // 당첨 번호
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(lists.length, (index) {
              return Expanded(
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lists[index]['color'],
                  ),
                  child: Center(
                      child:
                      Text(
                        lists[index]['num'],
                        style: TextStyle(
                          color: Colors.white, // 텍스트 색상 설정
                          fontSize: 24.0, // 텍스트 크기 설정
                        ),)),
                ),
              );
            }),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Container(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text("네"),
        ),
      ),
      Container(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text("아니요"),
        ),
      ),
    ],
  ));
}
