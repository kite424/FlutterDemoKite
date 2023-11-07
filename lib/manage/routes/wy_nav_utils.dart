
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kite/manage/routes/routes.dart';

import '../../common/dubug_print_log.dart';

enum JumpType{
  native,
  nativeModal,
  left,
  bottom,
  fadeIn,
}


class WYNavUtils{
  ///跳转
  static void pushNamed(BuildContext context, String routeName, {Object? arguments, transition = JumpType.native}){
    var path = routeName;
    // 对象或对象数组传值可以通过arguments字段进行传值，然后在router.define那里处理、设置页面接收
    if(arguments !=null){
      String jsonStr = Uri.encodeComponent(jsonEncode(arguments));
      path = "$routeName?jumpParams=$jsonStr";
    }
    TransitionType type = TransitionType.native;
    if (transition == JumpType.nativeModal) {
      type = TransitionType.nativeModal;
    }
    if (transition == JumpType.left) {
      type = TransitionType.inFromRight;
    }
    if (transition == JumpType.bottom) {
      type = TransitionType.inFromBottom;
    }
    if (transition == JumpType.fadeIn) {
      type = TransitionType.fadeIn;
    }


  }


}

/// fluro的路由跳转工具类
class _NavFluroUtils{
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, transition = TransitionType.native}){
    unFocus();
    Routes.router.navigateTo(context, path,replace: replace,clearStack: clearStack,transition: transition);
  }

  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}){
    unFocus();
    Routes.router.navigateTo(context, path,replace: replace,clearStack: clearStack,transition: TransitionType.native).then((Object? result) {
      // 页面返回result为null
      if(result == null){
        return;
      }
      function(result);
    }).catchError((dynamic error){
      printLog("_NavFluroUtils-pushResult-error:$error",StackTrace.current);
    });
  }
  static void goBack(BuildContext context){
    unFocus();
    Navigator.pop(context);
  }
  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unFocus();
    Navigator.pop<Object>(context, result);
  }

  /// 跳到WebView页
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.pWebViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unFocus() {
    /// 使用下面的方式，会触发不必要的build。
    /// FocusScope.of(context).unFocus();
    /// https://blog.csdn.net/iotjin
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
/*

// 跳转传值

var jumpParams = {'a': 123};
var jumpParams2 = [{'a': 123},{'b': 456}];
JhNavUtils.pushNamed(context, 'TestPage', arguments: jumpParams2);

router.define('TestPage', handler: Handler(handlerFunc: (_, params) {
  var jumpParams = params['jumpParams']!.first;
  return TestPage(jsonDecode(jumpParams));
}));

const TestPage(this.jumpParams, {Key? key}) : super(key: key);
final dynamic jumpParams;


// 跳转传值带回调刷新

var params = dataArr[index];
JhNavUtils.pushNamedResult(context, 'TestPage', params, (returnData) {
  if (returnData['isRefresh'] == true) {
    requestData();
  }
});

JhNavUtils.goBackWithParams(context, {'isRefresh': true});

// 多级返回

Navigator.of(context)
  ..pop()
  ..pop();

JhNavUtils.goBack(context);
JhNavUtils.goBack(context);
JhNavUtils.goBackWithParams(context, {'isRefresh': true});

*/

