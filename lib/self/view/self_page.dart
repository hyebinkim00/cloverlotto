
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width, // 전체 화면을 채우도록 설정
              height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Text('번호를 입력하세요!'),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      //  SliverGridDelegateWithFixedCrossAxisCount
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                          crossAxisSpacing: 10, // 가로 간격을 조절하세요.
                          mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                           crossAxisCount: 7),
                      itemCount: 45,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap:(){controller.selected(index);},
                          child: Obx(() => Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              color: controller.isSelected[index]
                                ? Colors.black45
                                : Colors.white),
                            child: Center(
                              child: Text('${index+1}'),
                            ),
                          ),
                              )
                            ,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

    Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: 45,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selected(index);
                },
                child: Obx(() => Container(
                      decoration: BoxDecoration(
                        color: controller.isSelected[index]
                            ? Colors.white
                            : Colors.black,
                        // borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          101.toString(),
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Obx(
          () => Text(
            'Last Selected Numbers: ${controller.selectList.isEmpty ? "None" : controller.selectList.join(', ')}',
            style: TextStyle(fontSize: 16, color: Colors.pink),
          ),
        )
      ],
    );
  }
}
