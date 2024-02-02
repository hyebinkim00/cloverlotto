import 'dart:math';

import 'package:cloverlotto/config/util_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/random_controller.dart';

class RandomPage extends StatelessWidget {
  // 번호추첨 -> 제외 하고 싶은 숫자 , 포함하고 싶은 숫자  , ---> 여섯개 숫자 랜덤 리스트 10개 == > 생성된 번호 저장 가능
  TextEditingController _controller = TextEditingController();

  List<int> ss = [4,9];
  bool press = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RandomController>(
        init: RandomController(),
        builder: (controller) {
          return Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                    child: TextButton(
                        onPressed: () {
                          // _showNumberInputDialog(context);
                          UtilDialog.getDi(context);
                          // UtilDialog.selectNumbers(context, false,controller.sel.value,(select){
                          //   print('selelel+_${select}');
                          //   controller.onSele(select);
                          // } );
                        },
                        child: Text('제거할 숫자')),

                  ),
                Obx(() => Text('SSS__${controller.s.value}'),),
                Obx(() => Text('SSS__${controller.sel.value}')),
                // Obx(
                //   () => ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: controller.allRandomNumbers.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Center(
                //         child: Text('${controller.allRandomNumbers[index]}'),
                //       );
                //     },
                //   ),
                // ),
                TextButton(
                    onPressed: () {
                      press = !press;
                      controller.create_list();
                      controller.onTap();
                    },
                    child: Text('번호 생성하기'))
                ,
                // Obx(() => AnimatedSwitcher(
                //     duration: Duration(milliseconds: 1000),
                //   child: createBox(controller.isSwitched.value),
                //   transitionBuilder : (Widget child, Animation<double> animation) {
                //     return FadeTransition(
                //       opacity: animation,
                //       child: child,
                //     );
                //   },
                // )),
                Obx(() => TweenAnimationBuilder(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.easeInOut, // 추가된 부분
                  tween: Tween<double>(begin: 0, end: controller.angle.value),
                  onEnd: (){controller.onTap3();} ,
                  builder: (BuildContext con, double val, child) {
                    return Transform(
                        alignment: Alignment.center,
                      // alignment: FractionalOffset.center,
                      transform:Matrix4.identity()
                        ..setEntry(3, 2, 0.002) // 원근 효과
                        ..rotateY(val * (3.14 / 180)),
                      child: Container(width: 100, height: 100,
                        decoration:BoxDecoration(
                          color: controller.isBack.value ? Colors.black: Colors.yellowAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)
                          ),
                        ),
                        child: (Center(child:Text(controller.isBack.value?'Front':'Back'))),
                      ),
                    );
                  },
                )),
                // 이걸 써야겟다 ( 눌렀을때 번호 공개)
                Obx(() => GestureDetector(
                  onTap: (){controller.onTap2();},
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    transform: Matrix4.rotationY(controller.angle.value * (3.1415927 / 180)),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: controller.backgroundColor.value,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        controller.isBack.value ? '' : 'Front',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),),
                ))

              ],
            ),

          );
        }
      ),
    );
  }

  ///https://iosroid.tistory.com/8


  Widget wrapAnimatedBuilder(Widget widget, Animation<double> animation){
    final rotate = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotate,
      child: widget,
      builder: (_, widget){
        return Transform(
          transform: Matrix4.rotationY(rotate.value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }


}
