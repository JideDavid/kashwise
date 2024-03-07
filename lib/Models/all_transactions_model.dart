import 'package:cloud_firestore/cloud_firestore.dart';

class AllTransaction {
  double amount;
  final String method;
  final bool isCredit;
  final Timestamp date;
  final String transactionID;
  final String senderUsername;
  final String receiverUsername;

  AllTransaction(
      {required this.amount,
      required this.method,
      required this.isCredit,
      required this.date,
      required this.transactionID,
      required this.senderUsername,
      required this.receiverUsername});

  factory AllTransaction.fromJson(DocumentSnapshot snapshot) {
    return AllTransaction(
        amount: snapshot['amount'],
        method: snapshot['method'],
        isCredit: snapshot['isCredit'],
        date: snapshot['date'],
        transactionID: snapshot['transactionID'],
        senderUsername: snapshot['senderUsername'],
        receiverUsername: snapshot['receiverUsername']);
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'method': method,
        'isCredit': isCredit,
        'date': date,
        'transactionID': transactionID,
        'senderUsername': senderUsername,
        'receiverUsername': receiverUsername
      };
}
