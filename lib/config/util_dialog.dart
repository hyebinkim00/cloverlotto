import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UtilDialog {
  // 제거 할 숫자 , 포함할 숫자
 static void selectNumbers(BuildContext context, bool range, Function(int) nums) {
    showDialog(
        context: context,
        builder: (BuildContext build) {
          return AlertDialog(
            title: Text(range ? '포함 할 숫자를 선택하세요!' : '제외 할 숫자를 선택하세요!'),
            content: Expanded(
                child: Column(
              children: [ GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                ),
              itemBuilder: (context, index) {
                int number = index + 1;
                return GestureDetector(
                  onTap: (){
                    nums(index);
                  },
                  child: NumberBall(number),
                );
                NumberBall(number);
              },
              itemCount: 45,
            )],
            )),
          );
        });
  }

  static Widget NumberBall(int numbers){
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(
          color: Colors.black, // 테두리 색
          width: 2.0, // 테두리 두께
        ),
      ),
      child: Center(
        child: Text(
          '$numbers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}
