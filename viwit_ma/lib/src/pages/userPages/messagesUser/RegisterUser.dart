// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/userPages/HomeUser.dart';
import 'package:viwit_ma/src/pages/Login.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';

class RegisterUserMutation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(GraphQLClient(
            link: HttpLink('http://23.22.177.41:3000/graphql'),
            cache: GraphQLCache()));
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: RegisterUserMu(),
      ),
    );
  }
}

class RegisterUserMu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProviderUser = Provider.of<UiProviderUser>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Color(0x1F321FDB),
        body: Mutation(
          options: MutationOptions(
            document: gql("""
                          mutation{
                            setUser(user:{
                              Firstname: "${userProvider.getFirstname}"
                              Lastname: "${userProvider.getLastname}"
                              Email: "${userProvider.getEmail}"
                              User_password: "${userProvider.getPassword}"
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
              try {
                userProvider.setUserId = resultData['setUser']['User_id'];
                uiProviderUser.setOptionLogOut = 1;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeUser()),
                );
              } catch (e) {
                Navigator.pop(context);
              }
            },
            onError: (error) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginUser()),
              );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginUser()),
                      );
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
