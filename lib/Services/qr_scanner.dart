import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kashwise/Services/my_printer.dart';

class QRScanner {
  Future<String?> scanQR() async {
   try{
     String resp = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', 'cancel', true, ScanMode.QR);
     return resp;
   }on PlatformException{
      MPrint(value: 'Failed to read QR Code');
      return null;
    }
  }
}
