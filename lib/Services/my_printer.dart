import 'package:flutter/foundation.dart';

class MPrint{
  String value;

  MPrint({required this.value}){
    if(kDebugMode){
      print(value);
    }
  }


}