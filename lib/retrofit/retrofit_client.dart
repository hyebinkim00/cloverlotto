import 'dart:convert';

import 'package:cloverlotto/model/loto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: 'https://www.dhlottery.co.kr')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/common.do')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'Accept' : 'application/json'
  })
  Future<Loto> getTasks(@Query("method") String key, @Query("drwNo") int tab);
}
