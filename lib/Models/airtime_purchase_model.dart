import 'package:cloud_firestore/cloud_firestore.dart';

class AirtimeInvoice{
  final double amount;
  final String method;
  final bool isCredit;
  final Timestamp date;
  final String transactionID;
  final String userID;
  final double userInitialBalance;
  final double userNewBalance;
  final String phoneNumber;
  final String serviceProvider;

  AirtimeInvoice({
    required this.amount,
    required this.method,
    required this.isCredit,
    required this.date,
    required this.transactionID,
    required this.userID,
    required this.userInitialBalance,
    required this.userNewBalance,
    required this.phoneNumber,
    required this.serviceProvider,
  });

  factory AirtimeInvoice.fromJson(DocumentSnapshot snapshot) {
    return AirtimeInvoice(
      amount: snapshot['amount'],
      method: snapshot['method'],
      isCredit: snapshot['isCredit'],
      date: snapshot['date'],
      transactionID: snapshot['transactionID'],
      userID: snapshot['userID'],
      userInitialBalance: snapshot['userInitialBalance'],
      userNewBalance: snapshot['userNewBalance'],
      phoneNumber: snapshot['phoneNumber'],
      serviceProvider: snapshot['serviceProvider'],
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'method': method,
    'isCredit': isCredit,
    'date': date,
    'transactionID': transactionID,
    'userID': userID,
    'userInitialBalance': userInitialBalance,
    'userNewBalance': userNewBalance,
    'phoneNumber': phoneNumber,
    'serviceProvider': serviceProvider,
  };

}