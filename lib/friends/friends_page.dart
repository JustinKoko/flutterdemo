import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';
import 'package:wechat_demo/discover/discover_child_page.dart';
import 'package:wechat_demo/friends/friends_data.dart';
import 'package:wechat_demo/friends/index_bar.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin<FriendsPage> {
  ScrollController _scrollController; // 用于界面滚动
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0, // 🔍不滑动
    INDEX_WORDS[1]: 0.0, // ☆不滑动
  };

  final List<Friends> _listData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // 完成一次加载的一般数据,初始化都在这个函数里面完成
    super.initState();
    //联系人数据
    _listData
      ..addAll(FriendsData)
      ..addAll(FriendsData); // 添加数组新数组内相当于两个 listData
    _listData.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter); // 按照首字母排序
    });
    //
    _scrollController = ScrollController();

    var _groupOffset = 60.0 * 4; // 前 4 个不考虑

    for (int i = 0; i < _listData.length; i++) {
      if (i < 1) {
        _groupOffsetMap.addAll({_listData[i].indexLetter: _groupOffset});
        _groupOffset += 90.0;
      } else if (_listData[i].indexLetter == _listData[i - 1].indexLetter) {
        _groupOffset += 60.0;
      } else {
        _groupOffsetMap.addAll({_listData[i].indexLetter: _groupOffset});
        _groupOffset += 90.0;
      }
    }
  }

  // 定义一个数组上半部分
  final List<Friends> _headData = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  // 返回下面列表的 item
  Widget _itemForRow(BuildContext context, int row) {
    if (row < _headData.length) {
      return _FriendsCell(
        name: _headData[row].name,
        imageAsset: _headData[row].imageUrl,
      );
    } else if ((row > _headData.length) &&
        _listData[row - 4].indexLetter == _listData[row - 5].indexLetter) {
      return _FriendsCell(
        name: _listData[row - 4].name,
        imageUrl: _listData[row - 4].imageUrl,
      );
    } else {
      return _FriendsCell(
        name: _listData[row - 4].name,
        imageUrl: _listData[row - 4].imageUrl,
        groupTitle: _listData[row - 4].indexLetter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '通讯录',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: themColor,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverChildPage(
                        title: '添加朋友',
                      )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: ScreenHeight(context),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _headData.length + _listData.length,
                itemBuilder: _itemForRow),
          ),
          IndexBar(
            indexBarCallBack: (String str) {
              print(_groupOffsetMap[str]);
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(
                  _groupOffsetMap[str],
                  duration: Duration(milliseconds: 10),
                  curve: Curves.easeIn,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FriendsCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAsset;

  _FriendsCell({this.imageUrl, this.name, this.imageAsset, this.groupTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0),
      child: Column(
        children: <Widget>[
          Container(
            height: groupTitle != null ? 30 : 0,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            color: themColor,
            child: groupTitle != null
                ? Text(
                    groupTitle,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                : null,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                      image: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageAsset)),
                ),
              ),
              //头像加圆角
              SizedBox(
                width: 10,
              ),
              Container(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      height: 59.5,
                      width: ScreenWidth(context) - 70,
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      height: 0.5,
                      color: themColor,
                      width: ScreenWidth(context) - 70,
                    )
                  ],
                ),
              ), //标题加横线
            ],
          )
        ],
      ),
    );
  }
}
