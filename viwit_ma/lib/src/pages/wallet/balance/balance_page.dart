// @dart=2.9

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
        body: Query(
            options: QueryOptions(document: gql(getAllWallet), variables: {
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

              // Se recibe el saldo y se calcula el número de pasajes
              int balance = result.data["getWalletByUserId"]["data"]["balance"];
              int pasajes = (balance / 2300).floor();
              print(balance);

              return AlertDialog(
                  title: Text(
                    'Your balance is: \$' + balance.toString(),
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..color = Color(0xF0FFFFFF)),
                  ),
                  elevation: 5,
                  backgroundColor: Color(0xFF3399FF),
                  content:
                      Text('Ticket: $pasajes', textAlign: TextAlign.center),
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..color = Color(0xFF321FDB)));
            }));
  }
}
