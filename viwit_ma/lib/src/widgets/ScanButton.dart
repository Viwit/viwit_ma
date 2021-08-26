import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/services/graphql.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProviderUser>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      height: 80.0,
      width: 80.0,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: Color(0xFF636F83),
          child: Icon(Icons.qr_code_scanner_sharp),
          onPressed: () async {
            String qr = await FlutterBarcodeScanner.scanBarcode(
                '#00CF77', 'Cancelar', false, ScanMode.QR);
            
            //Validacion UserType
            if(userProvider.getUser_type == 2){
              Graphql graphQuery = new Graphql();
              Map qrInput = json.decode(utf8.decode(base64.decode(qr)));
              String paymentQuery = """mutation{
                                  postCreateTransaction(transaction:{
                                    token:"${qrInput['token']}",
                                    wallet_id:${qrInput['id']},
                                    id_method_payment:1,
                                    mount:2300,
                                    type:0
                                  }){
                                    data{
                                      id,
                                      id_method_payment,
                                      mount,
                                      status
                                    }
                                  }
                                }""";

              String addQuery = """mutation{
                                  postCreateTransaction(transaction:{
                                    token:"generico",
                                    wallet_id:${userProvider.getUserId},
                                    id_method_payment:1,
                                    mount:2300,
                                    type:1
                                  }){
                                    data{
                                      id,
                                      id_method_payment,
                                      mount,
                                      status
                                    }
                                  }
                                }""";

              Map payment = await graphQuery.queryOrMutation(paymentQuery);
              Map add = await graphQuery.queryOrMutation(addQuery);
            }
          },
        ),
      ),
    );
  }
}
