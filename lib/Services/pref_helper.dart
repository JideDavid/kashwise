import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper{

  Future<String> getPassCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("passCode");
    if(val == null) {
      return '';
    }else{
      return val;
    }
  }

  setPassCode(String val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("passCode", val);
  }

  Future<bool> getIsLocked() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("isLocked");
    if(val == null) {
      return false;
    }else{
      return val;
    }
  }

  setIsLocked(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLocked", val);
  }

  Future<bool> getThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("isLight");
    if(val == null) {
      return false;
    }else{
      return val;
    }
  }

  Future<bool>setThemeMode(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLight", val);
    return val;
  }

  Future<bool> getHideBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("isHidden");
    if(val == null) {
      return false;
    }else{
      return val;
    }
  }

  setHideBalance(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isHidden", val);
  }

  Future<bool> getAppIsFresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("appIsFresh");
    if(val == null) {
      return true;
    }else{
      return val;
    }
  }

  setAppIsFresh(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("appIsFresh", val);
  }

}