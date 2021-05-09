import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/userPages/balanceUser/BalancePage.dart';
import 'package:viwit_ma/src/pages/userPages/balanceUser/TransactionPage.dart';
import 'package:viwit_ma/src/pages/userPages/balanceUser/ScanPayment.dart';
import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';
import 'package:viwit_ma/src/pages/userPages/qrCodeUser/GenerateQr.dart';
import 'package:viwit_ma/src/pages/userPages/messagesUser/RegisterUser.dart';

class RouterMainMenu extends StatelessWidget {
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
