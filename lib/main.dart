import 'package:flutter/material.dart';
import 'package:wechat_demo/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        //底部 tabbar 点击高亮颜色
        highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
        // 水波纹颜色
        splashColor: Color.fromRGBO(1, 0, 0, 0.0),
      ),
      home: RootPage(),
    );
  }
}

