
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController>{

  // List<bool> isSelected = List.generate(45, (index) => false);
  // List<int> selectedNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 45,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selected(index);
                },
                child: Obx(()=>
                    Container(
                      decoration: BoxDecoration(
                        color: controller.isSelected[index] ? Colors.black : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
          ,
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Obx(() =>
            Text(
          'Last Selected Numbers: ${controller.selectList.isEmpty ? "None" : controller.selectList.join(', ')}',
          style: TextStyle(fontSize: 16),
        ),)

      ],
    );
  }

}