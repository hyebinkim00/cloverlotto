import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/random_controller.dart';

class RandomPage extends GetView<RandomController>{

  String list(){
    List<int> nums = [];
    // 1부터 45개의 6개의 수
    for( int i = 0; i < 6; i ++) {
      nums.add(Random().nextInt(45) + 1);
    }
    return nums.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('번호 뽑기 : '+ list()),
      ),
    );
  }



}