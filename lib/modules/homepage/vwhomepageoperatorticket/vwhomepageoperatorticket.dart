import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/dashboard2024/dashboard2024.dart';
import 'package:nodelistview/modules/homepage/vwhomepagebase/vwhomepagebase.dart';
import 'package:nodelistview/modules/homepage/vwhometabitem/vwhometabitem.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwcardparameter/vwcardparameter.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';
import 'package:vwform/modules/vwwidget/vwlhppage/vwlhppage.dart';
import 'package:vwform/modules/vwwidget/vwoperatorticketpage/modules/vwoperatorticketpagedefinition/vwoperatorticketpagedefinition.dart';
import 'package:vwform/modules/vwwidget/vwoperatorticketpage/vwdashboardoperatorticketpage.dart';
import 'package:vwform/modules/vwwidget/vwoperatorticketpage/vwtodolistoperatorticketpage.dart';


class VwHomePageOperatorTicket extends StatelessWidget {
  VwHomePageOperatorTicket({
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
    homeTabItemList.add(createToDoListOperatorTicketHomeTabItem());
    homeTabItemList.add(createMonitoringOperatorTicketHomeTabItem());
    homeTabItemList.add(createDashboardOperatorTicketHomeTabItem(
        appInstanceParam: this.appInstanceParam));
  }

  VwHomeTabItem createMonitoringOperatorTicketHomeTabItem() {
    return VwHomePageBase.createFolderNodeHomeTabItem(
        selectedIcon: Icons.history,
        unselectedIcon: Icons.history_outlined,
        selectedCaption: "Monitor",
        unselectedCaption: "Monitor",
        rootFolderNodeId: "response_vwticket",
        rootFolderDisplayName: "Monitoring Tiket",
        appInstanceParam: this.appInstanceParam,
        formResponseUserPageKey: UniqueKey());
  }

  static VwHomeTabItem createLHPDashboardTabItem(
      {required VwAppInstanceParam appInstanceParam}) {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.dashboard,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'Dashboard',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'Dashboard',
        ),
        tabPage: Dashboard2024(
          appInstanceParam: appInstanceParam,
        ) );
  }

  static VwHomeTabItem createLHPHomeTabItem(
      {required VwAppInstanceParam appInstanceParam}) {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.checklist,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'LHP',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.checklist,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'LHP',
        ),
        tabPage: VwLhpPage (appInstanceParam:appInstanceParam) );
  }

  static VwHomeTabItem createDashboardOperatorTicketHomeTabItem(
      {required VwAppInstanceParam appInstanceParam}) {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.area_chart_rounded,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'Dashboard',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.area_chart_outlined,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'Dashboard',
        ),
        tabPage: VwDashboardOperatorTicketPage (appInstanceParam:appInstanceParam) );
  }

   VwHomeTabItem createToDoListOperatorTicketHomeTabItem() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(
            Icons.fact_check,
            size: VwHomePageOperatorTicket.iconSize,
          ),
          label: 'To Do',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.fact_check_outlined,
              size: VwHomePageOperatorTicket.iconSize),
          label: 'To Do',
        ),
        tabPage: VwToDoListOperatorTicketPage(
          operatorTicketPageDefinition: VwOperatorTicketPageDefinition(
              possibleInitiatorRowCardParameter: VwCardParameter(
                  titleFieldName: "name",
                  subTitleFieldName: "ticketDefinition",
                  subtitleSubFieldName: "name",
                  isShowDate: false,
                  cardStyle: VwCardParameter.csTwoColumn,
                  isShowSubtitle: true,
                  iconHexCode: "0xe0a6"),
              possibleResponderRowCardParameter:
                  VwCardParameter(titleFieldName: "name")),
          key: UniqueKey(),
          appInstanceParam: appInstanceParam,
        ));
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
