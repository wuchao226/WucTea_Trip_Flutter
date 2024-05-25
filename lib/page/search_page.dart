import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/search_dao.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/logger_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';
import 'package:trip_flutter/widget/search_item_widget.dart';

///搜索页面
class SearchPage extends StatefulWidget {
  ///是否隐藏左侧返回键
  final bool? hideLeft;
  final String? keyword;
  final String? hint;

  const SearchPage({
    super.key,
    this.hideLeft = false,
    this.keyword,
    this.hint,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;

  @override
  void initState() {
    super.initState();
    if (widget.keyword != null) {
      _onTextChange(widget.keyword!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          _listView,
        ],
      ),
    );
  }

  get _appBar {
    //获取刘海屏Top安全边距
    double top = MediaQuery.of(context).padding.top;
    return shadowWrap(
      child: Container(
        padding: EdgeInsets.only(top: top),
        height: 55 + top,
        decoration: const BoxDecoration(color: Colors.white),
        child: SearchBarWidget(
          hideLeft: widget.hideLeft,
          hint: widget.hint,
          defaultText: widget.keyword,
          leftButtonClick: () => NavigatorUtil.pop(context),
          rightButtonClick: () {
            //收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onChange: _onTextChange,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 5),
    );
  }

  get _listView => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Expanded(
          child: ListView.builder(
            itemCount: searchModel?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _item(index);
            },
          ),
        ),
      );

  void _onTextChange(String value) async {
    try {
      var result = await SearchDao.fetch(value);
      if (result == null) {
        return;
      }
      //只有当，当前输入的内容和服务端返回的内容一致的时候才渲染
      if (result.keyword == value) {
        setState(() {
          searchModel = result;
        });
      }
    } catch (e) {
      LoggerUtil.e(e);
    }
  }

  _item(int index) {
    var item = searchModel?.data?[index];
    if (item == null || searchModel == null) {
      return Container();
    }
    return SearchItemWidget(searchModel: searchModel!, searchItem: item);
  }
}
