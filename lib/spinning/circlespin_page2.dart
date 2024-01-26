import 'package:cloverlotto/spinning/circlespin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CircleSpinPage2 extends GetView<CircleSpinController>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Center(
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  if (!controller.isRotating.value) {
                    controller.rotationAngle.value +=
                        details.primaryDelta! / 100;
                  }
                },
                child: Transform.rotate(
                  angle: controller.rotationAngle.value,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        '돌림판',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // controller.startRotation();
                    },
                    child: Text('시작'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // controller.stopRotation();
                    },
                    child: Text('멈춤'),
                  ),
                ],
              ),
            ],
          )),
        ),
    );
  }

}