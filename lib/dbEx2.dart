import 'package:flutter/material.dart';
import 'package:second_project/sample/dbObject.dart';
import 'package:second_project/sample/stuInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbEx2 extends StatefulWidget {
  @override
  State<dbEx2> createState() => _dbEx1State();
}

class _dbEx1State extends State<dbEx2> {
  final _nameController = TextEditingController();
  final _stuNoController = TextEditingController();
  final _ageController = TextEditingController();
  final _addrController = TextEditingController();

  static Database? _db;
  List<Map<String, dynamic>>? _students;
  int? _selectedStuNo; // 라디오 버튼의 선택값



  _loadDB() async{
    final List<Map<String, dynamic>> students = await DBObject.instance!.stuList();
    setState(() {
      _students = students;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initDB();
  }
  Future<void> insertStudent() async {
    final Map<String, dynamic> student = {
      'stuNo': int.parse(_stuNoController.text),
      'name': _nameController.text,
      'age': int.parse(_ageController.text),
      'addr': _addrController.text
    };
    await DBObject.instance!.stuInsert(student);
    _stuNoController.clear();
    _nameController.clear();
    _ageController.clear();
    _addrController.clear();
    _loadDB();
  }

  Future<void> deleteAll() async {
    DBObject.instance!.stuDeleteAll();
    _loadDB();
  }

  Future<void> deleteSelected(BuildContext context) async {
    if (_selectedStuNo != null) {
      bool? deleteFlg = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("삭제"),
            content: Text("정말로 선택한 학생을 삭제하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("예"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("아니오"),
              )
            ],
          ));

      if (deleteFlg == true) {
        await DBObject.instance!.stuDelete(_selectedStuNo!);
        _loadDB();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("삭제할 학생을 선택하세요."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DB")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _stuNoController,
              decoration: InputDecoration(labelText: '학번.'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _addrController,
              decoration: InputDecoration(labelText: '주소'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: insertStudent,
                  child: Text("추가")
              ),
              ElevatedButton(
                  onPressed: () async {
                    await deleteSelected(context);
                  },
                  child: Text("선택 삭제")
              ),
              ElevatedButton(
                  onPressed: deleteAll,
                  child: Text('전체 삭제')
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                itemCount: _students?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio(
                      value: _students![index]['stuNo'] as int,
                      groupValue: _selectedStuNo,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedStuNo = value;
                        });
                      },
                    ),
                    title: Text(_students![index]['name']),
                    subtitle: Text('나이: ${_students![index]['age']} 주소: ${_students![index]['addr']}'),
                    onTap: () {
                      var result = Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StuInfo(stuNo: _students![index]['stuNo'] as int),
                        ),
                      );
                    },
                  );
                },
              )
          )
        ],
      ),
    );
  }
}
