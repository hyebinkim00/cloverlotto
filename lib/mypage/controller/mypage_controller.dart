
import 'package:cloverlotto/model/selfnum.dart';
import 'package:get/get.dart';

import '../../db/dbhelper.dart';
import '../../model/loto.dart';

class MyPageController extends GetxController{
  RxList<selfNum> list =<selfNum>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSelfList();
  }
  // DB(selfNum)에 저장된 값 불러오기
  Future<void> getSelfList() async {
    List<selfNum> dbList = await DBHelper().getselfList();
    // List<int> list1 = [];
    // List<Map<String, dynamic>> dbwinList = await DBHelper().queryByColumn2Value(222);
    // print('kkkk'+'${dbList.length}');


    list.value = dbList;
  }

  // selfList ( 회차 + 번호 6개 )
  // lotoList ( 회차 에 대한 당첨번호 )







}