import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String uid;
  final String username;
  final String email;
  final String walletID;
  final double walletBalance;
  final double totalSavings;
  final double totalOwe;
  final int freeTransfers;
  final String image;
  final Timestamp date;
  final String signInMethod;

  UserDetails(
      {
        required this.uid,
      required this.username,
      required this.email,
      required this.walletID,
      required this.walletBalance,
      required this.totalSavings,
      required this.totalOwe,
      required this.freeTransfers,
      required this.image,
      required this.date,
      required this.signInMethod
      });

  factory UserDetails.fromJson(DocumentSnapshot snapshot) {
    return UserDetails(
        uid: snapshot['uid'],
        username: snapshot['username'],
        email: snapshot['email'],
        walletID: snapshot['walletID'],
        walletBalance: snapshot['walletBalance'].toDouble(),
        totalSavings: snapshot['totalSavings'].toDouble(),
        totalOwe: snapshot['totalOwe'].toDouble(),
        freeTransfers: snapshot['freeTransfers'],
        image: snapshot['image'],
        date: snapshot['date'],
        signInMethod: snapshot['signInMethod']
    );
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'username' : username,
    'email': email,
    'walletID' : walletID,
    'walletBalance': walletBalance,
    'totalSavings': totalSavings,
    'totalOwe': totalOwe,
    'freeTransfers': freeTransfers,
    'image': image,
    'date': date,
    'signInMethod': signInMethod
  };

}
