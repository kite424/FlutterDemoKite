import 'package:flutter/material.dart';
import 'package:flutter_kite/tool/strings.dart';
import 'package:flutter_kite/widget/nav_appbar.dart';

import '../../../tool/kcolors.dart';

class HomeMessagePage extends StatelessWidget {
  const HomeMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        KStrings.homeMessageTitle,
        leftWidget: Container(),
      ),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }


 Widget _body(){
    return Container();
  }
}
