import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import '../classes/payment.dart';

import 'package:viwit_ma/src/classes/payment.dart';

import '../providers/UI_Provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(GraphQLClient(
            link: uiProvider.getIpgraphQL, cache: GraphQLCache()));

    return Container(
      height: 80.0,
      width: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: Color(0xCA3399FF),
          child: Icon(Icons.qr_code_scanner_sharp),
          onPressed: () async {
            String qr = await FlutterBarcodeScanner.scanBarcode(
                '#00CF77', 'Cancelar', false, ScanMode.QR);
            //PaymenClass payment = new PaymenClass();
            //payment.setBalance =
              //  json.decode(utf8.decode(base64.decode(qr)))['balance'];
            //print(payment);
            uiProvider.setQrCode = qr;
            uiProvider.setSelectedOptionNavegationBar = 3;
          },
        ),
      ),
    );
  }
}
