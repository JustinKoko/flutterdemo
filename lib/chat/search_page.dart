import 'package:flutter/material.dart';
import 'package:wechat_demo/chat/chat_model.dart';
import 'package:wechat_demo/chat/search_bar.dart';

class SearchPage extends StatefulWidget {
  final List<ChatModel> datas;

  const SearchPage({Key key, this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ChatModel> _models = [];
  String _searchStr = '';

  void _searchData(String text) {
    if (text.length == 0) {
      _models = [];
    } else {
      _models.clear();
      for (int i = 0; i < widget.datas.length; i++) {
        if (widget.datas[i].name.contains(text)) {
          _models.add(widget.datas[i]);
        }
      }
    }
    _searchStr = text;
    setState(() {});
  }

  Widget _richText(String name) {
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle highStyle = TextStyle(fontSize: 20, color: Colors.green);

    List<TextSpan> spans = [];

    List<String> strs = name.split(_searchStr);

    for (int i = 0; i < strs.length; i++) {
      String str = strs[i];
      if (str == '' && i < strs.length - 1) {
        spans.add(TextSpan(text: _searchStr, style: highStyle));
      } else {
        spans.add(TextSpan(text: str, style: normalStyle));
        if (i < strs.length - 1) {
          spans.add(TextSpan(text: _searchStr, style: highStyle));
        }
      }
    }
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _itemForRow(BuildContext context, int row) {
    return ListTile(
      title: _richText(_models[row].name),
      subtitle: Container(
        height: 20,
        width: 20,
        child: Text(
          _models[row].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_models[row].imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChanged: (String str) {
              _searchData(str);
            },
          ),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (ScrollNotification note){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView.builder(
                  itemCount: _models.length,
                  itemBuilder: _itemForRow,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
