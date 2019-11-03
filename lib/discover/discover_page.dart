import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/discover/discover_cell.dart';
import 'package:wechat_demo/discover/discover_data.dart';
import 'package:flutter/src/services/asset_bundle.dart';

class DiscoverPages extends StatefulWidget {
  @override
  _DiscoverPagesState createState() => _DiscoverPagesState();
}

class _DiscoverPagesState extends State<DiscoverPages> {
  Color _themColor = themColor;

  Widget _cellForRow(BuildContext context, int row) {
    return Container(
      child: Column(
        children: <Widget>[
          DiscoverCell(
            title: datas[row]['title'],
            imageName: datas[row]['imageName'],
            subTitle: datas[row]['subTitle'],
            subImageName: datas[row]['subImageName'],
          ),
          (row == 0 || row == 2 || row == 4 || row == 5 || row == 7)
              ? SizedBox(height: 10,)
              : Container(
            height: 0.0,
          ),
          (row == 1 || row == 3 || row == 6)
              ? Container(
              height: 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Container(
                        color: _themColor,
                      )),
                ],
              ))
              : Container(
            height: 0.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '发现',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: _themColor,
      ),
      body: Container(
          color: _themColor,
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: _cellForRow,
          )),
    );
  }
}
