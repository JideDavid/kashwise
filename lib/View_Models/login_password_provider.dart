import 'package:flutter/material.dart';

import '../Services/pref_helper.dart';

class LoginPasswordProvider extends ChangeNotifier{
  String entries = '';
  bool isLocked = false;

  ///Password Entry
  addEntry(int entry){
    if(entries.length < 6){
      List<String> code = entries.split("");
      code.add(entry.toString());
      entries = code.join();
      notifyListeners();
    }
  }

  removeLastEntry(){
    if(entries.isNotEmpty){
      List<String> code = entries.split("");
       code.removeLast();
       entries = code.join();
      notifyListeners();
    }
  }

  clearEntry(){
    entries = '';
    notifyListeners();
  }

  bool authenticateCode(){
    String code = '000000';

    if(entries == code){
      entries = '';
      //setting lockscreen activeness to false
      setIsLocked(false);
      return true;
    }

    else if(entries.length == 6){
      entries = '';
      notifyListeners();
      return false;
    }

    else{
      return false;
    }
  }

  ///Lockscreen activity notifier
  getIsLocked() async{
    isLocked = await PrefHelper().getIsLocked();
    notifyListeners();
  }

  setIsLocked(bool val) async{
    isLocked = val;
    PrefHelper().setIsLocked(val);
    notifyListeners();
  }


}