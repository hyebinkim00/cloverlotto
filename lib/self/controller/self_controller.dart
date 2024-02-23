import 'package:cloverlotto/model/selfnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../model/loto.dart';
import '../../sqllite/db.dart';

class SelfController extends GetxController {
  RxList<Widget> widgets = <Widget>[].obs;

  RxList<RxList<bool>> isSelectedLists =
      <RxList<bool>>[].obs; // 위젯마다 isSelected 목록을 저장할 RxList

 

  RxList<int> selectList = <int>[].obs;
  RxList<int> selectList2 = <int>[].obs;
  RxList<int> selectList3 = <int>[].obs;
  RxList<int> selectList4 = <int>[].obs;
  RxList<int> selectList5 = <int>[].obs;

  Map<int, RxList<int>> selectLists = {
    0: <int>[].obs,
    1: <int>[].obs,
    2: <int>[].obs,
    3: <int>[].obs,
    4: <int>[].obs,
  };

  RxList<bool> isSelected = List.generate(45, (index) => false).obs;

  // RxInt serial = 0.obs;

  @override
  void onInit() {
    // var last = Get.arguments['lastSerial'];
    // serial.value = last;
    // addWidget();

    widgets.addAll(List.generate(5, (index) => items(index)));

   // widgets = <Widget>[items(0)].obs;
    // isSelectedLists.add(List.generate(45, (index) => false)
    //     .obs); // 새로운 위젯에 대한 isSelected 목록을 추가
    super.onInit();
  }

  // 눌린 수 -> selectList 에 없으면 저장 있으면 제거

  // boolean값으로 저장

  // boolean값으로 저장
  void selected(int index) {
    //눌렸을때 리스트 가 5개 이하면 추가,삭제가능  6개면 삭제만
    if (selectList.length < 6) {
      isSelected[index] = !isSelected[index];
      if (isSelected[index]) {
        selectList.add(index + 1);
      } else {
        selectList.remove(index + 1);
      }
    } else {
      if (isSelected[index]) {
        isSelected[index] = !isSelected[index];
        selectList.remove(index + 1);
      }
    }
    //오름차순 정리
    selectList.sort();
  }


  // 해당 행 선택 갯수 확인
  int tessts (List<bool> d){
   int co = d.where((value) => value == true).length;
   print('co__${co}');
   return co;
  }


  void addWidget() {

    for(int i = 0 ; i< 5 ; i++) {
      widgets.add(items(widgets.length));
      isSelectedLists.add(List
          .generate(45, (index) => false)
          .obs); // 새로운 위젯에 대한 isSelected 목록을 추가
    }
  }

  void toggleSelection(int widgetIndex, int gridIndex) {
    print('toooo__ ${widgetIndex}+__${gridIndex}');

    //


    if(tessts(isSelectedLists[widgetIndex].value) < 6) {
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];

      if (isSelectedLists[widgetIndex][gridIndex]) {
        switch (widgetIndex) {
          case 0 :
            selectList.add(gridIndex+1);
            break;
          case 1 :
            selectList2.add(gridIndex+1);
            break;
          case 2 :
            selectList3.add(gridIndex+1);
            break;
          case 3 :
            selectList4.add(gridIndex+1);
            break;
          case 4 :
            selectList5.add(gridIndex+1);
            break;
        }
      } else {
        switch (widgetIndex) {
          case 0 :
            selectList.remove(gridIndex+1);
            break;
          case 1 :
            selectList2.remove(gridIndex+1);
            break;
          case 2 :
            selectList3.remove(gridIndex+1);
            break;
          case 3 :
            selectList4.remove(gridIndex+1);
            break;
          case 4 :
            selectList5.remove(gridIndex+1);
            break;
        }
      }
    } else if (tessts(isSelectedLists[widgetIndex].value) ==  6  && isSelectedLists[widgetIndex][gridIndex]) {
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];
      switch (widgetIndex) {
        case 0 :
          selectList.remove(gridIndex+1);
          break;
        case 1 :
          selectList2.remove(gridIndex+1);
          break;
        case 2 :
          selectList3.remove(gridIndex+1);
          break;
        case 3 :
          selectList4.remove(gridIndex+1);
          break;
        case 4 :
          selectList5.remove(gridIndex+1);
          break;
      }

    }
    selectList.sort();
    selectList2.sort();
    selectList3.sort();
    selectList4.sort();
    selectList5.sort();
  }

  void toggleSelections(int widgetIndex, int gridIndex) {
    final isSelectedList = selectLists[widgetIndex];

    if (isSelectedList!.length < 6 ) {
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];

      isSelectedList.contains(gridIndex + 1)
          ? isSelectedList.remove(gridIndex + 1)
          : isSelectedList.add(gridIndex + 1);


    } else if (isSelectedList!.length == 6  && isSelectedLists[widgetIndex][gridIndex]) {
      // 선택 목록이 이미 6개이고 새로운 항목을 추가하려고 할 때는 가장 오래된 것을 제거
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];

      isSelectedList.remove(gridIndex + 1);
    }

    isSelectedList.sort();

    print('GFFFFF__S${selectLists.toString()}_____${isSelectedList.toString()}');
  }



  Widget items(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        // height: 500,
        // width: 300, // 각 항목의 너비
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.orangeAccent), // 테두리 스타일 설정
              ),
              height: 50,
              width: double.infinity,
              child:  Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('${index}'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.orange,
                      child: Center(
                        child: Text('1000원'),
                      ),
                    ),
                  ),
                ],),
            ),
            SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, // GridView가 자신의 크기에 맞춰야 함
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 10, // 가로 간격을 조절하세요.
                    mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                    crossAxisCount: 7),
                itemCount: 45, // GridView에 표시할 항목 수
                itemBuilder: (context, gridIndex) {
                  return GestureDetector(
                      onTap: () {
                        //     color: isSelectedLists[index][gridIndex] ? Colors.black : Colors.yellow,
                        print('ListView 아이템 ${index}에서 Grid item $gridIndex 클릭됨');
                        // toggleSelection(index, gridIndex);
                        toggleSelections(index, gridIndex);
                      },
                      child: Obx(
                        () => SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  height: 20),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.transparent),
                                        left: BorderSide(
                                            color: Colors.transparent),
                                        right: BorderSide(
                                            color: Colors.white)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  child: Center(child: Text('${gridIndex+1}'),),
                                  height: 20),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  height: 20)
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            TextButton(onPressed: () {
              isSelectedLists[index].fillRange(0,45,false);
            },
            child:Text('초기화',style: TextStyle(color: Colors.orangeAccent),) ,)
          ],
        ),
      ),
    );
  }

  // 선택한 번호 6개 저장하기
  void saveList() async {

    if (selectList.length != 6) {
      Fluttertoast.showToast(msg: '숫자 6개를 입력하세요!');
    } else {
      await DBHelper().insertDataList(selfNum(
          serial: 1099,
          num1: selectList[0],
          num2: selectList[1],
          num3: selectList[2],
          num4: selectList[3],
          num5: selectList[4],
          num6: selectList[5]));
      isSelected.assignAll(List.generate(45, (index) => false));
      selectList.clear();
    }
    // selectDb();
  }

  void saveLists() async {


    if (selectList.length != 6) {
      Fluttertoast.showToast(msg: '숫자 6개를 입력하세요!');
    } else {
      await DBHelper().insertDataList(selfNum(
          serial: 1099,
          num1: selectList[0],
          num2: selectList[1],
          num3: selectList[2],
          num4: selectList[3],
          num5: selectList[4],
          num6: selectList[5]));
      isSelected.assignAll(List.generate(45, (index) => false));
      selectList.clear();
    }
    // selectDb();
  }

  // 당첨 번호 비교하는 로직 필요
  void selectdrwNo() async {
    List<int> db = await DBHelper().queryByColumn2Value(1098);
    print('HHHHHHD_' + '${db.length}');
    // 결과 출력 또는 원하는 작업 수행
    // for (Map<String, dynamic> row in db) {
    //   print(
    //       'ID: ${row['drwNo']}, Column1: ${row['drwNo']}, Column2: ${row['drwNo']}');
    // }
  }

  void listCon() {
    print('SElFFFFLIST__${selectList.toString()}__${selectList2.toString()}_${selectList3.toString()}_${selectList4.toString()}_${selectList5.toString()}');
  }
}
