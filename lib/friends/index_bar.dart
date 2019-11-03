import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';

class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  bool _indicatorHiden = true;
  int _selectIndex = -1; // 用来判断是不是重复回调
  double _indicatorY = 0.0;
  String _indicatorText = 'A'; //前两个字母不滚动

  @override
  Widget build(BuildContext context) {
    List<Widget> _indexWords = [];

    for (int i = 0; i < INDEX_WORDS.length; i++) {
      _indexWords.add(Expanded(
        child: CircleAvatar(
          radius: 10.0,
          backgroundColor:
              _selectIndex == i ? Colors.green : Color.fromRGBO(1, 1, 1, 0.0),
          child: Text(
            INDEX_WORDS[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: _selectIndex == i ? Colors.white : Colors.black,
            ),
          ),
        ),
      ));
    }
    ;
    return Positioned(
        right: 0,
        height: ScreenHeight(context) / 2,
        top: ScreenHeight(context) / 8,
        width: 120,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment(0, _indicatorY),
              width: 100,
//              color: Colors.red,
              child: _indicatorHiden == true
                  ? null
                  : Stack(
                      alignment: Alignment(-0.2, 0),
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/气泡.png'),
                          width: 60,
                        ),
                        Text(
                          _indicatorText,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
            ),
            GestureDetector(
              child: Container(
                width: 20,
                color: Color.fromRGBO(1, 1, 1, 0.0),
                child: Column(
                  children: _indexWords,
                ),
              ),
              //给索引添加手势
              onVerticalDragUpdate: (DragUpdateDetails details) {
                int index = getIndex(context, details.globalPosition);
                if (_selectIndex != index) {
                  _selectIndex = index;
                  widget.indexBarCallBack(INDEX_WORDS[index]);
                }
                _indicatorHiden = false;
                _indicatorText = INDEX_WORDS[index];
                _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
                setState(() {});
              }, //拖拽手势
              onVerticalDragDown: (DragDownDetails details) {
                int index = getIndex(context, details.globalPosition);

                _indicatorHiden = false;
                _indicatorText = INDEX_WORDS[index];
                _indicatorY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
                if (_selectIndex != index) {
                  _selectIndex = index;
                  widget.indexBarCallBack(_indicatorText);
                }
                setState(() {});
              },
              onVerticalDragEnd: (DragEndDetails details) {
                _indicatorHiden = true;
                _selectIndex = -1;
                setState(() {});
              },
            ),
          ],
        ));
  }
}

int getIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject();
  //坐标转换,算出 Y 值
  double y = box.globalToLocal(globalPosition).dy;

  // 每一个 item 的高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);
  return index;
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
