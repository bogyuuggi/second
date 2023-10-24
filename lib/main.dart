import 'package:flutter/material.dart';
import 'package:second/tab1.dart';

void main() => runApp(MaterialApp(
  title: 'Home',
  home: MyApp(),
));


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('cat.jpg')
                      ),
                      SizedBox(height: 10),
                      Text('떼껄룩', style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 5,),
                      Text('takealook@gmail.com', style: TextStyle(color: Colors.white, fontSize: 14,)),
                    ],
                  ),
                ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              title: Text('Tab1'),
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Tab1())
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
