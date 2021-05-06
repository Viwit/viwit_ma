import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/userInterface/wallet/balance/balance_page.dart';
import 'package:viwit_ma/src/pages/userInterface/wallet/balance/transaction_page.dart';
import 'package:viwit_ma/src/pages/userInterface/wallet/balance/scanPayment.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';
import 'package:viwit_ma/src/pages/userInterface/wallet/qr_code/generate_QR.dart';
import 'package:viwit_ma/src/pages/userInterface/wallet/balance/registerUser.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final indexNavegationBar = uiProvider.getSelectedOptionNavegationBar;

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(GraphQLClient(
            link: uiProvider.getIpgraphQL, cache: GraphQLCache()));

    /*
     * 0 -> Menu principal: Saldo          |
     * 1 -> Menu principal: Generar QR     | ==> Menu <==
     * 2 -> Menu principal: Transacciones  |
     * 3 -> Confirmacion Pago
     * default -> Saldo
    */

    switch (indexNavegationBar) {

      // Menu principal: Saldo
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

      // Menu principal: Generar QR
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

      // Menu principal: Transacciones
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

      // Menu principal: Transacciones
      case 3:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: ScanPayment(),
          ),
        );
        break;

      // Menu principal: Transacciones
      case 4:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: RegisterUserMutation(),
          ),
        );
        break;

      // deafult: Saldo
      default:
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
