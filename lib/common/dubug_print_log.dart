// 可以在utils定义log.dart
import 'package:flutter/foundation.dart';

void printLog(Object message,StackTrace current) {
  if(kDebugMode){
    WYCustomTrace programInfo = WYCustomTrace(current);
    print("文件: ${programInfo.fileName}, 行: ${programInfo.lineNumber}, 打印信息: $message");
  }
}

class WYCustomTrace {
  final StackTrace _trace;
  String? fileName;
  int? lineNumber;
  int? columnNumber;

  WYCustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    fileName = listOfInfos[0];
    lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);
  }
}