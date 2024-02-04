class QRPayRequest{
  final bool isValid;
  final bool hasAmount;
  final String walletTag;
  final String username;
  final double amount;

  QRPayRequest({required this.isValid, required this.hasAmount, required this.walletTag, required this.username, required this.amount});

  factory QRPayRequest.fromJson(Map<String, dynamic> payRequest){
    return QRPayRequest(isValid: payRequest['isValid'], hasAmount: payRequest['hasAmount'], walletTag: payRequest['walletTag'], username: payRequest['username'], amount: payRequest['amount']);
  }

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'hasAmount': hasAmount,
    'walletTag': walletTag,
    'username': username,
    'amount': amount
  };
}