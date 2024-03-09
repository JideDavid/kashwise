import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kashwise/Models/all_transactions_model.dart';
import 'package:kashwise/Models/transfer_model.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/utils/constants/text_strings.dart';
import 'package:kashwise/utils/custom_widgets/m_error_dialog.dart';
import 'package:nonce/nonce.dart';
import '../Models/user_model.dart';
import '../utils/constants/image_strings.dart';

class FirebaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  /// Sign in with google
  Future<UserDetails?> signInWithGoogle(BuildContext context) async {
    //getting a google user from selection
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //return if no user is selected
    if (googleUser == null) {
      MPrint(">>>>>>>>>>>>>> No google user selected <<<<<<<<<<<<<<");
      MPrint('no user selected');
      return null;
    } else {
      /// checking if user with email already exist with another signIn method
      String? signedInMethod = await getSignInMethod(googleUser.email);
      MPrint('>>>>>>>>>>>signIn Method: $signedInMethod<<<<<<<<<<<<<');
      if (signedInMethod == 'google' || signedInMethod == null) {
        ///getting google sign in authentication for selected account
        final googleAuth = await googleUser.authentication;
        MPrint(">>>>>>>>>>>>> Google user selected <<<<<<<<<<<<<<<");

        ///drawing credential from googleAuthProvider with firebase
        final credential =
            GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          MPrint(userCredential.user!.email.toString());

          ///checking if user previously exist on firebase
          DocumentSnapshot userData = await firestore.collection('users').doc(userCredential.user!.uid).get();

          if (userData.exists) {
            UserDetails userDetails = UserDetails.fromJson(userData);
            return userDetails;
          }

          //else create an account for user on firebase
          else {
            //generating wallet tag using the combination of username and generated seven alphanumeric keys
            var username = (userCredential.user!.displayName)?.replaceAll(' ', '');
            var walletID = "$username${Nonce.generate(7)}";

            try {
              ///saving user credential in firestore
              await firestore.collection('users').doc(userCredential.user!.uid).set({
                'email': userCredential.user!.email,
                'username': username,
                'image': userCredential.user!.photoURL,
                'uid': userCredential.user!.uid,
                'date': DateTime.now(),
                'walletID': walletID,
                'walletBalance': 0.0,
                'totalSavings': 0.0,
                'totalOwe': 0.0,
                'freeTransfers': 10,
                'signInMethod': 'google'
              });

              ///getting user detail from firebase
              DocumentSnapshot userData = await firestore.collection('users').doc(userCredential.user!.uid).get();

              UserDetails userDetails = UserDetails.fromJson(userData);
              return userDetails;
            } catch (e) {
              MPrint(e.toString());
              return null;
            }
          }
        } catch (e) {
          MPrint(e.toString());
          return null;
        }
      } else {
        // ignore: use_build_context_synchronously
        MFeedback(context: context).error('User signed up with a different method');
        MPrint('User signed up with a different method');
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
        MPrint('No users on db yet');
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
      MPrint('>>>>> error getting users from firestore: $e <<<<<');
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
        MPrint('No users on db yet');
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
      MPrint('>>>>> error getting users from firestore: $e <<<<<');
      return false;
    }
  }

  Future<UserDetails?> loginWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      String? signInMethod = await getSignInMethod(email);
      if (signInMethod == null) {
        //ignore: use_build_context_synchronously
        MFeedback(context: context).error("This account does not exist on ${TTexts.appName}");
        return null;
      } else if (signInMethod == "google") {
        //ignore: use_build_context_synchronously
        MFeedback(context: context).error("Account was created with a different sign in method");
        return null;
      } else {
        UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        DocumentSnapshot snapshot = await firestore.collection('users').doc(userCredential.user!.uid).get();
        UserDetails account = UserDetails.fromJson(snapshot);
        return account;
      }
    } catch (e) {
      MPrint(e.toString());
      //ignore: use_build_context_synchronously
      if (e.toString() ==
          "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
        //ignore: use_build_context_synchronously
        MFeedback(context: context).error("Email or password is incorrect");
      } else {
        //ignore: use_build_context_synchronously
        MFeedback(context: context).error(e.toString());
      }
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
        MPrint('No users on db yet');
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
      MPrint(e.toString());
      return null;
    }
    return null;
  }

  Future<bool?> requestChangePassword(BuildContext context, String email) async {
    try {
      String? signInMethod = await getSignInMethod(email);
      if (signInMethod == null) {
        // ignore: use_build_context_synchronously
        MFeedback(context: context).error('Account does not exist');
        return false;
      } else if (signInMethod == 'email') {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        // ignore: use_build_context_synchronously
        MFeedback(context: context).error('Password reset code sent to your email successfully');
        return true;
      } else {
        // ignore: use_build_context_synchronously
        MFeedback(context: context).error('Account was created using google Sign In method');
        return false;
      }
    } catch (e) {
      MPrint('>>>>>>>> error: ${e.toString()} <<<<<<<<<<<');
      return null;
    }
  }

  Future<UserDetails?> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      ///checking if user previously exist on firebase
      DocumentSnapshot userData = await firestore.collection('users').doc(userCredential.user!.uid).get();

      ///login user in if user exists
      if (userData.exists) {
        UserDetails userDetails = UserDetails.fromJson(userData);
        MPrint("user ${userDetails.email} already exist on ${TTexts.appName}");
        return userDetails;
      }

      ///else create an account for user on firebase
      else {
        ///generating wallet tag using the combination of username and generated seven alphanumeric keys
        var tempUsername = (username).replaceAll(' ', '');
        var walletID = "$tempUsername${Nonce.generate(7)}";

        try {
          //saving user credential in firestore
          await firestore.collection('users').doc(userCredential.user!.uid).set({
            'email': userCredential.user!.email,
            'username': username,
            'image': TImages.defaultAvatar,
            'uid': userCredential.user!.uid,
            'date': DateTime.now(),
            'walletID': walletID,
            'walletBalance': 0.0,
            'totalSavings': 0.0,
            'totalOwe': 0.0,
            'freeTransfers': 10,
            'signInMethod': 'email'
          });

          //getting user detail from firebase
          DocumentSnapshot userData = await firestore.collection('users').doc(userCredential.user!.uid).get();

          UserDetails account = UserDetails.fromJson(userData);

          return account;
        } catch (e) {
          MPrint(e.toString());
          return null;
        }
      }
    } catch (e) {
      MPrint(e.toString());
      return null;
    }
  }

  Future<UserDetails?> refreshUserDetails(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (snapshot.exists) {
        UserDetails account = UserDetails.fromJson(snapshot);
        return account;
      } else {
        MPrint("User with id: $uid does not exists on the database");
        return null;
      }
    } catch (e) {
      MPrint(e.toString());
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
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
        if (snapshot.exists) {
          UserDetails account = UserDetails.fromJson(snapshot);
          return account;
        } else {
          return null;
        }
      }
    } catch (e) {
      MPrint(e.toString());
      return null;
    }
  }

  signOutGoogleUser() {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    MPrint(">>>>>>>>>>>>>> google logout <<<<<<<<<<<<<<");
  }

  /// Transfer to app user
  Future<bool> transferToAppUser(BuildContext context, String senderID, String receiverID, double amount) async {
    String transactionMethod = "walletTransfers";
    /// Date and time
    DateTime date = DateTime.now();

    /// Generate a transaction ID
    String transactionID = "Ref${Nonce(15)}";

    /// Sender account
    DocumentSnapshot senderAccount = await firestore.collection("users").doc(senderID).get();
    UserDetails senderDetails = UserDetails.fromJson(senderAccount);
    double senderInitWalletBalance = senderDetails.walletBalance;
    double senderNewWalletBalance = senderInitWalletBalance - amount;

    /// Receiver account
    DocumentSnapshot receiverAccount = await firestore.collection("users").doc(receiverID).get();
    UserDetails receiverDetails = UserDetails.fromJson(receiverAccount);
    double receiverInitWalletBalance = receiverDetails.walletBalance;
    double receiverNewWalletBalance = receiverInitWalletBalance + amount;

    /// Credit and debit users
    try {
      if (senderInitWalletBalance < amount) {
        MPrint(">>>>> Insufficient wallet balance <<<<<");
        //ignore: use_build_context_synchronously
        MFeedback(context: context).error("Insufficient wallet balance");

        return false;
      } else {
        /// Debit user
        firestore.collection("users").doc(senderDetails.uid).update({'walletBalance': senderNewWalletBalance});
        MPrint("user successfully debited $amount naira");
        MPrint("new user wallet balance: $senderNewWalletBalance");

        /// Record Debit
        recordTransfer(false,transactionMethod, amount, transactionID, date, senderID, "remark", senderInitWalletBalance,
            senderNewWalletBalance, receiverID, receiverInitWalletBalance, receiverNewWalletBalance);

        /// Credit user
        firestore.collection("users").doc(receiverDetails.uid).update({"walletBalance": receiverNewWalletBalance});
        MPrint("receiver successfully credited $amount naira");
        MPrint("new receiver wallet balance: $receiverNewWalletBalance");

        /// Record credit
        recordTransfer(true, transactionMethod, amount, transactionID, date, senderID, "remark", senderInitWalletBalance,
            senderNewWalletBalance, receiverID, receiverInitWalletBalance, receiverNewWalletBalance);

        return true;
      }
    } catch (e) {
      MPrint(e.toString());
      //ignore: use_build_context_synchronously
      MFeedback(context: context).error(e.toString());
      return false;
    }
  }

  recordTransfer(
      bool isCredit,
      String method,
      double amount,
      String transactionID,
      DateTime date,
      String senderID,
      String remark,
      double senderInitBalance,
      double senderNewBalance,
      String receiverID,
      double receiverInitBalance,
      double receiverNewBalance) async {
    DocumentSnapshot senderSnapshot = await firestore.collection("users").doc(senderID).get();
    DocumentSnapshot receiverSnapshot = await firestore.collection("users").doc(receiverID).get();
    UserDetails senderDetails = UserDetails.fromJson(senderSnapshot);
    UserDetails receiverDetails = UserDetails.fromJson(receiverSnapshot);

    try {
      await firestore
          .collection("users")
          .doc(isCredit ? receiverID : senderID)
          .collection(method)
          .doc(transactionID)
          .set({
        "amount": amount,
        "method": method,
        "isCredit": isCredit ? true : false,
        "date": date,
        "transactionID": transactionID,
        "remark": remark,
        "senderUsername": senderDetails.username,
        "senderID": senderDetails.uid,
        "senderWalletID": senderDetails.walletID,
        "senderInitBalance": senderInitBalance,
        "senderNewBalance": senderNewBalance,
        "receiverUsername": receiverDetails.username,
        "receiverID": receiverDetails.uid,
        "receiverWalletID": receiverDetails.walletID,
        "receiverInitBalance": receiverInitBalance,
        "receiverNewBalance": receiverNewBalance,
      });
      recordAllTransaction(isCredit, receiverID, senderID, transactionID, amount, method, date, senderDetails.username, receiverDetails.username);
    } catch (e) {
      MPrint(e.toString());
    }
  }

  recordAllTransaction(bool isCredit, String receiverID, String senderID, String transactionID,
      double amount, String method, DateTime date, String senderUsername, String receiverUsername) async{
    await firestore
        .collection("users")
        .doc(isCredit ? receiverID : senderID)
        .collection("allTransactions")
        .doc(transactionID)
        .set({
      "amount": amount,
      "method": method,
      "isCredit": isCredit ? true : false,
      "date": date,
      "transactionID": transactionID,
      "senderUsername": senderUsername,
      "receiverUsername": receiverUsername,
    });
  }

  Future<List<TransferInvoice>?> getWalletTransferHistory(BuildContext context, String userID) async {
    try {
      List<TransferInvoice> transferList = [];

      QuerySnapshot transfersSnapshot =
          await firestore.collection('users').doc(userID).collection('walletTransfers').get();
      var transactions = transfersSnapshot.docs;
      if (transactions.isNotEmpty) {
        for (var transaction in transactions) {
          if (transaction.exists) {
            TransferInvoice t = TransferInvoice.fromJson(transaction);
            transferList.add(t);
          }
        }
        return transferList;
      } else {
        MPrint('No transactions yet');
        return null;
      }
    } catch (e) {
      MPrint(e.toString());
      // ignore: use_build_context_synchronously
      MFeedback(context: context).error('Could not get fetch transaction history now, Try again later');
      return null;
    }
  }

  Future<List<AllTransaction>?> getAllTransferHistory(BuildContext context, String userID) async {
    try {
      List<AllTransaction> allTractionList = [];

      QuerySnapshot transfersSnapshot =
      await firestore.collection('users').doc(userID).collection('allTransactions').get();
      var transactions = transfersSnapshot.docs;
      if (transactions.isNotEmpty) {
        for (var transaction in transactions) {
          if (transaction.exists) {
            AllTransaction t = AllTransaction.fromJson(transaction);
            allTractionList.add(t);
          }
        }
        return allTractionList;
      } else {
        MPrint('No transactions yet');
        return null;
      }
    } catch (e) {
      MPrint(e.toString());
      // ignore: use_build_context_synchronously
      MFeedback(context: context).error('Could not get fetch transaction history now, Try again later');
      return null;
    }
  }

  Future<bool> buyAirtime(String userID, double amount, String phoneNumber, String serviceProvider) async{
    DocumentSnapshot userData = await firestore.collection("users").doc(userID).get();
    double initBal= 0;
    double newBal = 0;
    
    /// Date and time
    DateTime date = DateTime.now();

    /// Generate a transaction ID
    String transactionID = "Ref${Nonce(15)}";

    try{
      ///
      /// Debit user
      if(userData.exists){
        UserDetails user = UserDetails.fromJson(userData);
        initBal = user.walletBalance;

        newBal = initBal - amount;

        await firestore.collection("users").doc(userID).update({"walletBalance": newBal});

        ///
        /// Todo: Load airtime to phone number

        ///
        /// Record airtime transaction
        await recordAirtimePurchase(amount, date, transactionID, userID, initBal, newBal, phoneNumber, serviceProvider);

        ///
        /// Record airtime transaction in global
        await recordAllTransaction(false, phoneNumber, userID, transactionID, amount, "airtime", date, user.username, phoneNumber);
      }
    }catch(e){
      MPrint(e.toString());
      return false;
    }

    return true;
  }


  recordAirtimePurchase(
  double amount, DateTime date, String transactionID, 
      String userID, double userInitialBalance,
   double userNewBalance, String phoneNumber, String serviceProvider
      )async {
    try{
      await firestore.collection("users").doc(userID).collection("airtimePurchase").doc(transactionID).set({
        "amount": amount, "method": "airtime", "isCredit": false, "date": date, "transactionID": transactionID,
        "userID": userID, "userInitialBalance": userInitialBalance, "userNewBalance": userNewBalance,
        "phoneNumber": phoneNumber, "serviceProvider": serviceProvider
      });
    }catch(e){
      MPrint(e.toString());
    }
  }
}
