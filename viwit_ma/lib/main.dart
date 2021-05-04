import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/bloc/NavegationbarBloc.dart';
import 'package:viwit_ma/src/pages/Home.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {'home': (_) => Home()},
      ),
    );
  }
}
