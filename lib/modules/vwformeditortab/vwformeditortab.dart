import 'package:flutter/material.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwdataformattimestamp/vwdataformattimestamp.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwfiedvalue/vwfieldvalue.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnoderequestresponse/vwnoderequestresponse.dart';
import 'package:matrixclient2base/modules/base/vwrenderednodepackage/vwrenderednodepackage.dart';
import 'package:nodelistview/modules/vwformeditortab/vwformparamsettingspage/vwformparamsettingspage.dart';
import 'package:uuid/uuid.dart';
import 'package:vwform/modules/remoteapi/remote_api.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefintionutil.dart';
import 'package:vwform/modules/vwformpage/vwdefaultformpage.dart';
import 'package:vwform/modules/vwwidget/vwformresponseviewer/vwformresponseviewer.dart';
import 'package:vwform/modules/vwwidget/vwloadingpage2/vwloadingpage2.dart';
import 'package:vwutil/modules/util/vwdateutil.dart';

class VwFormEditorTab extends StatefulWidget {
  VwFormEditorTab({required this.appInstanceParam, required this.formParam,
    this.initDataMode=1,
    this.initDataViewMode=0,
    super.key});
  final VwAppInstanceParam appInstanceParam;
  final VwFormDefinition formParam;
  final int initDataMode; //0:data sucessfully loaded,  1: async loading by formResponseId, 2: async saving by formResponseId
  final int initDataViewMode; // 0:edit , 1:read Only

  _VwFormEditorTabState createState() => _VwFormEditorTabState();
}

class _VwFormEditorTabState extends State<VwFormEditorTab> {
  late int _selectedIndex;
  late int currentDataMode;
  late int currentDataViewMode;
  late VwFormDefinition currentFormParam;
  late VwRenderedNodePackage renderedNodePackage;

  @override
  void initState() {
    super.initState();
    renderedNodePackage=VwRenderedNodePackage(recordId: Uuid().v4(), timestamp: VwDataFormatTimestamp(created: DateTime.now(), updated: DateTime.now()));
    this.currentDataMode=widget.initDataMode;
    this.currentDataViewMode=widget.initDataViewMode;
    this.currentFormParam=widget.formParam;
    this._selectedIndex = 0;
    _refreshFormResponseId();
  }

  void _refreshFormResponseId(){
    //this.widget.formParam.response.recordId=Uuid().v4();
  }

  void _onItemTapped(int index) {
    _refreshFormResponseId();

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBodyAfterSuccesfullyLoadedData(BuildContext context,VwRenderedNodePackage renderedNodePackage){
    const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



    List<Widget> _widgetOptions = <Widget>[
      VwFormPage(
          formDefinitionFolderNodeId: this.widget.appInstanceParam.baseAppConfig.generalConfig.formDefinitionFolderNodeId,
         appInstanceParam: widget.appInstanceParam,
          formDefinition: this.widget.formParam,
          formResponse: VwFormDefinitionUtil.createBlankRowDataFromFormDefinition(formDefinition: this.widget.formParam, ownerUserId: widget.appInstanceParam.loginResponse!.userInfo!.user.recordId),
         ),
      VwFormResponseViewer(appInstanceParam: this.widget.appInstanceParam, formResponsesNode: renderedNodePackage, formParam: this.widget.formParam),
      VwFormParamSettingsPage(formParam: this.widget.formParam,),
    ];

    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(

      items: <BottomNavigationBarItem>[
        this._selectedIndex == 0
            ? BottomNavigationBarItem(
          icon: Icon(Icons.list_sharp),
          label: 'Pertanyaan',
        )
            : BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Pertanyaan',
        ),
        this._selectedIndex == 1
            ? BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Respon',
        )
            : BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: 'Respon',
        ),
        this._selectedIndex == 2
            ? BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications_sharp),
          label: 'Pengaturan',
        )
            : BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Pengaturan',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );

    Widget body1 = Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    );

    return Scaffold(bottomNavigationBar: bottomNavigationBar, body: body1);
  }

  @override
  Widget build(BuildContext context) {
    if (this.currentDataMode == 0) {
      return _buildBodyAfterSuccesfullyLoadedData(context,this.renderedNodePackage);
    } else if (this.currentDataMode == 1) {
      return FutureBuilder<VwRenderedNodePackage>(
          future: _asyncLoadNodes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(this.currentDataMode == 0) {
                return _buildBodyAfterSuccesfullyLoadedData(context,this.renderedNodePackage);
              }
              else{
                return VwLoadingPage2(caption: "Terjadi kesalahan memuat data...");
              }
            } else {
              return VwLoadingPage2(caption: "Memuat data dariserver...");
            }
          });
    } else {
      return Text("Error on State");
    }
  }

  Future<VwRenderedNodePackage> _asyncLoadNodes() async {
    VwRenderedNodePackage returnValue = this.renderedNodePackage;
    try
    {
      final VwRowData apiCallParam = VwRowData(timestamp: VwDateUtil.nowTimestamp(),recordId: Uuid().v4(),fields: <VwFieldValue>[
        VwFieldValue(fieldName: "nodeId",valueString: this.widget.appInstanceParam.baseAppConfig.generalConfig.formDefinitionFolderNodeId),
        VwFieldValue(fieldName: "depth",valueNumber: 1),
        VwFieldValue(fieldName: "depth1FilterObject",valueTypeId: VwFieldValue.vatObject,value: {"content.contentContext.contentClassName":"VwFormResponse","content.contentContext.contentRefClassName":"VwFormParam","content.contentContext.contentRefClassInstanceId":this.currentFormParam.recordId})
      ]);

      VwNodeRequestResponse nodeRequestResponse= await RemoteApi.nodeRequestApiCall(
          baseUrl: this.widget.appInstanceParam.baseUrl,
          graphqlServerAddress: this.widget.appInstanceParam.baseAppConfig.generalConfig.graphqlServerAddress,
          apiCallId: "getNodes", apiCallParam: apiCallParam, loginSessionId: widget.appInstanceParam.loginResponse!.loginSessionId!);

      if(nodeRequestResponse.renderedNodePackage!=null)
        {
          this.currentDataMode = 0;
          this.renderedNodePackage=nodeRequestResponse.renderedNodePackage!;
          returnValue=nodeRequestResponse.renderedNodePackage!;
        }
    }
    catch(error)
    {
      print("Error catched on _asyncLoadNodes():"+error.toString());
    }


    return returnValue;
  }


}
