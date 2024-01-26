import 'dart:math';

import 'package:cloverlotto/config/util_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/random2_controller.dart';

class Random2Page extends GetView<Random2Controller> {
  // 번호추첨 -> 제외 하고 싶은 숫자 , 포함하고 싶은 숫자  , ---> 여섯개 숫자 랜덤 리스트 10개 == > 생성된 번호 저장 가능
  TextEditingController _controller = TextEditingController();
  bool press = true;
  List<int> ss = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    // _showNumberInputDialog(context);
                    UtilDialog.selectNumbers(context, false,ss,(select){
                      print('Dioalog ${select}');
                    } );
                  },
                  child: Text('제거할 숫자')),
            ),
            Obx(
              () => Row(
                children: [Text('${controller.inNum}')],
              ),
            ),
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

  Widget createBox(bool iswu) =>
      Container(
        key: ValueKey<bool>(iswu),
        color: iswu ? Colors.green : Colors.blue,
        width: iswu? 200 : 100,
        height: iswu ? 200 : 100,
        child: Center(
          child: Text(
            '${controller.isSwitched}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );



  Future<void> _showNumberInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter a Number'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^([1-9]|[1-3][0-9]|4[0-5])$')),
            ],
            decoration: InputDecoration(
              labelText: 'Number',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 닫기 버튼
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // 여기서 입력된 숫자를 사용하거나 저장할 수 있습니다.
                var enteredNumber = _controller.text;
                controller.inNum.value = enteredNumber;
                print('Entered Number: $enteredNumber');
                Navigator.of(context).pop(); // 닫기 버튼
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
