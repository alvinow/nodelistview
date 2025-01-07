import 'package:flutter/cupertino.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/homepage/vwhomepagebase/vwhomepagebase.dart';
import 'package:nodelistview/modules/homepage/vwhomepageoperatorticket/vwhomepageoperatorticket.dart';
import 'package:nodelistview/modules/homepage/vwhometabitem/vwhometabitem.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';

class VwHomePageAdminTicket extends StatelessWidget {
  VwHomePageAdminTicket({
    super.key,
    required this.appInstanceParam,
    this.initialIndex = 0,
    this.formResponse,
    this.formDefinition,
    this.containerFolderNode,
  }) {
    this.homeTabItemList = [];
    this.createHomeTabItemList();
  }

  final VwAppInstanceParam appInstanceParam;
  final int initialIndex;
  final VwRowData? formResponse;
  final VwFormDefinition? formDefinition;
  final VwNode? containerFolderNode;
  late List<VwHomeTabItem> homeTabItemList;
  static double iconSize = 26;

  void createHomeTabItemList() {

    homeTabItemList.add(
        VwHomePageOperatorTicket.createLHPDashboardTabItem(
            appInstanceParam: this.appInstanceParam));
    homeTabItemList.add(
        VwHomePageOperatorTicket.createLHPHomeTabItem(
            appInstanceParam: this.appInstanceParam));
    homeTabItemList.add(VwHomePageBase.createRootPage(
      title: "/data",
        appInstanceParam: this.appInstanceParam));
  }

  @override
  Widget build(BuildContext context) {

    return VwHomePageBase(
        key: this.key,
        appInstanceParam: this.appInstanceParam,
        homeTabItemList: this.homeTabItemList,
        initialIndex: this.initialIndex,
        formResponse: this.formResponse,
        formDefinition: this.formDefinition,
        containerFolderNode: this.containerFolderNode);
  }
}
