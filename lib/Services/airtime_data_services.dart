import 'package:kashwise/Services/firebase_services.dart';
class AirtimeNdData{


  Future<bool> buyAirtime(String userID, String phoneNum, double amount, String serviceProvider) async{

      bool resp = await FirebaseHelper().buyAirtime(userID, amount, phoneNum, serviceProvider);
      return resp;

  }



}