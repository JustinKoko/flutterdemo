import 'package:flutter/material.dart';
import 'package:wechat_demo/discover/discover_cell.dart';
import 'package:wechat_demo/mine/mine_head.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  Color _themColor = Color.fromRGBO(231, 231, 231, 1.0);


  Widget _mineCell(BuildContext context, int row) {
    return Container(
      child: DiscoverCell(title: '支付', imageName: 'images/wechat_pay.png'),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: _themColor,
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
                Container(
                  margin: EdgeInsets.only(top: 55, left: MediaQuery.of(context).size.width - 35,),
                  child: Image(image: AssetImage('images/carmera.png'), width: 20,),
                ),
              ],
            )));
  }
}
