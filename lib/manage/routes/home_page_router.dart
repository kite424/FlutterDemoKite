import 'package:fluro/fluro.dart';
import 'package:flutter_kite/manage/routes/router_init.dart';
import 'package:flutter_kite/project/find/find.dart';
import 'package:flutter_kite/project/message/message.dart';
import 'package:flutter_kite/project/mine/mine.dart';
import 'package:flutter_kite/project/small_world/small_world.dart';

class HomePageRouter implements IRouterProvider{

  ///发现页面
  static String pMessagePage = '/messagePage';
  ///小世界页面
  static String pSmallWorldPage = '/smallWorldPage';
  ///发现页面
  static String pFindPage = '/findPage';
  ///我的页面
  static String pMinePage = '/minePage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pMessagePage, handler: Handler(handlerFunc: (_, __) => const Message()));
    router.define(pSmallWorldPage, handler: Handler(handlerFunc: (_,__) => const SmallWorld()));
    router.define(pFindPage, handler: Handler(handlerFunc: (_,__) => const Find()));
    router.define(pMinePage, handler: Handler(handlerFunc: (_,__) => const Mine()));


  }

}