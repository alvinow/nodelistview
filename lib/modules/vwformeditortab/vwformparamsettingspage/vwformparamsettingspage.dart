import 'package:flutter/material.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';


class VwFormParamSettingsPage extends StatefulWidget{
  VwFormParamSettingsPage({
    required this.formParam
});

  final VwFormDefinition formParam;

  _VwFormParamSettingsPageState createState()=>_VwFormParamSettingsPageState();
}

class _VwFormParamSettingsPageState extends State<VwFormParamSettingsPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan Form"),
      ),
      body:Center( child:Text("Pengaturan Form")),
    );
  }
}