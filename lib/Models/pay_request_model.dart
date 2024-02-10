class QRPayRequest{
  final bool isValid;
  final bool hasAmount;
  final String walletTag;
  final String username;
  final double amount;
  final String uid;

  QRPayRequest({required this.isValid, required this.hasAmount, required this.walletTag, required this.username, required this.amount, required this.uid});

  factory QRPayRequest.fromJson(Map<String, dynamic> payRequest){
    return QRPayRequest(isValid: payRequest['isValid'], hasAmount: payRequest['hasAmount'], walletTag: payRequest['walletTag'], username: payRequest['username'], amount: payRequest['amount'], uid: payRequest['uid']);
  }

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'hasAmount': hasAmount,
    'walletTag': walletTag,
    'username': username,
    'amount': amount,
    'uid': uid,
  };
}