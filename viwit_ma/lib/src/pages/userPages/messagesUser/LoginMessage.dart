// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/pages/Home.dart';

class LoginMessage extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client = new ValueNotifier<GraphQLClient>(
      GraphQLClient(
          link: HttpLink('http://23.22.177.41:3000/graphql'),
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
    final uiProvider = Provider.of<UiProvider>(context);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          backgroundColor: Color(0x2F8899FF),
            body: Query(
                options: QueryOptions(
                    document: gql(getAllWallet), variables: {"id": 1}),
                //Debe recibir el id de la billetera del usuario
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
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
                            userProvider.setUserId = 1;
                            uiProvider.setOptionLogOut = 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
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
