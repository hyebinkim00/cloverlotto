import 'package:cloverlotto/model/selfnum.dart';
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

        // MainController 에서 로또 정보 저장
        await db.execute(
          "CREATE TABLE Lotos(id INTEGER PRIMARY KEY, drwNoDate TEXT, drwNo INTEGER, drwtNo1 INTEGER, drwtNo2 INTEGER, drwtNo3 INTEGER, drwtNo4 INTEGER, drwtNo5 INTEGER, drwtNo6 INTEGER, bnusNo INTEGER)",
        );

        // SelfPage 에서 입력한 번호 6개 리스트 + 회차 선택 넣어야 됨
        await db.execute(
          'CREATE TABLE selfNum(id INTEGER PRIMARY KEY, serial INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)',
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
  Future<void> insertDataList(selfNum list) async {
    final db = await database; // 데이터베이스 인스턴스 가져오기
    await db.insert(
      'selfNum',
      list.toMap(), // 추가할 데이터
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 데이터 처리 방법 설정
    );
  }

  Future<List<selfNum>> getselfList() async{
    List<selfNum> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps =  await db.query('selfNum');
    for(var map in maps) {
      lists.add(selfNum.fromMap(map));
    }
    print(lists[0].toString());
    return lists;
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


  Future addLoto(Loto loto) async {
    final db = await database;
    await db.insert('Lotos', loto.toMap());
  }


  //MainController에서 회차별 정보 저장한 Get

  Future<List<Loto>> getLoto() async {
    List<Loto> lists = [];
    final db = await database; // 데이터베이스 인스턴스 가져오기
    List<Map<String, dynamic>> maps =
    await db.query('Lotos', orderBy: 'drwNo DESC');
    for (var map in maps) {
      lists.add(Loto.fromMap(map));
    }
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


  // 한 번호당 한개의 리스트니까 return List<int> 로 바꿔야됨
  Future<List<int>> queryByColumn2Value(int? targetValue) async {
    List<int> list = [];
    Database dbClient = await database;
    final List<Map<String, dynamic>> maps  =  await dbClient.query(
      'Lotos',
      where: 'drwNo = ?',
      whereArgs: [targetValue],
    );

    for (int i = 1; i <= 6; i++) {
      String columnName = 'drwtNo$i';
      list.add(maps[0][columnName]);
    }
    return list;
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