import 'package:flutter/material.dart';
import 'package:wechat_demo/discover/discover_cell.dart';
import 'package:wechat_demo/discover/discover_child_page.dart';
import 'package:wechat_demo/mine/mine_head.dart';

import '../const.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  List _mineDatas = [
    {
      'title': '支付',
      'imageName': 'images/wechat_pay.png',
      'subTitle': '',
      'subImageName': ''
    },
    {
      'title': '收藏',
      'imageName': 'images/wechat_collect.png',
      'subTitle': '',
      'subImageName': ''
    },
    {
      'title': '相册',
      'imageName': 'images/wechat_photos.png',
      'subTitle': '',
      'subImageName': ''
    },
    {
      'title': '卡包',
      'imageName': 'images/wechat_cardbag.png',
      'subTitle': '',
      'subImageName': ''
    },
    {
      'title': '表情',
      'imageName': 'images/wechat_face.png',
      'subTitle': '',
      'subImageName': ''
    },
    {
      'title': '设置',
      'imageName': 'images/微信设置.png',
      'subTitle': '',
      'subImageName': ''
    },
  ];

  Widget _mineCell(BuildContext context, int row) {
    return Container(
      child: Column(
        children: <Widget>[
          DiscoverCell(title: _mineDatas[row]['title'], imageName: _mineDatas[row]['imageName']),
          Container(
            height: 0.5,
            child: Row(
              children: <Widget>[
                Container(width: 50, height: 0.5,color: Colors.white,),
                Expanded(child: Container(height: 0.5,))
              ],
            ),
          ),
          (row == 0 || row == 4) ? SizedBox(height: 10,) : SizedBox(height: 0,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themColor,
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      child: MineHead(),
                      color: Colors.white,
                      height: 225,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: _mineCell,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DiscoverChildPage(
                              title: '相机',
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 55,
                      left: MediaQuery.of(context).size.width - 35,
                    ),
                    child: Image(
                      image: AssetImage('images/carmera.png'),
                      width: 20,
                    ),
                  ),
                ), //相机
              ],
            )));
  }
}
