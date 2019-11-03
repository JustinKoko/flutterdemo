import 'package:flutter/material.dart';

class MineHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('跳转');
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 225,
              color: Colors.white,
              padding: EdgeInsets.only(left: 10, top: 100, right: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: NetworkImage('https://randomuser.me/api/portraits/women/66.jpg'))),
                  ), // 头像
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(

                            alignment: Alignment.centerLeft,
                            height: 35,
                            child: Text('♥(ˆ◡ˆԅ)',style: TextStyle(fontSize: 25),),
                          ), //微信昵称
                          Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('微信号：123456', style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey
                                ),), //微信号
                                Image(image: AssetImage('images/wujiaostart.png'),
                                  width: 15,),
                                Image(image: AssetImage('images/icon_right.png'),
                                  width: 15,), //箭头

                              ],
                            ),
                          ), //账号
                        ],
                      ),
                    ),
                  ), //右边部分,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
