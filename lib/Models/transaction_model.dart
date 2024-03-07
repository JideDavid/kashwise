import 'package:cloud_firestore/cloud_firestore.dart';

class Transfer {
  double amount;
  final String method;
  final bool isCredit;
  final Timestamp date;

  // transfer
  final String transactionID;
  final String remark;
  final String senderUsername;
  final String senderID;
  final String senderWalletID;
  final double senderInitBalance;
  final double senderNewBalance;
  final String receiverUsername;
  final String receiverID;
  final String receiverWalletID;
  final double receiverInitBalance;
  final double receiverNewBalance;

  Transfer({
    required this.amount,
    required this.method,
    required this.isCredit,
    required this.date,

    // transfer
    required this.transactionID,
    required this.remark,
    required this.senderUsername,
    required this.senderID,
    required this.senderWalletID,
    required this.senderInitBalance,
    required this.senderNewBalance,
    required this.receiverUsername,
    required this.receiverID,
    required this.receiverWalletID,
    required this.receiverInitBalance,
    required this.receiverNewBalance,
  });

  factory Transfer.fromJson(DocumentSnapshot snapshot) {
    return Transfer(
      amount: snapshot['amount'],
      method: snapshot['method'],
      isCredit: snapshot['isCredit'],
      date: snapshot['date'],
      transactionID: snapshot['transactionID'],
      remark: snapshot['remark'],
      senderUsername: snapshot['senderUsername'],
      senderID: snapshot['senderID'],
      senderWalletID: snapshot['senderWalletID'],
      senderInitBalance: snapshot['senderInitBalance'],
      senderNewBalance: snapshot['senderNewBalance'],
      receiverUsername: snapshot['receiverUsername'],
      receiverID: snapshot['receiverID'],
      receiverWalletID: snapshot['receiverWalletID'],
      receiverInitBalance: snapshot['receiverInitBalance'],
      receiverNewBalance: snapshot['receiverNewBalance'],
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'method': method,
        'isCredit': isCredit,
        'date': date,
        'transactionID': transactionID,
        'remark': remark,
        'senderUsername': senderUsername,
        'senderID': senderID,
        'senderWalletID': senderWalletID,
        'senderInitBalance': senderInitBalance,
        'senderNewBalance': senderNewBalance,
        'receiverUsername': receiverUsername,
        'receiverID': receiverID,
        'receiverWalletID': receiverWalletID,
        'receiverInitBalance': receiverInitBalance,
        'receiverNewBalance': receiverNewBalance,
      };
}
