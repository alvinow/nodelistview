import 'package:flutter/cupertino.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/homepage/vwhomepageadminticket/vwhomepageadminticket.dart';
import 'package:nodelistview/modules/homepage/vwhomepageoperatorticket/vwhomepageoperatorticket.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';
import 'package:vwform/modules/vwwidget/fatalerrorpage/fatalerrorpage.dart';

class VwHomePage extends StatelessWidget{

  VwHomePage({
    super.key,
    required this.appInstanceParam,

    this.initialIndex = 0,
    this.formResponse,
    this.formDefinition,
    this.containerFolderNode,
  });

  final VwAppInstanceParam appInstanceParam;
  final int initialIndex;
  final VwRowData ? formResponse;
  final VwFormDefinition ? formDefinition;
  final VwNode ? containerFolderNode;


  @override
  Widget build(BuildContext context) {
    String mainGroupRoleId = this

        .appInstanceParam
        .loginResponse!
        .userInfo!
        .user
        .mainRoleUserGroupId;

    if (mainGroupRoleId == this.appInstanceParam.baseAppConfig.generalConfig.operatorticketUserGroupId)
      {
          return VwHomePageOperatorTicket(appInstanceParam: this.appInstanceParam,initialIndex: this.initialIndex,formResponse: this.formResponse,containerFolderNode: this.containerFolderNode,);
      }
    else if(mainGroupRoleId == this.appInstanceParam.baseAppConfig.generalConfig.appAdminUserMainRole || mainGroupRoleId=="root")
      {
        return VwHomePageAdminTicket(appInstanceParam: this.appInstanceParam,initialIndex: this.initialIndex,formResponse: this.formResponse,containerFolderNode: this.containerFolderNode,);
      }
    else if(mainGroupRoleId == this.appInstanceParam.baseAppConfig.generalConfig.appUserMainRole )
    {
      return VwHomePageAdminTicket(appInstanceParam: this.appInstanceParam,initialIndex: this.initialIndex,formResponse: this.formResponse,containerFolderNode: this.containerFolderNode,);
    }

    else{
      String errorMessage = "Error: Invalid User Role = " +
          mainGroupRoleId.toString() +
          ", please contact the Admininistrator";

      return FatalErrorPage(
        errorMessage: errorMessage,
        appInstanceParam: this.appInstanceParam,
      );
    }
  }
}