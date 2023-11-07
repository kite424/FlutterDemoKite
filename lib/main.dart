import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kite/common/wy_device_utils.dart';
import 'package:flutter_kite/common/wy_screen_utils.dart';
import 'package:flutter_kite/common/wy_status_bar_utils.dart';
import 'package:flutter_kite/manage/routes/routes.dart';
import 'package:flutter_kite/manage/tabbar/base_tabbar.dart';
import 'package:flutter_kite/tool/kcolors.dart';
import 'package:flutter_kite/tool/strings.dart';
import 'package:flutter_kite/widget/nav_appbar.dart';
import 'package:flutter_kite/widget/router_notfound_page_404.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/dubug_print_log.dart';
import 'manage/provider/theme_provider.dart';
import 'manage/routes/app_route_observer.dart';

Future<void> main() async {
  /// 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  /// sp初始化
  await SpUtil.getInstance();
  runApp(const MyApp());
  if (WYDeviceUtils.isAndroid) {
    printLog("Android",StackTrace.current);
  } else if (WYDeviceUtils.isIOS) {
    printLog("iOS",StackTrace.current);
  } else if (WYDeviceUtils.isWeb) {
    printLog("Web",StackTrace.current);
  }

  // 设置安卓透明状态栏
  WYStatusBarUtils.setAndroidTransparentBar();


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    final Widget app = MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (_, ThemeProvider provider, __) {
            return _buildMaterialApp(provider);
          },
        ));

    return app;

  }
  Widget _buildMaterialApp(ThemeProvider provider) {
    // 警告:不要随意调整调用BotToastInit函数的位置111222
    return MaterialApp(
      // 多主题切换
      theme: provider.getThemeData(),
      navigatorKey: KStrings.navigatorKey,
      darkTheme: provider.getThemeData(isDarkMode: true),
      themeMode: provider.getThemeMode(),
      home: BaseTabBar(),
      //路由
      onGenerateRoute: Routes.router.generator,
      onUnknownRoute: (RouteSettings setting)=>MaterialPageRoute(builder: (context)=>const NotFoundPage("未知页面")),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FallbackCupertinoLocalisationsDelegate()
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      builder: (BuildContext context, Widget? child) {

        ///屏幕工具初始化
        WYScreenUtils.init(context);

        if (WYDeviceUtils.isAndroid) {
          /// 设置安卓底部虚拟按键颜色
          WYStatusBarUtils.setSystemNavigationBarStyle(provider.isDark(context));
        }

        /// 保证文字大小不受手机系统设置影响
        child = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );

        return child;
    },
     // 2.注册路由观察者
      navigatorObservers: [AppRouteObserver().routeObserver],

    );

  }

}
class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) => DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}