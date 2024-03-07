import 'package:flutter/foundation.dart';

class MPrint{

  MPrint(String value){
    if(kDebugMode){
      print(">>>>>>>>>> $value <<<<<<<<<<");
    }
  }


}