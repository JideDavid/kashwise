import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kashwise/Services/my_printer.dart';

import '../Models/user_model.dart';

class FirebaseHelper{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkUsernameExist(String username) async {

    bool nameExists = false;
    var docs;

    ///
    /// Getting users query snapshots from firestore
    try{
      QuerySnapshot snapshot = await firestore.collection('users').get();
      docs = snapshot.docs;
    }
    catch (e){
      MPrint(value: '>>>>> error getting users from firestore: $e <<<<<');
      return false;
    }

    if(docs == null){
      MPrint(value: 'No users on db yet');
      nameExists = false;
      return nameExists;
    }
    else{
      for(var doc in docs){
        if(username == doc['username']){
          nameExists = true;
        }
      }
      return nameExists;
    }

  }

  Future<bool> checkEmailExist(String email) async {

    bool emailExist = false;
    var docs;

    ///
    /// Getting users query snapshots from firestore
    try{
      QuerySnapshot snapshot = await firestore.collection('users').get();
      docs = snapshot.docs;
    }
    catch (e){
      MPrint(value: '>>>>> error getting users from firestore: $e <<<<<');
      return false;
    }

    if(docs == null){
      MPrint(value: 'No users on db yet');
      emailExist = false;
      return emailExist;
    }
    else{
      for(var doc in docs){
        if(email.toLowerCase() == doc['email'].toString().toLowerCase()){
          emailExist = true;
        }
      }
      return emailExist;
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await  firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    catch(e){
      MPrint(value: e.toString());
      return null;
    }
  }

  Future<UserDetails?> loginWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await firestore.collection('users').doc(userCredential.user!.uid).get();
      UserDetails account = UserDetails.fromJson(snapshot);
      return account;
    }
    catch(e){
      MPrint(value: e.toString());
      return null;
    }
  }

  Future<String?> getSignInMethod( String email) async{

    bool emailExist = false;
    var docs;

    ///
    /// Getting users query snapshots from firestore
    try{
      QuerySnapshot snapshot = await firestore.collection('users').get();
      docs = snapshot.docs;
      if(docs == null){
        MPrint(value: 'No users on db yet');
        emailExist = false;
        return null;
      }
      else{
        for(var doc in docs){
          if(email.toLowerCase() == doc['email'].toString().toLowerCase()){
            emailExist = true;
            if(emailExist){
              return doc['signInMethod'].toString().toLowerCase();
            }
          }
        }
      }
    }
    catch (e){
      MPrint(value: '>>>>> error getting users from firestore: $e <<<<<');
      return null;
    }
    return null;
  }

}