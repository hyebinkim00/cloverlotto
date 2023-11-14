import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/random_controller.dart';

class RandomPage extends GetView<RandomController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('번호 뽑기'),
      ),

    );
  }

}