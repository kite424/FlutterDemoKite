
import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_kite/manage/routes/router_init.dart';
import 'package:flutter_kite/test/three_page.dart';
import 'package:flutter_kite/test/two_page.dart';

import 'four_page.dart';
import 'one_page.dart';

class MainRouter implements IRouterProvider{

  static String pOnePage = '/onePage';
  static String pTwoPage = '/twoPage';
  static String pThreePage = '/threePage';
  static String pFourPage = '/fourPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pOnePage, handler: Handler(handlerFunc: (_, __) => const OnePage()));
    router.define(pTwoPage, handler: Handler(handlerFunc: (_, __) => const TwoPage()));
    router.define(pThreePage, handler: Handler(handlerFunc: (_, __) => const ThreePage()));
    router.define(pFourPage, handler: Handler(handlerFunc: (_, __) => const FourPage()));
  }

}