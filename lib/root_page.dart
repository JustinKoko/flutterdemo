import 'package:flutter/material.dart';
import 'package:wechat_demo/chat/chat_page.dart';
import 'package:wechat_demo/discover/discover_page.dart';
import 'package:wechat_demo/friends/friends_page.dart';
import 'package:wechat_demo/mine/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> pages = [
    ChatPage(),
    FriendsPage(),
    DiscoverPages(),
    MinePage(),
  ];

  int currentCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            currentCount = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          currentIndex: currentCount,
          selectedFontSize: 12,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_chat.png'),
                  height: 20,
                  width: 20,
                ),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_chat_hl.png'),
                  width: 20,
                  height: 20,
                ),
                title: Text('微信')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_friends.png'),
                  width: 20,
                  height: 20,
                ),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_friends_hl.png'),
                  width: 20,
                  height: 20,
                ),
                title: Text('通讯录')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_discover.png'),
                  width: 20,
                  height: 20,
                ),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_discover_hl.png'),
                  width: 20,
                  height: 20,
                ),
                title: Text('发现')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/tabbar_mine.png'),
                  width: 20,
                  height: 20,
                ),
                activeIcon: Image(
                  image: AssetImage('images/tabbar_mine_hl.png'),
                  width: 20,
                  height: 20,
                ),
                title: Text('我')),
          ],
        ),
        body: pages[currentCount],
      ),
    );
  }
}
