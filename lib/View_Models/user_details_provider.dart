import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kashwise/Models/all_transactions_model.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:kashwise/Services/firebase_services.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/utils/constants/enums.dart';

import '../Models/transaction_model.dart';

class UserDetailsProvider extends ChangeNotifier {
  late SignInMethod signInMethod;
  late UserDetails account;
  bool loading = false;
  bool isSignedIn = false;
  bool checkingSingedIn = false;
  List<Transfer> transferList = [];
  List<AllTransaction> allTransactionList = [];

  /// Sign in with google
  Future<bool> signInWithGoogle(BuildContext context) async {
    loading = true;
    notifyListeners();

    UserDetails? userDetails = await FirebaseHelper().signInWithGoogle(context);
    if (userDetails != null) {
      account = userDetails;
      isSignedIn = true;
      loading = false;
      signInMethod = SignInMethod.google;
      notifyListeners();
      return true;
    } else {
      isSignedIn = false;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  /// SignUp with email and password
  Future<bool> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    loading = true;
    notifyListeners();

    UserDetails? userDetails = await FirebaseHelper()
        .createUserWithEmailAndPassword(email, password, username);
    if (userDetails != null) {
      account = userDetails;
      isSignedIn = true;
      loading = false;
      signInMethod = SignInMethod.email;
      notifyListeners();
      return true;
    } else {
      isSignedIn = false;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  /// Login with email and password
  Future<bool> loginWithEmailAndPassword(BuildContext context, String email, String password) async {
    loading = true;
    notifyListeners();

    UserDetails? userData =
        await FirebaseHelper().loginWithEmailAndPassword(context, email, password);
    if (userData == null) {
      loading = false;
      isSignedIn = false;
      notifyListeners();
      return false;
    } else {
      account = userData;
      loading = false;
      isSignedIn = true;
      notifyListeners();
      return true;
    }
  }

  /// Refresh user details
  refreshUserDetails() async {
    loading = true;
    notifyListeners();

    UserDetails? userDetails =
        await FirebaseHelper().refreshUserDetails(account.uid);
    if (userDetails != null) {
      account = userDetails;
      MPrint( account.walletBalance.toString());
      isSignedIn = true;
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  /// setUserDetails
  setUserDetails(UserDetails userDetails) {
    MPrint(">>>>>>>>>>> started setting user details <<<<<<<<<<<<<<<<");
    account = userDetails;
    notifyListeners();
    if (kDebugMode) {
      MPrint(">>>>>>>>>>> user details has been set <<<<<<<<<<<<<<<<");
    }
  }

  Future<bool> checkUserSignIn() async {
    checkingSingedIn = true;
    notifyListeners();

    UserDetails? userDetails = await FirebaseHelper().checkUserSignIn();
    if (userDetails != null) {
      checkingSingedIn = false;
      isSignedIn = true;
      notifyListeners();
      return true;
    } else {
      checkingSingedIn = false;
      notifyListeners();
      return false;
    }
  }

  signOutGoogleUser() {
    FirebaseHelper().signOutGoogleUser();
    isSignedIn = false;
    notifyListeners();
  }

  Future<bool> getTransactionHistory(BuildContext context) async{
    List<Transfer>? resp = await FirebaseHelper().getWalletTransferHistory(context, account.uid);
    if(resp != null){
      transferList = resp;
      transferList.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
      return true;
    }else{
      transferList = [];
      return false;
    }
  }

  Future<bool> getAllTransactionHistory(BuildContext context) async{
    List<AllTransaction>? resp = await FirebaseHelper().getAllTransferHistory(context, account.uid);
    if(resp != null){
      allTransactionList = resp;
      allTransactionList.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
      return true;
    }else{
      allTransactionList = [];
      return false;
    }
  }

  clearTransactionHistory(){
    transferList = [];
    notifyListeners();
  }

}
