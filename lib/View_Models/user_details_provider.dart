import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:nonce/nonce.dart';

class UserDetailsProvider extends ChangeNotifier{

  late UserDetails userDetails;
  double walletBal = 200.0;
  double totalSavings = 20000.0;
  double owing = 0.0;
  int freeTransactionsLeft = 20;

  incrementBal(double value){
    walletBal += value;
    notifyListeners();
  }

  incrementSavings() async{
    Future.delayed(const Duration(seconds: 3),(){
      totalSavings += 500;
      notifyListeners();
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async{
    //getting a google user from selection
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //return if no user is selected
    if (googleUser == null) {
      if(kDebugMode){
        print(">>>>>>>>>>>>>> no google user selected <<<<<<<<<<<<<<");
      }
      return false;
    }
    //getting google sign in authentication for this account
    final googleAuth = await googleUser.authentication;

    if(kDebugMode){
      print(">>>>>>>>>>>>>>>>>>> Google user selected <<<<<<<<<<<<<<<<");
      print("accessToken: ${googleAuth.accessToken}, idToken: ${googleAuth.idToken}");
    }

    /// Sign in with google - Firebase Service
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //drawing credential from googleAuthProvider with firebase
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //signing user in firebaseAuth with google credential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    //checking if user previously exist on firebase
    DocumentSnapshot userData =
    await firestore.collection('users').doc(userCredential.user!.uid).get();

    //login user in if user exists
    if (userData.exists) {
      userDetails = UserDetails.fromJson(userData);
      notifyListeners();
      return true;
    }
    //else create an account for user on firebase
    else {
      //generating wallet tag using the combination of username and generated seven alphanumeric keys
      var username = (userCredential.user!.displayName)?.replaceAll(' ', '');
      var walletTag = "$username${Nonce.generate(7)}";
      //saving user credential in firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'image': userCredential.user!.photoURL,
        'uid': userCredential.user!.uid,
        'date': DateTime.now(),
        'walletTag': walletTag,
        'walletBalance': 0,
      });
      userDetails = UserDetails.fromJson(userData);
      notifyListeners();
      return true;
    }

  }

  refreshUserDetails() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(userDetails.uid).get();
    if(snapshot.exists){
      userDetails = UserDetails.fromJson(snapshot);
      notifyListeners();
    }else{
      if(kDebugMode){
        print("User with id: ${userDetails.uid} does not exists on the database");
      }
    }
  }

}