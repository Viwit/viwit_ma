import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/busPages/RouterBus.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/widgets/busWidget/BusNavegationBar.dart';
import 'package:viwit_ma/src/widgets/ScanButton.dart';

class HomeBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Viwit - Bus',
              textScaleFactor: 2,
              style: GoogleFonts.mandali(),
            ),
            leading: new IconButton(
                icon: new Icon(Icons.logout),
                onPressed: () {
                  userProvider.logOut();
                  Navigator.of(context)..pop()..pop();
                }),
            backgroundColor: Color(0xCA3399FF),
            elevation: 5,
          ),
          body: _HomePageBody(),
          bottomNavigationBar: NavegationBarBus(),
          floatingActionButton: ScanButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RouterMainMenuBus();
  }
}
