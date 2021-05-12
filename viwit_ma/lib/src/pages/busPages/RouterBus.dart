import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/busPages/balanceBus/BalancePageBus.dart';
import 'package:viwit_ma/src/pages/busPages/balanceBus/TransactionPageBus.dart';
import 'package:viwit_ma/src/providers/uiProvider/bus/UiProviderBus.dart';

class RouterMainMenuBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProviderBus = Provider.of<UiProviderBus>(context);
    final indexNavegationBar = uiProviderBus.getSelectedOptionNavegationBar;

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(GraphQLClient(
            link: uiProviderBus.getIpgraphQL, cache: GraphQLCache()));

    /*
     * 0 -> Menu principal: Saldo          |
     * 1 -> Menu principal: Transacciones  | ==> Menu <==
     * 3 -> Menu principal: Emergencia     |
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
            home: BalancePageBus(),
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
            home: TransactionPageBus(),
          ),
        );
        break;

      // Menu principal: Escanear
      case 2:
        final sizeScreen = MediaQuery.of(context).size;
        return Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: Stack(children: <Widget>[
              Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                      width: double.infinity, height: sizeScreen.height * 0.4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFFFFFF), //button's fill color
                      onPrimary: Colors
                          .red, //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                      onSurface: Colors
                          .red, //specify the button's disabled text, icon, and fill color
                      shadowColor:
                          Colors.red, //specify the button's elevation color
                      elevation: 6.0, //buttons Material shadow
                      textStyle: TextStyle(
                          fontFamily:
                              'roboto'), //specify the button's text TextStyle
                      padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4.0,
                          right: 8.0,
                          left: 8.0), //specify the button's Padding
                      minimumSize: Size(20,
                          40), //specify the button's first: width and second: height
                      side: BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                          style: BorderStyle.solid), //set border for the button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0)), // set the buttons shape. Make its birders rounded etc
                      enabledMouseCursor: MouseCursor
                          .defer, //used to construct ButtonStyle.mouseCursor
                      disabledMouseCursor: MouseCursor
                          .uncontrolled, //used to construct ButtonStyle.mouseCursor
                      visualDensity: VisualDensity(
                          horizontal: 0.0,
                          vertical: 0.0), //set the button's visual density
                      tapTargetSize: MaterialTapTargetSize
                          .padded, // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                      animationDuration: Duration(
                          milliseconds: 100), //the buttons animations duration
                      enableFeedback:
                          true, //to set the feedback to true or false
                      alignment: Alignment
                          .bottomCenter, //set the button's child Alignment
                    ),
                    child: Text('Llamar a emergencias\n🆘 🚨',
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(color: Colors.black87)),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber('123');
                    },
                  )
                ],
              )),
            ]));
        break;

      // deafult: Saldo
      default:
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: BalancePageBus(),
          ),
        );
    }
  }
}
