
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/random_controller.dart';

class RandomPage extends GetView<RandomController>{

  final RandomController _gcontroller = Get.put(RandomController());

  // 번호추첨 -> 제외 하고 싶은 숫자 , 포함하고 싶은 숫자  , ---> 여섯개 숫자 랜덤 리스트 10개 == > 생성된 번호 저장 가능
  TextEditingController _controller = TextEditingController();


  List<List<int>> allRandomNumbers = [];
  late String enteredNumber;

  String create_list(){
    var random = Random();

    for (var i = 0; i < 15; i++) {
      List<int> randomNumbers = [];

      // 1부터 45까지의 숫자 중에서 랜덤으로 6개 선택
      while (randomNumbers.length < 6) {
        int randomNumber = random.nextInt(45) + 1;
        if (randomNumber != int.parse(enteredNumber)){
          randomNumbers.add(randomNumber);
        }
      }

      // 리스트를 정렬
      randomNumbers.sort();

      // 생성된 랜덤 숫자 리스트를 전체 리스트에 추가
      allRandomNumbers.add(randomNumbers);
    }
    print(allRandomNumbers.toString());
    return allRandomNumbers.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: TextButton(onPressed: () { _showNumberInputDialog(context); },
                child: Text('제거할 숫자')),),
            Obx(() => Row(
              children: [
                Text('${_gcontroller.inNum}')
              ],
            ), ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: allRandomNumbers.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text('${allRandomNumbers[index]}'),
                );
              },

            ),
            TextButton(onPressed: (){create_list();
              }, child: Text('번호 생성하기'))
          ],
        ),
      ),
    );
  }

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
              FilteringTextInputFormatter.allow(RegExp(r'^([1-9]|[1-3][0-9]|4[0-5])$')),
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
                enteredNumber = _controller.text;
                _gcontroller.inNum.value = enteredNumber;
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