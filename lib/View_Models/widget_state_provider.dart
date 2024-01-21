import 'package:flutter/material.dart';
class WidgetStateProvider extends ChangeNotifier {

  int homeActiveTab = 0;

  setActiveIndex(int index){
    homeActiveTab = index;
    notifyListeners();
  }
}