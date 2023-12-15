class Loto {
  int? totSellamnt;
  String? returnValue;
  String? drwNoDate;
  int? firstWinamnt;
  int? drwtNo6;
  int? drwtNo4;
  int? firstPrzwnerCo;
  int? drwtNo5;
  int? bnusNo;
  int? firstAccumamnt;
  int? drwNo;
  int? drwtNo2;
  int? drwtNo3;
  int? drwtNo1;

  Loto(
      {this.totSellamnt,
      this.returnValue,
      this.drwNoDate,
      this.firstWinamnt,
      this.drwtNo6,
      this.drwtNo4,
      this.firstPrzwnerCo,
      this.drwtNo5,
      this.bnusNo,
      this.firstAccumamnt,
      this.drwNo,
      this.drwtNo2,
      this.drwtNo3,
      this.drwtNo1});


  Loto.fromJson(Map<String, dynamic> json) {
    totSellamnt = json['totSellamnt'];
    returnValue = json['returnValue'];
    drwNoDate = json['drwNoDate'];
    firstWinamnt = json['firstWinamnt'];
    drwtNo6 = json['drwtNo6'];
    drwtNo4 = json['drwtNo4'];
    firstPrzwnerCo = json['firstPrzwnerCo'];
    drwtNo5 = json['drwtNo5'];
    bnusNo = json['bnusNo'];
    firstAccumamnt = json['firstAccumamnt'];
    drwNo = json['drwNo'];
    drwtNo2 = json['drwtNo2'];
    drwtNo3 = json['drwtNo3'];
    drwtNo1 = json['drwtNo1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totSellamnt'] = this.totSellamnt;
    data['returnValue'] = this.returnValue;
    data['drwNoDate'] = this.drwNoDate;
    data['firstWinamnt'] = this.firstWinamnt;
    data['drwtNo6'] = this.drwtNo6;
    data['drwtNo4'] = this.drwtNo4;
    data['firstPrzwnerCo'] = this.firstPrzwnerCo;
    data['drwtNo5'] = this.drwtNo5;
    data['bnusNo'] = this.bnusNo;
    data['firstAccumamnt'] = this.firstAccumamnt;
    data['drwNo'] = this.drwNo;
    data['drwtNo2'] = this.drwtNo2;
    data['drwtNo3'] = this.drwtNo3;
    data['drwtNo1'] = this.drwtNo1;
    return data;
  }

  //DB 저장

Map<String, dynamic> toMap(){
    return {
      'drwNoDate' : drwNoDate,
      'drwtNo1' : drwtNo1,
      'drwtNo2' : drwtNo2,
      'drwtNo3' : drwtNo3,
      'drwtNo4' : drwtNo4,
      'drwtNo5' : drwtNo5,
      'drwtNo6' : drwtNo6,
      'bnusNo' : bnusNo
    };
}

Loto.fromMap(Map<dynamic , dynamic> map){
    drwNoDate = map?['drwNoDate'];
    drwtNo1 = map?['drwNo1'];
    drwtNo2 = map?['drwNo2'];
    drwtNo3 = map?['drwNo3'];
    drwtNo4 = map?['drwNo4'];
    drwtNo5 = map?['drwNo5'];
    drwtNo6 = map?['drwNo6'];
    bnusNo = map?['bnusNo'];
}

}