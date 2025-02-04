import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwfiedvalue/vwfieldvalue.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/formadminpage/formparamrowviewer.dart';
import 'package:nodelistview/modules/nodelistview/nodelistview.dart';
import 'package:uuid/uuid.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwform/vwform.dart';
import 'package:vwnodestoreonhive/vwnodestoreonhive/vwnodestoreonhive.dart';
import 'package:vwutil/modules/util/vwdateutil.dart';

class FormAdminPage extends StatelessWidget {
  FormAdminPage(
      {
    required this.appInstanceParam,
    required this.baseUrl
});

 final VwAppInstanceParam appInstanceParam;
 final String baseUrl;


  Widget nodeRowViewer(
      {required VwNode renderedNode,
        required BuildContext context,
        required int index,
        Widget? topRowWidget,
        String? highlightedText,
        RefreshDataOnParentFunction? refreshDataOnParentFunction,
        CommandToParentFunction? commandToParentFunction
      }) {
    return FormParamRowViewer(appInstanceParam: this.appInstanceParam,
        rowNode: renderedNode, highlightedText: highlightedText);
  }

  Widget uploadIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cloud_upload),
      tooltip: 'Uploading Data...',
      onPressed: () async {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Uploading Data...')));

        await VwNodeStoreOnHive(
          unsyncedRecordFieldname: this.appInstanceParam.baseAppConfig.generalConfig.unsyncedRecordFieldname,
          loggedInUser: this.appInstanceParam.baseAppConfig.generalConfig.loggedInUser,
          appTitle: this.appInstanceParam.baseAppConfig.generalConfig.appTitle,
          appversion: this.appInstanceParam.baseAppConfig.generalConfig.appVersion,
            baseUrl: this.appInstanceParam.baseAppConfig.generalConfig.baseUrl,
            //graphqlServerAddress: this.appInstanceParam.baseAppConfig.generalConfig.graphqlServerAddress,
            boxName: this.appInstanceParam.baseAppConfig.generalConfig.unsyncedRecordFieldname)
            .syncToServer(loginSessionId: this.appInstanceParam.loginResponse!.loginSessionId!);
      },
    );
  }



  void modifyParamFunction(VwRowData apiCallParam) {}

  @override
  Widget build(BuildContext context) {
    final VwRowData apiCallParam = VwRowData(timestamp: VwDateUtil .nowTimestamp(),recordId: Uuid().v4(),fields: <VwFieldValue>[
      VwFieldValue(fieldName: "nodeId",valueString: "b4197b56-8421-416c-a304-85a472be122e"),
      VwFieldValue(fieldName: "depth",valueNumber: 1),
      VwFieldValue(fieldName: "depth1FilterObject",valueTypeId: VwFieldValue.vatObject,value: {"content.contentContext.contentClassName":"VwFormParam"})
    ]);
    
    return NodeListView(
      mainLogoImageAsset: this.appInstanceParam.baseAppConfig.generalConfig.mainLogoPath,
  appInstanceParam: appInstanceParam,

        apiCallId: "getNodes",
        nodeRowViewerFunction: nodeRowViewer,
        apiCallParam: apiCallParam,


        );
  }
}
