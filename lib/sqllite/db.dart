import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/loto.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._(); // DBHelper의 싱글톤 객체 생성
  static Database? _database; // 데이터베이스 인스턴스를 저장하는 변수

  DBHelper._(); // DBHelper 생성자(private)

  factory DBHelper() => _instance; // DBHelper 인스턴스 반환 메소드

  // 데이터베이스 인스턴스를 가져오는 메소드
  Future<Database> get database async {
    if (_database != null) {
      // 인스턴스가 이미 존재한다면
      return _database!; // 저장된 데이터베이스 인스턴스를 반환
    }
    _database = await _initDB(); // 데이터베이스 초기화
    return _database!; // 초기화된 데이터베이스 인스턴스 반환
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath(); // 데이터베이스 경로 가져오기
    final path = join(dbPath, 'example.db'); // 데이터베이스 파일 경로 생성
    return await openDatabase(
      path, // 데이터베이스 파일 경로
      version: 1, // 데이터베이스 버전
      onCreate: (db, version) async { // onCreate 처음 만들어질때만 호출됨
        await db.execute(
          // SQL 쿼리를 실행하여 데이터베이스 테이블 생성
          'CREATE TABLE example(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)',
        );
        await db.execute(
          // SQL 쿼리를 실행하여 데이터베이스 테이블 생성
          'CREATE TABLE selfNum(id INTEGER PRIMARY KEY, value1 INTEGER, value2 INTEGER, value3 INTEGER, value4 INTEGER, value5 INTEGER, value6 INTEGER)',
        );
        await db.execute(
          "CREATE TABLE numbers(id INTEGER PRIMARY KEY, valueList TEXT)",
        );
        await db.execute(
          "CREATE TABLE latest(serial TEXT)",
        );
        await db.execute(
          "CREATE TABLE Lotos(id INTEGER PRIMARY KEY, drwNoDate TEXT, drwtNo1 INTEGER, drwtNo2 INTEGER, drwtNo3 INTEGER, drwtNo4 INTEGER, drwtNo5 INTEGER, drwtNo6 INTEGER, bnusNo INTEGER)",
        );
      },
    );
  }

  // 데이터 추가 메소드
  Future<void> insertData(String name, int value) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.insert(
      'example', // 데이터를 추가할 테이블 이름
      {
        'name': name,
        'value': value,
      }, // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }

  // 데이터 추가 메소드
  Future<void> insertDataList(List<int> selfNum) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    print('HB_INSERT___$selfNum');
    await db.insert(
      'selfNum', // 데이터를 추가할 테이블 이름
      {
        'value1': selfNum[0],
        'value2': selfNum[1],
        'value3': selfNum[2],
        'value4': selfNum[3],
        'value5': selfNum[4],
        'value6': selfNum[5]
      }, // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }

  Future<void> insertNumberListString(List<int> numbers) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    final String numbersString = numbers.join(',');
    print('HBBBB' + numbersString);
    await db.insert(
      'numbers',
      {'valueList': numbersString},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> insertNumber(String serial) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기

    await db.insert(
      'latest',
      {'serial': serial},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future addLoto(Loto loto) async {
    final db = await database;

    await db.insert('Lotos', loto.toMap());
  }

  
  Future<List<Loto>> getLoto() async{
    List<Loto> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps =  await db.query('Lotos');
    for(var map in maps) {
      lists.add(Loto.fromMap(map));
    }
    print('DDDDD'+lists[0].drwNoDate.toString());
    return lists;
  }

  // 데이터 조회 메소드
  Future<List<Map<String, dynamic>>> selectData(String tabaleName) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    return await db.query(tabaleName); // 데이터베이스에서 모든 데이터 조회
  }

  Future<List<List<int>>> queryAllLists() async {
    final db = await database;

    // Query all rows in the 'numbers' table
    final List<Map<String, dynamic>> maps = await db.query('numbers');

    // Convert each row to a List<int>
    return maps.map((map) {
      final String numbersString = map['valueList'];
      return numbersString.split(',').map((e) => int.parse(e)).toList();
    }).toList();
  }
  
  

  // 데이터 수정 메소드
  Future<void> updateData(int id, String name, int value) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.update(
      'example', // 수정할 테이블 이름
      {
        'name': name,
        'value': value,
      }, // 수정할 데이터
      where: 'id = ?', // 수정할 데이터의 조건 설정
      whereArgs: [id], // 수정할 데이터의 조건 값
    );
  }

  // 데이터 삭제 메소드
  Future<void> deleteData(int id) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.delete(
      'example', // 삭제할 테이블 이름
      where: 'id = ?', // 삭제할 데이터의 조건 설정
      whereArgs: [id], // 삭제할 데이터의 조건 값
    );
  }

}