// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:viwit_ma/src/providers/User_Provider.dart';

class BalancePage extends StatelessWidget {
  final String getAllWallet = r"""
query($id: Int!)
{
getWalletByUserId(id: $id){
  data{
    balance
  }
}
}
 """;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    return Scaffold(
        body: Query(
            options: QueryOptions(document: gql(getAllWallet), variables: {
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

              // Se recibe el saldo y se calcula el número de pasajes
              int balance = result.data["getWalletByUserId"]["data"]["balance"];
              int pasajes = (balance / 2300).floor();
              print(balance);

              return AlertDialog(
                  title: Text(
                      ('Tu saldo es:\n\$ ' + currencyFormat.format(balance)),
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mandali(color: Color(0xFFFFFFFF))),
                  elevation: 5,
                  backgroundColor: Color(0xFF3399FF),
                  content: Text(
                    'Pasaje: ${pasajes.toString()}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mandali(color: Color(0xFFFFFFFF)),
                    textScaleFactor: 1.5,
                  ),
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..color = Color(0xFF321FDB)));
            }));
  }
}
