// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';

class ScanPayment extends StatelessWidget {
  final String mutationPay = """
mutation{
  postCreateTransaction(transaction:{
    token:"hoy"
    wallet_id:1
    id_method_payment: 1
    mount:2300
    type: 0
  }){
    data{
    status
  }
  }
}
 """;
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
        backgroundColor: Color(0x6A636F83),
        body: Mutation(
          options: MutationOptions(
            document: gql(
                mutationPay), // this is the mutation string you just created
            // you can update the cache based on results
            update: (GraphQLDataProxy cache, QueryResult result) {
              return cache;
            },
            // or do something with the result.data on completion
            onCompleted: (dynamic resultData) {
              print(resultData);
            },
          ),
          builder: (
            RunMutation runMutation,
            QueryResult result,
          ) {
            return AlertDialog(
                title: Text(('Confirmacion pago'),
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mandali()),
                elevation: 5,
                actions: [
                  FlatButton(
                    child: Text(('Cancelar'),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Colors.white)),
                    onPressed: () {
                      uiProvider.setSelectedOptionNavegationBar = 0;
                    },
                  ),
                  FlatButton(
                    child: Text(('Aceptar'),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Colors.white)),
                    onPressed: () {
                      print(mutationPay);
                      runMutation({
                        'starrableId': 1,
                      });
                      uiProvider.setSelectedOptionNavegationBar = 0;
                    },
                  )
                ],
                backgroundColor: Color(0xCA3399FF),
                content: Text(
                  '¿Estas de acuerdo con el pago del pasaje?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mandali(color: Color(0xFFCED2D8)),
                  textScaleFactor: 1.5,
                ),
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..color = Color(0xFF321FDB)));
          },
        ));
  }
}
