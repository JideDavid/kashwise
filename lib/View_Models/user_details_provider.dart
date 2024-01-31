import 'package:flutter/foundation.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:kashwise/Services/firebase_services.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/utils/constants/enums.dart';

class UserDetailsProvider extends ChangeNotifier {
  late SignInMethod signInMethod;
  late UserDetails account;
  bool loading = false;
  bool isSignedIn = false;
  bool checkingSingedIn = false;

  /// Sign in with google
  Future<bool> signInWithGoogle() async {
    loading = true;
    notifyListeners();

    UserDetails? userDetails = await FirebaseHelper().signInWithGoogle();
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
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    loading = true;
    notifyListeners();

    UserDetails? userData =
        await FirebaseHelper().loginWithEmailAndPassword(email, password);
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
    MPrint(value: ">>>>>>>>>>> started setting user details <<<<<<<<<<<<<<<<");
    account = userDetails;
    notifyListeners();
    if (kDebugMode) {
      MPrint(value: ">>>>>>>>>>> user details has been set <<<<<<<<<<<<<<<<");
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
}
