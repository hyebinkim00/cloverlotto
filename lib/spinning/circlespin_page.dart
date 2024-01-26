import 'dart:async';
import 'dart:math';

import 'package:cloverlotto/spinning/circlespin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';


class CircleSpinPage extends GetView<CircleSpinController>{
  //
  // StreamController<int> streamController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>
            Column(
              children: [
                Expanded(
                  child: FortuneWheel(
                    selected: controller.rxStream.value,
                    animateFirst: false,
                    duration: const Duration(seconds: 3),
                    items: controller.itemss,
                    onAnimationEnd: (){
                      controller.WheelStop();
                    },
                  ),
                ),
                TextButton(onPressed: (){
                  controller.startBtn();
                  // streamController.add(Fortune.randomInt(0, items.length));
                }, child: Text('Start${controller.rxStream.value}')),

                // StreamBuilder<int>(
                //   stream: controller.streamController.stream,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       // Stream에서 데이터를 수신하는 리스너를 등록
                //       return Text('Selected value: ${snapshot.data}');
                //     } else {
                //       return CircularProgressIndicator();
                //     }
                //   },
                // ),
                // StreamBuilder(
                //   stream: streamController.stream,
                //   builder: (context, snapshot) => snapshot.hasData
                //       ? _text(snapshot)
                //       : Container(),
                // )
              ],
            ),)
    );
  }

}