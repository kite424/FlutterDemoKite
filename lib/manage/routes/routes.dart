import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kite/manage/routes/router_init.dart';
import 'package:flutter_kite/manage/tabbar/base_tabbar.dart';
import 'package:flutter_kite/widget/router_notfound_page_404.dart';

import '../../common/dubug_print_log.dart';
import '../../test/main_router.dart';

class Routes{
  static String pHome = '/home';
  static String pWebViewPage = '/webView';
  static String pDemoListPage = 'DemoListPage';


  static final List<IRouterProvider> _listRouter = [];
  static final FluroRouter router = FluroRouter();

  static void initRoutes(){
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params){
      printLog("未找到目标页404",StackTrace.current);
      return const NotFoundPage("未发现目标页");
    });
    router.define(pHome, handler: Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params){
      return const BaseTabBar();
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化

    _listRouter.add(MainRouter());

    /// 初始化路由
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }

    _listRouter.forEach(initRouter);


  }

}