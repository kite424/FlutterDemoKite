import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kite/common/wy_color_utils.dart';
import 'package:flutter_kite/common/wy_screen_utils.dart';


class NotFoundPage extends StatefulWidget {

  final String? placeText;
  const NotFoundPage(this.placeText,{Key? key}) : super(key: key);

  @override
  _NoDataViewState createState() => _NoDataViewState();
}

class _NoDataViewState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: WYScreenUtils.setWidth(750),
        height: double.infinity,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: WYScreenUtils.setWidth(405),
                height: WYScreenUtils.setHeight(281),
                child: Image.asset('assets/images/routes/404_no_page.png.png'),
              ),
              Text(widget.placeText!,style: TextStyle(color: WYColorUtils.hexColor("#82D1FC"),fontSize: WYScreenUtils.setSp(24)),)
            ],
          ),
        )
    );
  }
}
