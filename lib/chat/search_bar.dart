import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';

class SearchBar extends StatefulWidget {

  final ValueChanged<String> onChanged;

  const SearchBar({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final TextEditingController _controller = TextEditingController();

  bool _showClear = false;

  void _onChange(String str) {
    widget.onChanged(str);
    if (str.length > 0) {
      _showClear = true;
      setState(() {});
    } else {
      _showClear = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          color: themColor,
        ),
        Container(
          padding: EdgeInsets.all(10),
          height: 60,
          color: themColor,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  width: ScreenWidth(context) - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5,),
                      Image(
                        image: AssetImage('images/放大镜w.png'),
                        color: Colors.grey,
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          cursorColor: Colors.green,
                          controller: _controller,
                          onChanged: _onChange,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: '搜索',
                          ),
                        ),
                      ),
                      _showClear ? GestureDetector(
                        onTap: () {
                          _controller.clear();
                          _onChange('');
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.cancel,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      )
                          : Container(
                        width: 0,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('取消');
                  Navigator.pop(context);
                },
                child: Text(
                  '  取消',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
