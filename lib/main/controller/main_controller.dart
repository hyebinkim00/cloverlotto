import 'dart:convert';

import 'package:cloverlotto/model/loto.dart';
import 'package:cloverlotto/retrofit/retrofit_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:cp949_codec/cp949_codec.dart';

class MainController extends GetxController{

  // Rx<loto?> numbers = Rx<loto?>(loto()).obs;
  var s  = 0.obs;
  // RxInt 는 비동기 처리 하겟다는 뜻, obs 는 observer역할을 하겟다 뜻
 final numbers= loto().obs;
 RxList<int> ll = [0,0,0,0,0,0,0,0].obs;
 RxInt num = 0 .obs;
 RxString kk ='s'.obs;
 var today;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLastNo();
  }

  String getDate(){
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
    today = dateFormat.format(dateTime);
    return today;
  }


  // 1. 마지막 회차 정보 가져오기 -- 저장 해야됨 !
  void getLastNo() async {
    // var url = Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin&wiselog=C_A_1_1');
    // http.Response response = await http.get(url,headers:{ 'Content-Type': 'text/html; charset=EUC-KR', 'Accept-Charset': 'EUC-KR,*;q=0.8',}); /*charset=UTF-8*/
    final response = await http.get(Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin'));


    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }

    final decodedBody = latin1.decode(response.bodyBytes);

    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final element = document.querySelector('.win_result strong');
    kk.value= element?.text?? '';

    String latest = element?.text??'g';

    String dd = latest.replaceAll('회', '');
    int ddd = int.parse(dd);
    retro(ddd);
  }

  Future<void> retro(int dd) async{

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
      loto response = await client.getTasks('getLottoNumber', dd);
      numbers.value = response;
      ll.clear();
      ll.addAll([response.drwtNo1??0,response.drwtNo2??0,response.drwtNo3??0,response.drwtNo4??0,response.drwtNo5??0,response.drwtNo6??0,0,response.bnusNo??0]);
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




  Future<void> numbersList(int numss) async{
    try {
      var url = Uri.parse(
          'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${numss}');
      http.Response response = await http.get(url);
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        loto lotos = loto.fromJson(json);
        numbers.value = lotos;
      }
    } catch(e){

    }
  }


}