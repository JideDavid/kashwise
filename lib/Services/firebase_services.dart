import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:nonce/nonce.dart';

import '../Models/user_model.dart';
import '../utils/constants/image_strings.dart';

class FirebaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  /// Sign in with google
  Future<UserDetails?> signInWithGoogle() async {
    //getting a google user from selection
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //return if no user is selected
    if (googleUser == null) {
      MPrint(value: ">>>>>>>>>>>>>> No google user selected <<<<<<<<<<<<<<");
      MPrint(value: 'no user selected');
      return null;
    } else {
      /// checking if user with email already exist with another signIn method
      String? signedInMethod = await getSignInMethod(googleUser.email);
      if (signedInMethod == 'google' || signedInMethod == 'null') {
        ///getting google sign in authentication for selected account
        final googleAuth = await googleUser.authentication;
        MPrint(value: ">>>>>>>>>>>>> Google user selected <<<<<<<<<<<<<<<");

        ///drawing credential from googleAuthProvider with firebase
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          MPrint(value: userCredential.user!.email.toString());

          ///checking if user previously exist on firebase
          DocumentSnapshot userData = await firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

          if (userData.exists) {
            UserDetails userDetails = UserDetails.fromJson(userData);
            return userDetails;
          }

          //else create an account for user on firebase
          else {
            //generating wallet tag using the combination of username and generated seven alphanumeric keys
            var username =
                (userCredential.user!.displayName)?.replaceAll(' ', '');
            var walletTag = "$username${Nonce.generate(7)}";

            try {
              ///saving user credential in firestore
              await firestore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .set({
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

              ///getting user detail from firebase
              DocumentSnapshot userData = await firestore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .get();

              UserDetails userDetails = UserDetails.fromJson(userData);
              return userDetails;
            } catch (e) {
              MPrint(value: e.toString());
              return null;
            }
          }
        } catch (e) {
          MPrint(value: e.toString());
          return null;
        }
      } else {
        MPrint(value: 'User signed up with a different method');
        signOutGoogleUser();
        return null;
      }
    }
  }

  Future<bool> checkUsernameExist(String username) async {
    bool nameExists = false;

    ///
    /// Getting users query snapshots from firestore
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();
      var docs = snapshot.docs;

      if (docs.isEmpty) {
        MPrint(value: 'No users on db yet');
        nameExists = false;
        return nameExists;
      } else {
        for (var doc in docs) {
          if (username == doc['username']) {
            nameExists = true;
          }
        }
        return nameExists;
      }
    } catch (e) {
      MPrint(value: '>>>>> error getting users from firestore: $e <<<<<');
      return false;
    }
  }

  Future<bool> checkEmailExist(String email) async {
    bool emailExist = false;

    ///
    /// Getting users query snapshots from firestore
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();
      var docs = snapshot.docs;

      if (docs.isEmpty) {
        MPrint(value: 'No users on db yet');
        emailExist = false;
        return emailExist;
      } else {
        for (var doc in docs) {
          if (email.toLowerCase() == doc['email'].toString().toLowerCase()) {
            emailExist = true;
          }
        }
        return emailExist;
      }
    } catch (e) {
      MPrint(value: '>>>>> error getting users from firestore: $e <<<<<');
      return false;
    }
  }

  Future<UserDetails?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      UserDetails account = UserDetails.fromJson(snapshot);
      return account;
    } catch (e) {
      MPrint(value: e.toString());
      return null;
    }
  }

  Future<String?> getSignInMethod(String email) async {
    bool emailExist = false;

    ///
    /// Getting users query snapshots from firestore
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();
      var docs = snapshot.docs;
      if (docs.isEmpty) {
        MPrint(value: 'No users on db yet');
        emailExist = false;
        return null;
      } else {
        for (var doc in docs) {
          if (email.toLowerCase() == doc['email'].toString().toLowerCase()) {
            emailExist = true;
            if (emailExist) {
              return doc['signInMethod'].toString().toLowerCase();
            }
          }
        }
      }
    } catch (e) {
      MPrint(value: e.toString());
      return null;
    }
    return null;
  }

  Future<String?> requestChangePassword(String email) async {
    try {
      firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      MPrint(value: e.toString());
    }
    return null;
  }

  Future<UserDetails?> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      ///checking if user previously exist on firebase
      DocumentSnapshot userData = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      ///login user in if user exists
      if (userData.exists) {
        UserDetails userDetails = UserDetails.fromJson(userData);
        return userDetails;
      }

      ///else create an account for user on firebase
      else {
        ///generating wallet tag using the combination of username and generated seven alphanumeric keys
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

          UserDetails account = UserDetails.fromJson(userData);

          return account;
        } catch (e) {
          MPrint(value: e.toString());
          return null;
        }
      }
    } catch (e) {
      MPrint(value: e.toString());
      return null;
    }
  }

  Future<UserDetails?> refreshUserDetails(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (snapshot.exists) {
        UserDetails account = UserDetails.fromJson(snapshot);
        return account;
      } else {
        MPrint(value: "User with id: $uid does not exists on the database");
        return null;
      }
    } catch (e) {
      MPrint(value: e.toString());
      return null;
    }
  }

  /// Check if user in signed in on firestore
  Future<UserDetails?> checkUserSignIn() async {
    try {

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return null;
      } else {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          UserDetails account = UserDetails.fromJson(snapshot);
          return account;
        } else {
          return null;
        }
      }
    } catch (e) {
      MPrint(value: e.toString());
      return null;
    }
  }

  signOutGoogleUser() {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    MPrint(value: ">>>>>>>>>>>>>> google logout <<<<<<<<<<<<<<");
  }
}
