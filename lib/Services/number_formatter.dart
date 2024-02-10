import 'package:intl/intl.dart';

class NumberFormatter{

  String formatAmount(double amount) {
    var f = NumberFormat('###,##0.00', 'en_US');
    return f.format(amount);
  }
}