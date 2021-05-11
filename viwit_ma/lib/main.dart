import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/Home.dart';
import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/pages/Login.dart';
import 'package:viwit_ma/src/pages/Register.dart';
import 'package:viwit_ma/src/pages/userPages/messagesUser/RegisterUser.dart';
import 'package:viwit_ma/src/pages/userPages/messagesUser/LoginMessage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'login',
        routes: {
          'home': (_) => Home(),
          'login': (_) => LoginUser(),
          'register': (_) => RegisterUser(),
          'confirmRegister': (_) => RegisterUserMutation(),
          'messageLogin': (_) => LoginMessage()
        },
      ),
    );
  }
}
