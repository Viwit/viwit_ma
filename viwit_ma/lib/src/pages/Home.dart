import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/wallet/balance/wallet_page.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';
import 'package:viwit_ma/src/widgets/NavegationBar.dart';
import 'package:viwit_ma/src/widgets/ScanButton.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${uiProvider.getSelectedOptionAppNavBar}',
          textScaleFactor: 2,
        ),
        backgroundColor: Color(0xFA636F83),
        elevation: 5,
      ),
      body: _HomePageBody(),
      bottomNavigationBar: NavegationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WalletPage();
  }
}
