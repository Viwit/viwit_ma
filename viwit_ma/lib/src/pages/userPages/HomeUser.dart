import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/Login.dart';
import 'package:viwit_ma/src/pages/userPages/RouterUser.dart';
import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';
import 'package:viwit_ma/src/widgets/userWidget/UserNavegationBar.dart';
import 'package:viwit_ma/src/widgets/ScanButton.dart';
import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';

class HomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final uiProviderUser = Provider.of<UiProviderUser>(context);
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
                onPressed: () {
                  userProvider.logOut();
                  int op = uiProviderUser.getOptionLogOut;
                  if (op == 0) {
                    Navigator.of(context)..pop()..pop();
                  } else {
                    Navigator.of(context)
                      ..pop()
                      ..push(
                        MaterialPageRoute(builder: (context) => LoginUser()),
                      );
                  }
                }),
            backgroundColor: Color(0xCA3399FF),
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
    return RouterMainMenu();
  }
}
