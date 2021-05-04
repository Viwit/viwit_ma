//import 'dart:html';
// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:viwit_ma/src/providers/User_Provider.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final String getData = r"""
query($id: Int!){
  getWalletByUserId(id: $id){
    data{
      balance
      token
      user_id
      id
    }
  }
}
 """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Query(
            options: QueryOptions(document: gql(getData), variables: {
              "id": 1
            }), //Debe recibir el id de la billetera del usuario
            builder: (result, {fetchMore, refetch}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Se recibe la data
              var qrData = result.data["getWalletByUserId"]["data"];
              print(qrData.toString());

              //Se verifica si se puede enerar el código
              if (qrData["balance"] < 2300) {
                CustomAlertDialog customAlertDialog = new CustomAlertDialog();
                return AlertDialog(
                    title: Text(
                      'Insufficient balance',
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..color = Color(0xF0EBEDEF)),
                    ),
                    elevation: 5,
                    backgroundColor: Color(0xFF3399FF),
                    content: Text(
                        'You do not have the minimum balance to generate a QR code :('),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..color = Color(0xFF321FDB)));
              } else {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      QrImage(data: qrData.toString()),
                      Column(
                        children: [
                          Text(
                            "Approach  your phone to the reader to make the payment.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                foreground: Paint()..color = Color(0xF0636F83),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            }));
  }
}

class CustomAlertDialog {
  Future<void> _showMyDialog(
      BuildContext contextDialog, String tittle, String message) async {
    return showDialog<void>(
      context: contextDialog,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tittle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(message)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
