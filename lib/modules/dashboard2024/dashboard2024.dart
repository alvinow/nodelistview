import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_fade/image_fade.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';


class Dashboard2024 extends StatelessWidget{
  Dashboard2024({
    required this.appInstanceParam
});

  final VwAppInstanceParam appInstanceParam;

  Widget dashboardPicture(){
    return Expanded(child:ImageFade(image:AssetImage(
        "assets/image/dashboard_2024.jpg"
    )));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
        color: Colors.white,
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(children:[Container(margin: EdgeInsets.all(10), height: 50,child: Image.asset(this.appInstanceParam.baseAppConfig.generalConfig.mainLogoPath),),Text(
        "SIM Tindak Lanjut Audit 2024",style: TextStyle(fontSize: 20),
      )]),

      Container(margin: EdgeInsets.all(5), child:this.dashboardPicture())
    ],)));

  }
}