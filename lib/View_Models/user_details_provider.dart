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
      signInMethod = SignInMethod.email;
      notifyListeners();
      return true;
    }
    isSignedIn = false;
    loading = false;
    notifyListeners();
    return false;
  }

  /// SignUp with email and password
  Future<bool> createUserWithEmailAndPassword(String email, String password, String username) async {
    UserDetails? userDetails = await FirebaseHelper()
        .createUserWithEmailAndPassword(email, password, username);
    if (userDetails != null) {
      account = userDetails;
      isSignedIn = true;
      loading = false;
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
    try {
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
    } catch (e) {
      MPrint(value: e.toString());
      loading = false;
      isSignedIn = false;
      notifyListeners();
      return false;
    }
  }

  /// Refresh user details
  refreshUserDetails(String uid) async {
    UserDetails? userDetails = await FirebaseHelper().refreshUserDetails(uid);
    if (userDetails != null) {
      account = userDetails;
      notifyListeners();
    } else {
      MPrint(value: 'user details not updated');
    }
  }

  /// SetUserDetails
  setUserDetails(UserDetails userDetails) {
    account = userDetails;
    notifyListeners();
  }

  /// Check if user in signed in on firestore
  Future<bool> checkUserSignIn() async {
    UserDetails? userDetails = await FirebaseHelper().checkUserSignIn();
    if (userDetails == null) {
      return false;
    } else {
      return true;
    }
  }

  signOutGoogleUser() {
    FirebaseHelper().signOutGoogleUser();
    isSignedIn = false;
    notifyListeners();
  }
}
