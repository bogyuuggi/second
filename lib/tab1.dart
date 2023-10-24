import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('기본구조복습'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'tab1'),
                Tab(text: 'tab2')
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Image.asset('cat.jpg')),
              Center(child: Image.asset('cat.jpg'))
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 70,
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('1번째 탭 클릭'))
                          );
                        },
                        child: Icon(Icons.home),
                      ),
                      Text('Home'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.search),
                      Text('Search'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
