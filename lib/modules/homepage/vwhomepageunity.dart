import 'package:flutter/material.dart';
import 'package:matrixclient2base/appconfig.dart';
import 'package:matrixclient2base/modules/base/vwapicall/apivirtualnode/apivirtualnode.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/formadminpage/formadminpage.dart';
import 'package:nodelistview/modules/homepage/vwhometabitem/vwhometabitem.dart';
import 'package:vwform/modules/publiclandingpage/publiclandingpage.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwcardparameter/vwcardparameter.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';
import 'package:vwform/modules/vwwidget/chartnodelistview/chartnodelistview.dart';
import 'package:vwform/modules/vwwidget/fatalerrorpage/fatalerrorpage.dart';
import 'package:vwform/modules/vwwidget/vwformresponseuserpage/vwformresponseuserpage.dart';
import 'package:vwform/modules/vwwidget/vwoperatorticketpage/modules/vwoperatorticketpagedefinition/vwoperatorticketpagedefinition.dart';
import 'package:vwform/modules/vwwidget/vwoperatorticketpage/vwtodolistoperatorticketpage.dart';
import 'package:vwform/modules/vwwidget/vwspecifiedformsubmit/vwspecifiedformsubmit.dart';
import 'package:vwutil/modules/util/nodeutil.dart';

class VwHomePageUnity extends StatefulWidget {
  VwHomePageUnity(
      {super.key,
      required this.appInstanceParam,
      this.initialIndex = 0,
      this.formResponse,
      this.formDefinition,
        required this.baseUrl,
      this.containerFolderNode});

  final VwAppInstanceParam appInstanceParam;
  final int initialIndex;
  final VwRowData? formResponse;
  final VwFormDefinition? formDefinition;
  final VwNode? containerFolderNode;
  final String baseUrl;

  _VwHomePageUnityState createState() => _VwHomePageUnityState();
}

class _VwHomePageUnityState extends State<VwHomePageUnity> {
  late int _selectedIndex;
  late Key formResponseUserPageKey;
  final double iconSize = 26;

  late List<VwHomeTabItem> homeTabItemList;

  @override
  void initState() {
    super.initState();
    this.formResponseUserPageKey = UniqueKey();
    this._selectedIndex = this.widget.initialIndex;
    homeTabItemList = [];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void createHomeTabList() {
    if (this.widget.appInstanceParam.loginResponse != null &&
        this.widget.appInstanceParam.loginResponse!.userInfo != null &&
        this
                .widget
                .appInstanceParam
                .loginResponse!
                .userInfo!
                .user
                .mainRoleUserGroupId !=
            null) {
      String mainGroupRoleId = this
          .widget
          .appInstanceParam
          .loginResponse!
          .userInfo!
          .user
          .mainRoleUserGroupId;

      homeTabItemList.clear();

      if (mainGroupRoleId == "instagramOperator") {
        homeTabItemList.add(createPublicLandingPage(
            selectedIcon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            selectedCaption: "Home",
            unselectedCaption: "Home"));

        homeTabItemList.add(createPublicLandingPage(
            selectedIcon: Icons.explore,
            unselectedIcon: Icons.explore_outlined,
            selectedCaption: "Jelajahi",
            unselectedCaption: "Jelajahi"));
      } else if (mainGroupRoleId == AppConfig.adminticketMainRoleUserGroupId) {
        homeTabItemList.add(createFormResponseUserPage());

        if (widget.appInstanceParam.loginResponse!.userInfo!.user!
                .organizationId ==
            "gsd") {
          homeTabItemList
              .add(this.createCableExtractionChartNodeListViewHomeTabItem());
        } else {
          homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());
        }
      }

      if (mainGroupRoleId == AppConfig .entryDatAdminUserGroupId) {
        homeTabItemList.add(createFormResponseUserPage());

        if (widget.appInstanceParam.loginResponse!.userInfo!.user!
                .organizationId ==
            "psn.gsd") {
          homeTabItemList
              .add(this.createCableExtractionChartNodeListViewHomeTabItem());
        } else {
          homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());
        }
      }

      if (mainGroupRoleId == "ticketgatekeeper") {
        homeTabItemList.add(createFormResponseUserPage());

        if (widget.appInstanceParam.loginResponse!.userInfo!.user!
                .organizationId ==
            "tiket.inovasikolaborasi") {
          homeTabItemList
              .add(this.createCableExtractionChartNodeListViewHomeTabItem());
        } else {
          homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());
        }
      }

      if (mainGroupRoleId == AppConfig.entryDataOperatorUserGroupId) {
        homeTabItemList.add(createFormResponseUserPage());
        if (widget.appInstanceParam.loginResponse!.userInfo!.user!
                .organizationId ==
            "psn.gsd") {
          homeTabItemList.add(
              this.createTicketDefinitionStatChartNodeListViewHomeTabItem());
        } else {
          homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());
        }
      } else if (mainGroupRoleId ==
          AppConfig.adminPauddikdasmenSpiUserGroupRecordId) {
        homeTabItemList.add(createFormAdmin());
        homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());

      } else if (mainGroupRoleId == AppConfig.operatorticketUserGroupId) {
        homeTabItemList.add(createToDoListOperatorTicketHomeTabItem());
        homeTabItemList.add(createMonitoringOperatorTicketHomeTabItem());
        homeTabItemList.add(createDashboardOperatorTicketHomeTabItem());
      }
    }
  }

  VwHomeTabItem createMonitoringOperatorTicketHomeTabItem(){
    return createFolderNodeHomeTabItem(
        selectedIcon: Icons.history,
        unselectedIcon: Icons.history_outlined,
        selectedCaption: "Monitor",
        unselectedCaption: "Monitor",
        rootFolderNodeId: "response_vwticket",
        rootFolderDisplayName: "Monitoring Tiket");
  }

  VwHomeTabItem createToDoListOperatorTicketHomeTabItem() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(
            Icons.fact_check,
            size: this.iconSize,
          ),
          label: 'To Do',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.fact_check_outlined, size: this.iconSize),
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
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createUserHomeNodeFolderHomeTabItem() {
    VwNode? homeFolderNode;
    if (widget.appInstanceParam.loginResponse != null &&
        widget.appInstanceParam.loginResponse!.homeLinkNode != null) {
      homeFolderNode = NodeUtil.extractNodeFromLinkNode(
          widget.appInstanceParam.loginResponse!.homeLinkNode!);
    }

    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.folder_shared_rounded, size: this.iconSize),
          label: 'Home',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.folder_shared_outlined, size: this.iconSize),
          label: 'Home',
        ),
        tabPage: VwSpecifiedFormSubmit(
            containerFolderNodeId: homeFolderNode != null
                ? homeFolderNode.recordId
                : AppConfig.rootFolderNodeId,
            containerFolderNode: homeFolderNode,
            appInstanceParam: widget.appInstanceParam,
            formResponse: widget.formResponse!,
            formDefinition: widget.formDefinition!));
  }

  VwHomeTabItem createFormAdmin() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.list_alt, size: this.iconSize),
          label: 'Form Admin',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded, size: this.iconSize),
          label: 'Form Admin',
        ),
        tabPage: FormAdminPage(
          baseUrl: this.widget.baseUrl,
          appInstanceParam: this.widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createTicketDefinitionStatChartNodeListViewHomeTabItem() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: this.iconSize),
          label: 'Dashboard',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: this.iconSize),
          label: 'Dasboard',
        ),
        tabPage: ChartNodeListView(
          folderNodeId: "f498df14-a537-4991-9d7c-7dc232b89f3c",
          pageTitleCaption: "Dashboard",
          key: UniqueKey(),
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createCableExtractionChartNodeListViewHomeTabItem() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: this.iconSize),
          label: 'Chart',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: this.iconSize),
          label: 'Chart',
        ),
        tabPage: ChartNodeListView(
          folderNodeId: AppConfig.cableExtractionChartNodeId,
          pageTitleCaption: "Chart",
          key: UniqueKey(),
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createPublicLandingPage({
    required IconData selectedIcon,
    required String selectedCaption,
    required IconData unselectedIcon,
    required String unselectedCaption,
  }) {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(selectedIcon),
          label: selectedCaption,
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(unselectedIcon),
          label: unselectedCaption,
        ),
        tabPage: VwPublicLandingPage(

            appInstanceParam: this.widget.appInstanceParam,
            rootFolderNodeId: APIVirtualNode.exploreNodeFeed));
  }

  VwHomeTabItem createFolderNodeHomeTabItem(
      {bool enableCreateRecord = false,
      required IconData selectedIcon,
      required String selectedCaption,
      required IconData unselectedIcon,
      required String unselectedCaption,
      required String rootFolderNodeId,
      required String rootFolderDisplayName}) {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(selectedIcon),
          label: selectedCaption,
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(unselectedIcon),
          label: unselectedCaption,
        ),
        tabPage: VwFormResponseUserPage(
          enableCreateRecord: enableCreateRecord,
          mainLogoTextCaption: rootFolderDisplayName,
          folderNodeId: rootFolderNodeId,
          key: this.formResponseUserPageKey,
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createFormResponseUserPage() {
    String? userHomeFolderNodeId;
    if (widget.appInstanceParam.loginResponse != null &&
        widget.appInstanceParam.loginResponse!.userInfo != null &&
        widget.appInstanceParam.loginResponse!.userInfo!.user
                .homeFolderNodeId !=
            null) {
      userHomeFolderNodeId = widget
          .appInstanceParam.loginResponse!.userInfo!.user.homeFolderNodeId;
    }

    if (userHomeFolderNodeId == null) {
      userHomeFolderNodeId = AppConfig.rootFolderNodeId;
    }

    VwNode? homeFolderNode;
    if (widget.appInstanceParam.loginResponse != null &&
        widget.appInstanceParam.loginResponse!.homeLinkNode != null) {
      homeFolderNode = NodeUtil.extractNodeFromLinkNode(
          widget.appInstanceParam.loginResponse!.homeLinkNode!);
    }

    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.folder_open, size: this.iconSize),
          label: 'Home',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.folder, size: this.iconSize),
          label: 'Home',
        ),
        tabPage: VwFormResponseUserPage(
          mainLogoTextCaption: homeFolderNode != null
              ? homeFolderNode.displayName
              : AppConfig.appTitle,
          folderNodeId: userHomeFolderNodeId,
          key: UniqueKey(),
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  VwHomeTabItem createDashboardOperatorTicketHomeTabItem() {
    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.area_chart_rounded, size: this.iconSize),
          label: 'Dashboard',
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.area_chart_outlined, size: this.iconSize),
          label: 'Dashboard',
        ),
        tabPage: ChartNodeListView(
          folderNodeId: "f498df14-a537-4991-9d7c-7dc232b89f3c",
          pageTitleCaption: "Dashboard",
          key: UniqueKey(),
          appInstanceParam: widget.appInstanceParam,
        ));
  }

  List<BottomNavigationBarItem> createBottomNavigationBarButtons() {
    List<BottomNavigationBarItem> returnValue = [];
    for (int la = 0; la < this.homeTabItemList.length; la++) {
      VwHomeTabItem currentElement = this.homeTabItemList.elementAt(la);

      if (la == this._selectedIndex) {
        returnValue.add(currentElement.buttonSelected);
      } else {
        returnValue.add(currentElement.buttonUnselected);
      }
    }

    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


    if (this.homeTabItemList.isEmpty == true) {
      String mainGroupRoleId = this
          .widget
          .appInstanceParam
          .loginResponse!
          .userInfo!
          .user
          .mainRoleUserGroupId;

      String errorMessage = "Error: Seting akun peran = " +
          mainGroupRoleId.toString() +
          ", mohon hubungi admin ticket";

      return FatalErrorPage(
        errorMessage: errorMessage,
        appInstanceParam: widget.appInstanceParam,
      );
    } else {
      BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
        backgroundColor: Colors.white,
        items: this.createBottomNavigationBarButtons(),
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromARGB(255, 180, 180, 180),
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      );

      Widget body1 = Center(
        child: this.homeTabItemList.elementAt(this._selectedIndex).tabPage,
      );
      return Scaffold(
          key: this.widget.key,
          bottomNavigationBar: bottomNavigationBar,
          body: body1);
    }
  }
}
