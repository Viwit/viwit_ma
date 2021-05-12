import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/userPages/HomeUser.dart';
import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';
import 'package:viwit_ma/src/providers/uiProvider/bus/UiProviderBus.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/pages/Login.dart';
import 'package:viwit_ma/src/pages/Register.dart';
import 'package:viwit_ma/src/pages/userPages/messagesUser/RegisterUser.dart';
import 'package:viwit_ma/src/pages/messages/LoginMessage.dart';
import 'package:viwit_ma/src/pages/busPages/HomeBus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProviderUser()),
        ChangeNotifierProvider(create: (_) => new UserProvider()),
        ChangeNotifierProvider(create: (_) => new UiProviderBus()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'login',
        routes: {
          'user': (_) => HomeUser(),
          'login': (_) => LoginUser(),
          'register': (_) => RegisterUser(),
          'registerCconfirm': (_) => RegisterUserMutation(),
          'loginWelcome': (_) => LoginMessage(),
          'bus': (_) => HomeBus()
        },
      ),
    );
  }
}
