import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:kashwise/Services/firebase_services.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/utils/constants/enums.dart';
import 'package:kashwise/utils/constants/image_strings.dart';
import 'package:nonce/nonce.dart';

class UserDetailsProvider extends ChangeNotifier {
  late SignInMethod signInMethod;
  late UserDetails account;
  bool loading = false;
  bool isSignedIn = false;
  bool checkingSingedIn = false;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Sign in with google
  Future<bool> signInWithGoogle() async {


    loading = true;
    notifyListeners();

    //getting a google user from selection
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //return if no user is selected
    if (googleUser == null) {
      MPrint(value: ">>>>>>>>>>>>>> No google user selected <<<<<<<<<<<<<<");
      MPrint(value: 'no user selected');
      loading = false;
      isSignedIn = false;
      notifyListeners();
      return false;
    }
    else {

      /// checking if user with email already exist with another signIn method
      String? signedInMethod = await FirebaseHelper().getSignInMethod(googleUser.email);
      if(signedInMethod == 'google' || signedInMethod == 'null'){
        ///getting google sign in authentication for selected account
        final googleAuth = await googleUser.authentication;
        MPrint(value: ">>>>>>>>>>>>> Google user selected <<<<<<<<<<<<<<<");

        ///drawing credential from googleAuthProvider with firebase
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        MPrint(value: userCredential.user!.email.toString());
        googleSignIn.signOut();

        //saving sign in method
        signInMethod = SignInMethod.google;

        try {
          //checking if user previously exist on firebase
          DocumentSnapshot userData = await firestore.collection('users').doc(
              userCredential.user!.uid).get();

          //login user in if user exists
          if (userData.exists) {
            account = UserDetails.fromJson(userData);
            loading = false;
            isSignedIn = true;
            notifyListeners();
            return true;
          }

          //else create an account for user on firebase
          else {
            //generating wallet tag using the combination of username and generated seven alphanumeric keys
            var username = (userCredential.user!.displayName)?.replaceAll(
                ' ', '');
            var walletTag = "$username${Nonce.generate(7)}";

            try {
              //saving user credential in firestore
              await firestore.collection('users').doc(
                  userCredential.user!.uid).set({
                'email': userCredential.user!.email,
                'username': username,
                'image': userCredential.user!.photoURL,
                'uid': userCredential.user!.uid,
                'date': DateTime.now(),
                'walletTag': walletTag,
                'walletBalance': 0.0,
                'totalSavings': 0.0,
                'totalOwe': 0.0,
                'freeTransfers': 10,
                'signInMethod': 'google'
              });

              //getting user detail from firebase
              DocumentSnapshot userData = await firestore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .get();

              account = UserDetails.fromJson(userData);
              isSignedIn = true;
              loading = false;
              notifyListeners();
              return true;
            }
            catch (e) {
              MPrint(value: e.toString());
              isSignedIn = false;
              loading = false;
              notifyListeners();
              return false;
            }
          }
        }
        catch (e) {
          MPrint(value: 'could not complete sign up error: $e');
          isSignedIn = false;
          loading = false;
          notifyListeners();
          return false;
        }
      }
      else{
        MPrint(value: 'User signed up with a different method');
        signOutGoogleUser();
        isSignedIn = false;
        loading = false;
        notifyListeners();
        return false;
      }
    }
  }


  /// SignUp with email and password
  Future<bool> createUserWithEmailAndPassword(String email, String password, String username) async {
    loading = true;
    notifyListeners();

    try {
      //signing user in firebaseAuth with google credential
      UserCredential? userCredential = await FirebaseHelper().createUserWithEmailAndPassword(email, password);

      //saving sign in method
      signInMethod = SignInMethod.email;

      if (userCredential == null) {
        loading = false;
        isSignedIn = false;
        notifyListeners();
        return false;
      } else {
        //checking if user previously exist on firebase
        DocumentSnapshot userData = await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        //login user in if user exists
        if (userData.exists) {
          account = UserDetails.fromJson(userData);
          loading = false;
          isSignedIn = true;
          notifyListeners();
          return true;
        }

        //else create an account for user on firebase
        else {
          //generating wallet tag using the combination of username and generated seven alphanumeric keys
          var tempUsername = (username).replaceAll(' ', '');
          var walletTag = "$tempUsername${Nonce.generate(7)}";

          try {
            //saving user credential in firestore
            await firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'email': userCredential.user!.email,
              'username': username,
              'image': TImages.defaultAvatar,
              'uid': userCredential.user!.uid,
              'date': DateTime.now(),
              'walletTag': walletTag,
              'walletBalance': 0.0,
              'totalSavings': 0.0,
              'totalOwe': 0.0,
              'freeTransfers': 10,
              'signInMethod': 'email'
            });

            //getting user detail from firebase
            DocumentSnapshot userData = await firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .get();

            account = UserDetails.fromJson(userData);

            isSignedIn = true;
            loading = false;
            notifyListeners();
            return true;
          } catch (e) {
            MPrint(value: 'error creating user on firestore: $e');
            isSignedIn = false;
            loading = false;
            notifyListeners();
            return false;
          }
        }
      }
    } catch (e) {
      loading = false;
      isSignedIn = false;
      notifyListeners();
      return false;
    }
  }

  /// Login with email and password
  Future<bool> loginWithEmailAndPassword(String email, String password) async{
    try{
      UserDetails? userData = await FirebaseHelper().loginWithEmailAndPassword(email, password);
      if(userData == null){
        loading = false;
        isSignedIn = false;
        notifyListeners();
        return false;
      }else{
        account = userData;
        loading = false;
        isSignedIn = true;
        notifyListeners();
        return true;
      }
    }
    catch(e){
      MPrint(value: e.toString());
      loading = false;
      isSignedIn = false;
      notifyListeners();
      return false;
    }

  }

  /// Refresh user details
  refreshUserDetails() async {
    loading = true;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(account.uid)
        .get();
    if (snapshot.exists) {
      account = UserDetails.fromJson(snapshot);
      loading = false;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print("User with id: ${account.uid} does not exists on the database");
      }
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

  Future checkUserSignIn() async {
    MPrint(
        value:
            ">>>>>>>>>>>>>>>>>>>>>>>> checking user sign in <<<<<<<<<<<<<<<<<<<<<<<<<<<");
    checkingSingedIn = true;
    notifyListeners();

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      checkingSingedIn = false;
      isSignedIn = false;
      notifyListeners();
      MPrint(
          value:
              ">>>>>>>>>>>>>>>>>>>>>>>> no user signed in <<<<<<<<<<<<<<<<<<<<<<<<<<<");
    } else {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      account = UserDetails.fromJson(snapshot);
      checkingSingedIn = false;
      isSignedIn = true;
      notifyListeners();
      MPrint(
          value:
              ">>>>>>>>>>>>>>>>>>>>>>>> a user is signed in <<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }
  }

  signOutGoogleUser() {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    isSignedIn = false;
    notifyListeners();
    if (kDebugMode) {
      print(">>>>>>>>>>>>>> google logout <<<<<<<<<<<<<<");
    }
  }
}
