import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: Color(0xCA3399FF),
          child: Icon(Icons.qr_code_scanner_sharp),
          onPressed: () async {
            String qrScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#00CF77', 'Cancelar', false, ScanMode.QR);
            print(qrScanRes);
          },
        ),
      ),
    );
  }
}
