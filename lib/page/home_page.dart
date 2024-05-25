import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/home_dao.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/page/search_page.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/banner_widget.dart';
import 'package:trip_flutter/widget/grid_nav_widget.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/local_nav_widget.dart';
import 'package:trip_flutter/widget/sales_box_widget.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';
import 'package:trip_flutter/widget/sub_nav_widget.dart';

const searchBarDefaultText = '网红打开地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  static Config? configModel;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const appbarScrollOffset = 100;

  /*final bannerList = [
    "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
    "https://o.devio.org/images/fa/cat-4098058__340.webp",
    "https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp",
    "https://o.devio.org/images/other/as-cover.png",
  ];*/
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
  bool _loading = true;

  get _logoutBtn => TextButton(
        onPressed: () {
          LoginDao.logOut();
        },
        child: const Text(
          "登出",
        ),
      );

  get _appBar {
    //获取刘海屏实际的Top 安全边距
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        shadowWrap(
          child: Container(
            padding: EdgeInsets.only(top: top),
            height: 60 + top,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBarWidget(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              defaultText: searchBarDefaultText,
              rightButtonClick: () {
                LoginDao.logOut();
              },
            ),
          ),
        ),
        // bottom line
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        ),
      ],
    );
  }

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          LocalNavWidget(localNavList: localNavList),
          if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
          SubNavWidget(subNavList: subNavList),
          if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!),
        ],
      );

  get _contentView => MediaQuery.removePadding(
        // 移除顶部空白
        removeTop: true,
        context: context,
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _handleRefresh,
          child: NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                ///通过depth来过滤指定widget发出的滚动事件，depth == 0表示最外层的列表发出的滚动事件滚动且是列表滚动的事件
                _onScroll(scrollNotification.metrics.pixels);
              }
              return false;
            },
            child: _listView,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            _contentView,
            _appBar,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll(double offset) {
    print('offset:$offset');
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    print('alpha:$alpha');
    setState(() {
      appBarAlpha = alpha;
    });
    print('appBarAlpha:$appBarAlpha');
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel? homeModel = await HomeDao.fetch();
      if (homeModel == null) {
        setState(() {
          _loading = false;
        });
        return;
      }
      setState(() {
        HomePage.configModel = homeModel.config;
        localNavList = homeModel.localNavList ?? [];
        bannerList = homeModel.bannerList ?? [];
        subNavList = homeModel.subNavList ?? [];
        gridNavModel = homeModel.gridNav;
        salesBoxModel = homeModel.salesBox;
        _loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  void _jumpToSearch() {
    NavigatorUtil.push(context, const SearchPage());
  }
}
