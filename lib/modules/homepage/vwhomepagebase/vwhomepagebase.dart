import 'package:flutter/material.dart';
import 'package:matrixclient2base/appconfig.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwrowdata/vwrowdata.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/homepage/vwhometabitem/vwhometabitem.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';
import 'package:vwform/modules/vwwidget/fatalerrorpage/fatalerrorpage.dart';
import 'package:vwform/modules/vwwidget/vwformresponseuserpage/vwformresponseuserpage.dart';
import 'package:vwutil/modules/util/nodeutil.dart';

class VwHomePageBase extends StatefulWidget {
  VwHomePageBase({
    super.key,
    required this.appInstanceParam,
    required this.homeTabItemList,
    this.initialIndex = 0,
    this.formResponse,
    this.formDefinition,
    this.containerFolderNode,
  });

  final VwAppInstanceParam appInstanceParam;
  final int initialIndex;
  final VwRowData? formResponse;
  final VwFormDefinition? formDefinition;
  final VwNode? containerFolderNode;
  final List<VwHomeTabItem> homeTabItemList;

  static VwHomeTabItem createFormResponseUserPage(
      {required VwAppInstanceParam appInstanceParam,
      String title = "Home",
      double iconSize = 26}) {
    String? userHomeFolderNodeId;
    if (appInstanceParam.loginResponse != null &&
        appInstanceParam.loginResponse!.userInfo != null &&
        appInstanceParam.loginResponse!.userInfo!.user.homeFolderNodeId !=
            null) {
      userHomeFolderNodeId =
          appInstanceParam.loginResponse!.userInfo!.user.homeFolderNodeId;
    }

    if (userHomeFolderNodeId == null) {
      userHomeFolderNodeId = appInstanceParam.baseAppConfig.generalConfig.rootFolderNodeId;
    }

    VwNode? homeFolderNode;
    if (appInstanceParam.loginResponse != null &&
        appInstanceParam.loginResponse!.homeLinkNode != null) {
      homeFolderNode = NodeUtil.extractNodeFromLinkNode(
          appInstanceParam.loginResponse!.homeLinkNode!);
    }

    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.folder_open, size: iconSize),
          label: title,
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.folder, size: iconSize),
          label: title,
        ),
        tabPage: VwFormResponseUserPage(
          mainLogoImageAsset: appInstanceParam.baseAppConfig.generalConfig.mainLogoPath,
          mainLogoTextCaption: homeFolderNode != null
              ? homeFolderNode.displayName
              : appInstanceParam.baseAppConfig.generalConfig.appTitle,
          folderNodeId: userHomeFolderNodeId,
          key: UniqueKey(),
          appInstanceParam: appInstanceParam,
        ));
  }

  static VwHomeTabItem createRootPage({
    required VwAppInstanceParam appInstanceParam,
    String title = "Home",
    double iconSize = 26,
    String? userHomeFolderNodeId
  }) {
    if (userHomeFolderNodeId == null) {
      userHomeFolderNodeId = appInstanceParam.baseAppConfig.generalConfig.rootFolderNodeId;
    }

    VwNode? homeFolderNode;
    if (appInstanceParam.loginResponse != null &&
        appInstanceParam.loginResponse!.homeLinkNode != null) {
      homeFolderNode = NodeUtil.extractNodeFromLinkNode(
          appInstanceParam.loginResponse!.homeLinkNode!);
    }

    return VwHomeTabItem(
        buttonSelected: BottomNavigationBarItem(
          icon: Icon(Icons.folder_open, size: iconSize),
          label: title,
        ),
        buttonUnselected: BottomNavigationBarItem(
          icon: Icon(Icons.folder, size: iconSize),
          label: title,
        ),
        tabPage: VwFormResponseUserPage(
          mainLogoImageAsset: appInstanceParam.baseAppConfig.generalConfig.mainLogoPath,
          mainLogoTextCaption: homeFolderNode != null
              ? homeFolderNode.displayName
              : appInstanceParam.baseAppConfig.generalConfig.appTitle,
          folderNodeId: userHomeFolderNodeId,
          key: UniqueKey(),
          appInstanceParam: appInstanceParam,
        ));
  }

  static VwHomeTabItem createFolderNodeHomeTabItem(
      {bool enableCreateRecord = false,
      required IconData selectedIcon,
      required String selectedCaption,
      required IconData unselectedIcon,
      required String unselectedCaption,
      required String rootFolderNodeId,
      required String rootFolderDisplayName,
      required Key formResponseUserPageKey,
      required VwAppInstanceParam appInstanceParam}) {
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
          mainLogoImageAsset: appInstanceParam.baseAppConfig.generalConfig.mainLogoPath,
          enableCreateRecord: enableCreateRecord,
          mainLogoTextCaption: rootFolderDisplayName,
          folderNodeId: rootFolderNodeId,
          key: formResponseUserPageKey,
          appInstanceParam: appInstanceParam,
        ));
  }

  _VwHomePageBaseState createState() => _VwHomePageBaseState();
}

class _VwHomePageBaseState extends State<VwHomePageBase> {
  late int _selectedIndex;
  late Key formResponseUserPageKey;
  final double iconSize = 26;

  @override
  void initState() {
    super.initState();
    this.formResponseUserPageKey = UniqueKey();
    this._selectedIndex = this.widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> createBottomNavigationBarButtons() {
    List<BottomNavigationBarItem> returnValue = [];
    for (int la = 0; la < this.widget.homeTabItemList.length; la++) {
      VwHomeTabItem currentElement = this.widget.homeTabItemList.elementAt(la);

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

    if (this.widget.homeTabItemList.isEmpty == true) {
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
        child:
            this.widget.homeTabItemList.elementAt(this._selectedIndex).tabPage,
      );

      return MaterialApp(
          home: Scaffold(
              key: this.widget.key,
              bottomNavigationBar: bottomNavigationBar,
              body: body1));
    }
  }
}
