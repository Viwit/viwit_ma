// @dart=2.9

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TransactionPage extends StatelessWidget {
  final String getTransactions = r"""
query($id: Int!){
getTransactionsByWalletId(id: $id){
  data{
    status
    mount
    date
    type
  }
}
}
 """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Query(
            options: QueryOptions(document: gql(getTransactions), variables: {
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

              List transactionsR =
                  result.data["getTransactionsByWalletId"]["data"];
              List transactions = new List.from(transactionsR.reversed);
              if (transactions.length == 0) {
                return Container(
                  child: Text(
                    "No tienes transacciones :(.",
                    textAlign: TextAlign.justify,
                  ),
                  alignment: Alignment.center,
                );
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Color(0xFFFFFFFF),
                        ),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final status = transactions[index]["status"];
                      final mount = transactions[index]["mount"];
                      final date = transactions[index]["date"];
                      var kind = transactions[index]["type"];
                      if (kind == 1) {
                        kind = "Recarga";
                      } else {
                        kind = "Pago pasaje";
                      }
                      return ListTile(
                          tileColor: Color(0x0F321FDB),
                          title: Column(
                            children: [
                              Text(
                                kind,
                                textScaleFactor: 2,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Monto : \$" + mount.toString()),
                              Text("Estado: " + status),
                              Text("Fecha : " + date),
                            ],
                          ),
                          subtitle: Text("Trans: " + (++index).toString()));
                    });
              }
            }));
  }
}
