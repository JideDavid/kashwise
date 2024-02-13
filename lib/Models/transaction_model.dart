import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String uid;
  final String username;
  final String email;
  final String walletTag;
  final double walletBalance;
  final double totalSavings;
  final double totalOwe;
  final int freeTransfers;
  final String image;
  final Timestamp date;
  final String signInMethod;

  Transaction({
    required this.uid,
    required this.username,
    required this.email,
    required this.walletTag,
    required this.walletBalance,
    required this.totalSavings,
    required this.totalOwe,
    required this.freeTransfers,
    required this.image,
    required this.date,
    required this.signInMethod});

  factory Transaction.fromJson(DocumentSnapshot snapshot) {
    return Transaction(
        uid: snapshot['uid'],
        username: snapshot['username'],
        email: snapshot['email'],
        walletTag: snapshot['walletTag'],
        walletBalance: snapshot['walletBalance'].toDouble(),
        totalSavings: snapshot['totalSavings'].toDouble(),
        totalOwe: snapshot['totalOwe'].toDouble(),
        freeTransfers: snapshot['freeTransfers'],
        image: snapshot['image'],
        date: snapshot['date'],
        signInMethod: snapshot['signInMethod']);
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'username' : username,
    'email': email,
    'walletTag' : walletTag,
    'walletBalance': walletBalance,
    'totalSavings': totalSavings,
    'totalOwe': totalOwe,
    'freeTransfers': freeTransfers,
    'image': image,
    'date': date,
    'signInMethod': signInMethod
  };

}
