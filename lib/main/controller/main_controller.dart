import 'dart:convert';

import 'package:cloverlotto/model/loto.dart';
import 'package:cloverlotto/retrofit/retrofit_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MainController extends GetxController{

  // Rx<loto?> numbers = Rx<loto?>(loto()).obs;
  var s  = 0.obs;
  // RxInt 는 비동기 처리 하겟다는 뜻, obs 는 observer역할을 하겟다 뜻
 final numbers= loto().obs;
 RxInt num = 0 .obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // numbersList();
    retro();
  }

   Future<void> numbersList() async{
    try {
      var url = Uri.parse(
          'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903');
      http.Response response = await http.get(url);
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        loto lotos = loto.fromJson(json);
        numbers.value = lotos;
      }
    } catch(e){

    }

  }


  Future<void> retro() async{

    final logger = PrettyDioLogger(
      request: true,
      responseBody: true
    );

    try {

      final dio = Dio(BaseOptions(
        responseType: ResponseType.plain, // 이 부분을 수정
      ));
      dio.interceptors.add(logger);

      final client = RestClient(dio);
      loto response = await client.getTasks('getLottoNumber', 1092);
      numbers.value = response;
      print(response.returnValue??"g");
      // final loto lottoResult = loto.fromJson(response);
      // print(lottoResult.returnValue?? 'no');
      
    }catch(e){
      print('Error: $e');
      if (e is DioError) {
        if (e.response?.data is String) {
          // 응답 데이터가 String인 경우에 대한 처리
          print('Server response (String): ${e.response?.data}');
        } else {
          print('DioError: ${e.response?.statusCode}, ${e.message}');
          print('Server response: ${e.response?.data}');
        }
      }
    }
  }

  void updated(){
    // numbers.update((val) {
    //   val?.returnValue = 'hbhb';});
    numbers.value?.returnValue = 'update';
    s++;
    num++;
  }

}