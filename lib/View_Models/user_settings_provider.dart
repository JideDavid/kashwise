import 'package:flutter/foundation.dart';
import '../Services/pref_helper.dart';

class UserSettingsProvider extends ChangeNotifier{

  bool isLightMode = false;
  bool balIsHidden = false;

  changeLightMode(){
    //changing theme mode
    isLightMode = !isLightMode;
    //saving theme mode to device
    PrefHelper().setThemeMode(isLightMode);
    notifyListeners();
  }

  getSavedThemeMode() async{
    //setting theme mode from last save on device
    isLightMode = await PrefHelper().getThemeMode();
    notifyListeners();
  }

  changeBalanceVisibility(){
    //changing visibility
    balIsHidden = !balIsHidden;
    if(kDebugMode){
      print(">>>>>>>>>>>>>> Show Bal is $balIsHidden <<<<<<<<<<<<<<<<");
    }
    //saving theme mode to device
    PrefHelper().setHideBalance(balIsHidden);
    notifyListeners();
  }

  getBalanceVisibility() async{
    // setting balance visibility from last saved on device
    balIsHidden = await PrefHelper().getHideBalance();
    notifyListeners();
  }

}