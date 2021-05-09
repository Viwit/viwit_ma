import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';

class NavegationBar extends StatefulWidget {
  @override
  _NavegationBarState createState() => _NavegationBarState();
}

class _NavegationBarState extends State<NavegationBar> {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final indexNavegationBar = uiProvider.getSelectedOptionNavegationBar;
    final indexNavegationBar2 =
        indexNavegationBar <= 2 ? indexNavegationBar : 1;
    return BottomNavigationBar(
      onTap: (int option) =>
          {uiProvider.setSelectedOptionNavegationBar = option},
      currentIndex: indexNavegationBar2,
      backgroundColor: Color(0xFFCED2D8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Color(0xFF03F7A2),
            icon: Icon(Icons.attach_money),
            label: "Saldo"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Crear QR"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Recargar"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: "Transacciones")
      ],
    );
  }
}
