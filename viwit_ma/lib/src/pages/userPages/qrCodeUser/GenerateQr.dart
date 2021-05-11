//import 'dart:html';
// @dart=2.9

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:viwit_ma/src/complements/Emojis.dart';

import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';

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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Color(0x2F8899FF),
        body: Query(
            options: QueryOptions(document: gql(getData), variables: {
              "id": userProvider.getUserId
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
              print(base64.encode(utf8.encode(json.encode(qrData))));

              //Se verifica si se puede enerar el código
              if (qrData["balance"] < 2300) {
                return AlertDialog(
                  title: Text(
                    'Saldo insuficiente',
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mandali(color: Color(0xFFFFFFFF)),
                  ),
                  elevation: 10,
                  backgroundColor: Color(0xFF3399FF),
                  content: EmojiText(
                    text:
                        'No tienes el saldo necesario para generar un codigo QR \n😞',
                  ),
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..color = Color(0xFF2838FE)),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      QrImage(
                          data:
                              base64.encode(utf8.encode(json.encode(qrData)))),
                      Column(
                        children: [
                          Text(
                            "Acerque su teléfono al lector para realizar el pago.",
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
