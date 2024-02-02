import 'dart:async';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

class CircleSpinController extends GetxController{

  RxDouble rotationAngle = 0.0.obs;
  RxBool isRotating = false.obs;
  RxInt selectedNumber = 1.obs;
  late Rx<Stream<int>> rxStream ;
  RxString randomVl = '?'.obs;
  RxString randomV2 = '?'.obs;
  late int value;

  final GlobalKey<RandomTextRevealState> globalKey = GlobalKey();



  List<int> nu = List.generate(10, (index) => index+1);
  List<FortuneItem> items = const [
    FortuneItem(child: Text("1")),
    FortuneItem(child: Text("2")),
    FortuneItem(child: Text("3")),
    FortuneItem(child: Text("4")),
  ];

  //60 + pi/180
  List<FortuneItem> itemss =  List.generate(5, (index) {
    return FortuneItem(style:FortuneItemStyle( color:Colors.brown ,textAlign: TextAlign.right,borderWidth: 0) ,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Align( alignment:Alignment.centerRight,child: Transform.rotate(angle: pi / 2, child: Text(style: TextStyle(fontSize: 20),(index).toString()),),),
        )
   );
  });
// Text((index + 1).toString())

  late final StreamController<int> streamController;
  @override
  void onInit() {
    super.onInit();

    streamController = StreamController<int>();
    // streamController = StreamController.broadcast();
    // rxStream.value = streamController.stream;
    rxStream = streamController.stream.obs;// Stream<int>를 Rx<Stream<int>>로 변환

    // streamController.stream.listen((event) {
    //   print('VVVV${event}');
    // });

  }


  void startBtn() {
    value = Fortune.randomInt(0, 5);
    streamController.add(value);
    print('{HBHB_startBtn${value}');

  }

  void WheelStop(){
    print('HBHB_WheelStop${nu[value]}');

  }


}