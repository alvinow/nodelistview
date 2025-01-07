import 'package:flutter/cupertino.dart';

class VwHomeTabItem {
  VwHomeTabItem({
    required this.buttonSelected,
    required this.buttonUnselected,
    required this.tabPage,

});

  final BottomNavigationBarItem buttonSelected;
  final BottomNavigationBarItem buttonUnselected;
  final Widget tabPage;


  BottomNavigationBarItem getButton(bool isSelected){
    if(isSelected)
      {
        return this.buttonSelected;
      }
    else
      {
        return buttonUnselected;
      }
  }
}