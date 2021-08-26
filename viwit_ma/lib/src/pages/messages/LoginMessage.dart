// @dart=2.9

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/pages/userPages/HomeUser.dart';
import 'package:viwit_ma/src/pages/busPages/HomeBus.dart';
import 'package:viwit_ma/src/services/graphql.dart';
import '../Login.dart';

class LoginMessage extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client = new ValueNotifier<GraphQLClient>(
      GraphQLClient(
          link: HttpLink((new Graphql()).getHttpLink),
          cache: GraphQLCache()));
  final String getAllWallet = r"""
                                query($id: Int!){
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
    final uiProviderUser = Provider.of<UiProviderUser>(context);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
            backgroundColor: Color(0x1F321FDB),
            body: Query(
                options: QueryOptions(
                    document: gql(getAllWallet), variables: {"id": userProvider.getUserId}),
                //Debe recibir el id de la billetera del usuario
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    return AlertDialog(
                        title: Text(('¡ Error ! ${result.exception}'),
                            textScaleFactor: 2,
                            textAlign: TextAlign.center,
                            style:
                                GoogleFonts.mandali(color: Color(0xFFFFFFFF))),
                        elevation: 5,
                        actions: [
                          FlatButton(
                            child: Text(('Ok'),
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    GoogleFonts.mandali(color: Colors.white)),
                            onPressed: () {
                              userProvider.setUserId = null;
                              uiProviderUser.setOptionLogOut = 0;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginUser()),
                              );
                            },
                          )
                        ],
                        backgroundColor: Color(0xFF3399FF),
                        content: Text(
                          'Verifica tu conexión o tus datos',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mandali(color: Color(0xFFFFFFFF)),
                          textScaleFactor: 1.5,
                        ),
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..color = Color(0xFF321FDB)));
                  }

                  if (result.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return AlertDialog(
                      title: Text(('¡ Hola !'),
                          textScaleFactor: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mandali(color: Color(0xFFFFFFFF))),
                      elevation: 5,
                      actions: [
                        FlatButton(
                          child: Text(('Ok'),
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mandali(color: Colors.white)),
                          onPressed: () {
                            if (userProvider.getUser_type == 1) {
                              uiProviderUser.setOptionLogOut = 0;
                              //Home User
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeUser()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeBus()),
                              );
                            }
                          },
                        )
                      ],
                      backgroundColor: Color(0xFF3399FF),
                      content: Text(
                        'Bienvenido :)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Color(0xFFFFFFFF)),
                        textScaleFactor: 1.5,
                      ),
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..color = Color(0xFF321FDB)));
                })),
      ),
    );
  }
}
