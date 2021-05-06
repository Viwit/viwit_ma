// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';

class RegisterUserMutation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
        backgroundColor: Color(0x6A636F83),
        body: Mutation(
          options: MutationOptions(
            document: gql("""
                          mutation{
                            setUser(user:{
                              Firstname: "${uiProvider.getfirstname}"
                              Lastname: "${uiProvider.getlastname}"
                              Email: "${uiProvider.getemail}"
                              User_password: "${uiProvider.getPassword}"
                              Block_account: false
                              User_type: 1
                            }){
                              User_id
                              Firstname
                              Lastname
                              Lastname
                              Email
                              Reg_date
                              User_type
                              __typename
                            }
                          }
                          """), // this is the mutation string you just created
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
                title: Text(('Confirmacion registro'),
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mandali()),
                elevation: 5,
                actions: [
                  FlatButton(
                    child: Text(('No'),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(uiProvider.getContextUi, 'login');
                    },
                  ),
                  FlatButton(
                    child: Text(('Si'),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Colors.white)),
                    onPressed: () {
                      runMutation({
                        'starrableId': 1,
                      });
                      Navigator.pushNamed(uiProvider.getContextUi, 'login');
                    },
                  )
                ],
                backgroundColor: Color(0xCA3399FF),
                content: Text(
                  '¿Estas seguro?',
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
