import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/wallet/balance/balance_page.dart';
import 'package:viwit_ma/src/pages/wallet/balance/transaction_page.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';
import '../qr_code/generate_QR.dart';

class WalletPage extends StatelessWidget {
  final HttpLink httpLink = new HttpLink('http://23.22.177.41:3000/graphql');

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
            GraphQLClient(link: httpLink, cache: GraphQLCache()));

    final uiProvider = Provider.of<UiProvider>(context);
    final indexNavegationBar = uiProvider.getSelectedOptionNavegationBar;

    switch (indexNavegationBar) {
      case 0:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: BalancePage(),
          ),
        );
        break;
      case 1:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: Generate(),
          ),
        );
        break;
      case 2:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: TransactionPage(),
          ),
        );
        break;
      default:
        uiProvider.setSelectedOptionAppNavBar = "Viwit - QR Code";
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: Generate(),
          ),
        );
    }
  }
}
