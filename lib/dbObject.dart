import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBObject{
  static final DBObject instance = DBObject._internal();
  factory DBObject(){
    return instance;
  }
  DBObject._internal();

  static Database? _db;

  Future<Database?> get db async{
    if (_db != null){
      return _db;
    } else {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'dbEx1.db'),
        version: 1,
        onCreate: (db, version) async {
          await _createTable(db);
        },
        onOpen: (db) async {
          // 데이터베이스를 열 때마다 테이블이 있는지 확인
          var tableExists = await db.rawQuery(
              "SELECT name FROM sqlite_master WHERE type='table' AND name='student'");
          if (tableExists.isEmpty) {
            await _createTable(db);
          }
        },
      );
      return _db;
    }
  }

  _createTable(Database db) async {
    await db.execute('''
    CREATE TABLE student(
      stuNo INTEGER PRIMARY KEY,
      name TEXT,
      age INTEGER,
      addr TEXT
    ) 
  ''');
  }

  Future<List<Map<String, dynamic>>> stuList() async{
    final db = await instance.db;
    return await db!.query('student');
  }
  Future<int> stuDeleteAll() async{
    final db = await instance.db;
    return await db!.delete('student');
  }
  Future<int> stuInsert(Map<String, dynamic> stu) async{
    final db = await instance.db;
    return await db!.insert('student', stu);
  }
  Future<int> stuDelete(int stuNo) async{
    final db = await instance!.db;
    return await db!.delete(
        'student',
        where : 'stuNo = ?',
        whereArgs: [stuNo]
    );
  }
  Future<int> stuUpdate(Map<String, dynamic> stu, int stuNo) async{
    final db = await instance.db;
    return await db!.update(
        'student', stu,
        where : 'stuNo = ?',
        whereArgs: [stuNo]);
  }

  Future<List<Map<String, dynamic>>> stuMap(int stuNo) async{
    final db = await instance.db;
    return await db!.query(
        "student",
        where: 'stuNo = ?',
        whereArgs: [stuNo]);
  }
}