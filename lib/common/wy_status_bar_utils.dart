import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kite/common/wy_device_utils.dart';

class WYStatusBarUtils {
  /// 设置安卓透明状态栏(仅针对安卓)
  static void setAndroidTransparentBar() {
    // 仅针对安卓
    if (WYDeviceUtils.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  /// 获取黑色字体状态栏样式配置，通过AnnotatedRegion使用
  /// 针对未使用baseAppBar的页面
  static SystemUiOverlayStyle getBlackStatusBarStyle([bool isDark = false]) {
    return getStatusBarStyle(isDark: isDark, brightness: Brightness.dark);
  }

  /// 获取状态栏样式配置(安卓iOS通用)，在baseAppBar中使用
  /// brightness：light:白色字体+白色图标 dark:黑色字体+黑色图标 （已在内部对iOS的取反进行处理）
  static SystemUiOverlayStyle getStatusBarStyle({bool isDark = false, Brightness brightness = Brightness.light}) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // 设置顶部状态栏亮度 (Android SDK >= M), light:白色字体+白色图标 dark:黑色字体+黑色图标
      // 暗黑模式优先级高于设置的brightness
      statusBarIconBrightness: isDark ? Brightness.light : brightness,
      // 设置顶部状态栏亮度 (仅用于iOS)
      // iOS和安卓相反，dark:白色字体+白色图标 light:黑色字体+黑色图标
      statusBarBrightness:
      isDark ? Brightness.dark : (brightness == Brightness.light ? Brightness.dark : Brightness.light),
    );
    return systemUiOverlayStyle;
  }

  /// 设置setSystemNavigationBarStyle样式
  /// 单页面设置时，全局build时下个页面有可能会把上个页面的覆盖，配置一样不影响
  /// 或者在main那里统一设置
  static void setSystemNavigationBarStyle([bool isDark = false]) {
    /// 仅针对安卓
    if (WYDeviceUtils.isAndroid) {
      final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        // 设置顶部状态栏背景色 (Android SDK >=O )
        statusBarColor: Colors.transparent,
        // 设置底部状态栏(虚拟按键)背景颜色 (Android SDK >=O )
        systemNavigationBarColor: isDark ? Colors.black : Colors.white,
        // 设置底部状态栏(虚拟按键)亮度 (Android SDK >=O ), dark效果不明显，设置为light即可
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      );
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      });
    }
  }
}
