import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const appbarScrollOffset = 100;
  final bannerList = [
    "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
    "https://o.devio.org/images/fa/cat-4098058__340.webp",
    "https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp",
    "https://o.devio.org/images/other/as-cover.png",
  ];
  double appBarAlpha = 0;

  get _logoutBtn => TextButton(
        onPressed: () {
          LoginDao.logOut();
        },
        child: const Text(
          "登出",
        ),
      );

  get _appBar => Opacity(
        opacity: appBarAlpha,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      );

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          const SizedBox(
            height: 800,
            child: ListTile(
              title: Text('哈哈'),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            // 移除顶部空白
            removeTop: true,
            context: context,
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
          _appBar,
        ],
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
}
