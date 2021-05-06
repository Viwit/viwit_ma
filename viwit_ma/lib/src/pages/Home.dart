import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/Router_Homepage.dart';
import 'package:viwit_ma/src/widgets/NavegationBar.dart';
import 'package:viwit_ma/src/widgets/ScanButton.dart';

import '../providers/UI_Provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    uiProvider.setContextUi = context;
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Viwit',
              textScaleFactor: 2,
              style: GoogleFonts.mandali(),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Color(0xFA636F83),
            elevation: 5,
          ),
          body: _HomePageBody(),
          bottomNavigationBar: NavegationBar(),
          floatingActionButton: ScanButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WalletPage();
  }
}
