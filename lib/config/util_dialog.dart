import 'package:cloverlotto/random/controller/random_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../random2/controller/random2_controller.dart';

class UtilDialog {
  // 제거 할 숫자 , 포함할 숫자
  static void selectNumbers(BuildContext context, bool range, List<int> origin, Function(List<int>) nums) {
    RandomController randomController = Get.find<RandomController>();
    List<int> sle = origin;
    RxBool d = false.obs;
    Get.defaultDialog(
        title: range ? '포함 할 숫자를 선택하세요!' : '제외 할 숫자를 선택하세요!',
        content:
            // Obx(()=>
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 600,
              height: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 4, // 가로 간격을 조절하세요.
                  mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                ),
                itemBuilder: (context, index) {
                  int number = index + 1;
                  bool s = sle.contains(number);
                  return NumberBall(
                      num: number,
                      initialSelected: s,
                      onSelect: (b) {
                        if (!b.value) {
                          sle.add(number);
                        } else {
                          sle.remove(number);
                        }
                      });
                },
                itemCount: 45,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                print('hbhb____${sle}');
                // randomController.onSele(sle);
                nums(sle);
                Get.back();
              },
              child: Text('선택'),
            ),
          )
        ]);
  }


  
  
 static void getDi(BuildContext context) {
   final Random2Controller randomController = Get.find<Random2Controller>();
   List<int> orList = List.from(randomController.sel);
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text('Select Numbers'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,),
              itemBuilder: (context, index) {
                int number = index + 1;
                print('isSelList+${orList}');
                bool isSel =  orList.contains(number);
                print('isSelNum_${number}_${isSel}');
                return NumberBall2(
                  num: number,
                  isSelected: isSel,
                  onSelect: (isSelected) {
                    if(isSelected){
                      orList.add(number);
                    }else{
                      orList.remove(number);
                    }
                  },
                );
              },
              itemCount: 45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                randomController.sel.assignAll(orList);

              Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  
  
  


  static Widget NumberBalla(int numbers, bool s) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: s ? Colors.grey : Colors.transparent,
        border: Border.all(
          color: Colors.black, // 테두리 색
          width: 2.0, // 테두리 두께
        ),
      ),
      child: Center(
        child: Text(
          '$numbers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class NumberBall extends GetWidget {
  Function(RxBool d) onSelect;
  RxBool isSelected = false.obs; // RxBool을 사용하여 상태를 관리
  int num;

  NumberBall(
      {required this.num,
      required bool initialSelected,
      required this.onSelect})
      : isSelected = initialSelected.obs; // : 는 초기화 한다는뜻
  List<int> sl = [];

  // NumberBall ( 해당 번호 , 원래 선택된 상태인지 )

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // isSelected 값을 토글
        onSelect(isSelected);
        isSelected.toggle();
        print('ddddd__${num}');
      },
      child: Obx(() => Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected.value ? Colors.black : Colors.white,
              border: Border.all(
                color: Colors.black, // 테두리 색
                width: 2.0, // 테두리 두께
              ),
            ),
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(
                  color: isSelected.value ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }
}



class YourDialog extends StatelessWidget {
  List<int> ll = [];
  // YourDialog({required this.ll});
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Select Numbers'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: GridView.builder(gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,),
            itemBuilder: (context, index) {
              int number = index + 1;
              bool isSel =  ll.contains(number);
              return NumberBall2(
                num: number,
                  isSelected:  isSel,
                onSelect: (isSelected) {
                  // 아이템이 선택될 때 처리
                  print('Number $number is selected: $isSelected');
                },
              );
            },
          itemCount: 45,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {

            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

// class NumberGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5,
//         crossAxisSpacing: 4,
//         mainAxisSpacing: 4,
//       ),
//       itemBuilder: (context, index) {
//         int number = index + 1;
//         bool isSelected =
//         return NumberBall2(
//           num: number,
//           onSelect: (isSelected) {
//             // 아이템이 선택될 때 처리
//             print('Number $number is selected: $isSelected');
//           },
//         );
//       },
//       itemCount: 45,
//     );
//   }
// }

class NumberBall2 extends StatefulWidget {
  final int num;
  final bool isSelected;
  final ValueChanged<bool> onSelect;

  NumberBall2({required this.num, required this.isSelected ,required this.onSelect});

  @override
  _NumberBall2State createState() => _NumberBall2State(isSelected);
}

class _NumberBall2State extends State<NumberBall2> {
  bool isSelected;

  _NumberBall2State(this.isSelected);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelect(isSelected);
      },
      child: Container(
        width: 50,
        height: 50,
        color: isSelected ? Colors.blue : Colors.grey,
        child: Center(
          child: Text(
            widget.num.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}