import 'package:flutter/material.dart';
import 'package:wechat_demo/discover/discover_child_page.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String imageName;
  final String subTitle;
  final String subImageName;

  const DiscoverCell(
      {Key key,
      @required this.title,
      @required this.imageName,
      this.subTitle,
      this.subImageName})
      : assert(title != null, 'title 不能为空'),
        assert(imageName != null, 'imageName 不能为空');

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
              title: widget.title,
            )));
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        color: Colors.white,
        height: 60,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage(widget.imageName),
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ))
              ],
            )),
            Container(
              padding: EdgeInsets.only(right: 5),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.subTitle != null ? widget.subTitle : '',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.subImageName != null
                      ? Container(
                          child: Image(
                            image: AssetImage(widget.subImageName),
                            width: 15,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
