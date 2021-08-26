import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/providers/uiProvider/bus/UiProviderBus.dart';

class NavegationBarBus extends StatefulWidget {
  @override
  _NavegationBarBusState createState() => _NavegationBarBusState();
}

class _NavegationBarBusState extends State<NavegationBarBus> {
  @override
  Widget build(BuildContext context) {
    final uiProviderBus = Provider.of<UiProviderBus>(context);
    final indexNavegationBarBus = uiProviderBus.getSelectedOptionNavegationBar;
    final indexNavegationBarBus2 =
        indexNavegationBarBus <= 2 ? indexNavegationBarBus : 0;
    return BottomNavigationBar(
      onTap: (int option) => {
        uiProviderBus.setSelectedOptionNavegationBar = option,
      },
      currentIndex: indexNavegationBarBus2,
      backgroundColor: Color(0xFFCED2D8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Color(0xDA3399FF),
            icon: Icon(Icons.attach_money),
            label: "Saldo"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: "Transacciones"),
        BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.local_police_sharp),
            label: "Emergencia")
      ],
    );
  }
}
