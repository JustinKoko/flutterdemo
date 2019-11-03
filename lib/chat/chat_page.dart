import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wechat_demo/chat/chat_model.dart';
import 'package:wechat_demo/chat/search_page.dart';
import 'package:wechat_demo/const.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}
/**
 *
 * 混入(Mixins)
 *
 * */

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  List<ChatModel> _datas = [];

  bool _cancelConnect = false; // 多次请求
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 处理网络请求回调的结果
    getDatas()
        .then((List<ChatModel> datas) {
      if (!_cancelConnect) {
        setState(() {
          _datas = datas;
        });
      }
    })
        .catchError((e) {
      print(e);
    })
        .whenComplete(() {
      print('完毕');
    })
        .timeout(Duration(seconds: 6))
        .catchError((timeout) {
      _cancelConnect = true;
      print(timeout);
    });
  }

// 网络请求

  Future<List<ChatModel>> getDatas() async {
    _cancelConnect = false;

    final response = await http
        .get('http://rap2api.taobao.org/app/mock/235241/api/chat/list');
    if (response.statusCode == 200) {
      // 获取响应数据,并成功转换为 map 类型
      final responseBody = json.decode(response.body);

//    List<ChatModel> chatList = List();
//    List datas = responseBody['chatList'];
//    for (int i = 0; i < datas.length; i++) {
//      chatList.add(ChatModel.formJson(datas[i]));
//    }
      List<ChatModel> chatList = responseBody['chatList']
          .map<ChatModel>((item) => ChatModel.formJson(item))
          .toList();
      return chatList;
    } else {
      throw Exception('statusCode:$response.statusCode');
    }
  }

  // 赋值 cell
  Widget _itemForRow(BuildContext context, int row) {

    if (row == 0) {
      return Container(
            height: 60,
            padding: EdgeInsets.all(10),
            color: themColor,
            child:GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> SearchPage(datas: _datas,)));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('images/放大镜w.png'), color: Colors.grey, width: 20,),
                    Text(' 搜索', style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),
          );
    } else {
      return ListTile(
        title: Text(_datas[row - 1].name),
        subtitle: Container(
          height: 20,
          width: 20,
          child: Text(
            _datas[row - 1].message,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(_datas[row - 1].imageUrl),
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '微信',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: themColor,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                offset: Offset(0, 60),
                color: Colors.black,
                child: Image(
                  image: AssetImage('images/圆加.png'),
                  width: 25,
                ),
                itemBuilder: _buildPopMenuItem),
          )
        ],
      ),
      body: Container(
          child: _datas.length == 0
              ? Center(child: Text('loading...'))
              : ListView.builder(
              itemCount: _datas.length + 1, itemBuilder: _itemForRow)),
    );
  }
}

// 创建一个下拉菜单

List<PopupMenuItem<String>> _buildPopMenuItem(BuildContext context) {
  return <PopupMenuItem<String>>[
    _itemBuilder('images/发起群聊.png', '发起群聊'),
    _itemBuilder('images/添加朋友.png', '添加朋友'),
    _itemBuilder('images/扫一扫(1).png', '扫一扫'),
    _itemBuilder('images/收付款.png', '收付款'),
  ];
}

PopupMenuItem<String> _itemBuilder(String imageAsset, String title) {
  return PopupMenuItem<String>(
    child: Row(
      children: <Widget>[
        Image(
          image: AssetImage(imageAsset),
          width: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    ),
  );
}
