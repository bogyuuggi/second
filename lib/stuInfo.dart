import 'package:flutter/material.dart';
import 'package:second_project/sample/dbObject.dart';

class StuInfo extends StatefulWidget {
  final stuNo;
  StuInfo({required this.stuNo});

  @override
  _StuInfoState createState() => _StuInfoState(stuNo);
}

class _StuInfoState extends State<StuInfo> {
  _StuInfoState(this.stuNo);
  int stuNo; // 생성자로 초기화

  Map<String, dynamic>? stuMap;
  late TextEditingController _name;
  late TextEditingController _age;
  late TextEditingController _addr;
  bool _flg = false;

  _load() async{
    List<Map<String, dynamic>> list
      = await DBObject.instance.stuMap(stuNo);

    setState(() {
      stuMap = list[0];
      _name = TextEditingController(text : list[0]['name']);
      _age = TextEditingController(text : list[0]['age'].toString());
      _addr = TextEditingController(text : list[0]['addr']);
    });
  }
  Future<void> _update() async{
    final stu = {
      'name' :  _name.text,
      'age' : int.parse(_age.text),
      'addr' : _addr.text
    };
    await DBObject.instance!.stuUpdate(stu, stuNo);
    _load();
    setState(() {
      _flg = false;
    });
  }

  @override
  void initState() {
    _load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상세보기"),
        actions: [
          if(_flg)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async{
                await _update();
              },
            )
          else
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _flg = true;
                });
              },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if(_flg)
              TextField(
                controller: _name,
                decoration: InputDecoration(labelText: '이름'),
              )
            else
              Text('이름: ${stuMap?['name']}'),
            SizedBox(height: 16),
            if(_flg)
              TextField(
                controller: _age,
                decoration: InputDecoration(labelText: '나이'),
              )
            else
              Text('나이: ${stuMap?['age']}'),
            SizedBox(height: 16),
            if(_flg)
              TextField(
                controller: _addr,
                decoration: InputDecoration(labelText: '주소'),
              )
            else
              Text('주소: ${stuMap?['addr']}'),
          ],
        ),
      ),
    );
  }
}
