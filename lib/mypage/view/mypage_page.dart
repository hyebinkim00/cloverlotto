import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyPage extends StatelessWidget {
  // 앱바에서 뒤로 버튼
  // 탭바로 직접입력 , QR스캔 분리
  final List<String> cardText1 = ['저장기록', '구입번호 당첨확인', '랜덤번호 생성목록'];
  final List<String> cardText2 = ['알림설정', '푸시알림 기록', '푸쉬알림 동의'];
  final List<String> cardText3 = ['도움말', '앱 사용방법', '로또 당첨금 규칙'];

  @override
  Widget build(BuildContext context) {
    List<String> combinedItems = [];

    // 리스트들을 하나로 합침
    combinedItems.addAll(cardText1);
    combinedItems.addAll(cardText2);
    combinedItems.addAll(cardText3);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [Text('반갑습니다!'), Text('이번주 로또 추첨은 ' ' 일 입니다.')],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0 ||
                        index == cardText1.length ||
                        index == cardText1.length + cardText2.length) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              combinedItems[index],
                              style: TextStyle(fontSize: 30), // 텍스트 크기 30으로 설정
                            ),
                            onTap: (){performAction(index);},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Divider(
                              thickness: 3,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }

                    // 나머지 경우는 구분선을 추가하지 않고 각 항목을 반환
                    Color color = (index % 2 == 0) ? Colors.blue : Colors.green;
                    return Column(
                        //  color: color,
                        children: [
                          ListTile(
                            title: Text(combinedItems[index]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ]);
                  },
                  itemCount: combinedItems.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void performAction(int index) {
    // 각 항목에 대한 특정 기능을 수행합니다.
    print('Performing action for $index');
    if (index == 0) {
      Get.toNamed(RouteNames.MYPAGE);
    }
    // 여기에 각 항목에 대한 특정 기능을 추가할 수 있습니다.
    // 예를 들어, 해당 항목에 대한 화면 이동 또는 다른 작업을 수행할 수 있습니다.
  }
}
