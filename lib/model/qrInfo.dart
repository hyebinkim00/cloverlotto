import 'package:flutter/material.dart';

class QrInfo{
  String? serial;
  String? date;
  List<NumData>? winnerList;
  String? notice;
  List<NumData>? myNumList;

  QrInfo({this.serial,this.date,this.winnerList,this.notice,this.myNumList});
}

class NumData{
  String? number;
  Color? color;

  NumData({
    this.number,
    this.color});
}