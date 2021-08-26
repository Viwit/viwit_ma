import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';

class NavegationBar extends StatefulWidget {
  @override
  _NavegationBarState createState() => _NavegationBarState();
}

class _NavegationBarState extends State<NavegationBar> {
  @override
  Widget build(BuildContext context) {
    final uiProviderUser = Provider.of<UiProviderUser>(context);
    final indexNavegationBar = uiProviderUser.getSelectedOptionNavegationBar;
    final indexNavegationBar2 =
        indexNavegationBar <= 3 ? indexNavegationBar : 0;
    return BottomNavigationBar(
      onTap: (int option) => {
        uiProviderUser.setSelectedOptionNavegationBar = option,
      },
      currentIndex: indexNavegationBar2,
      backgroundColor: Color(0xFFCED2D8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Color(0xDA3399FF),
            icon: Icon(Icons.attach_money),
            label: "Saldo"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Crear QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: "Transacciones"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined), label: "Recargar"),
        BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.local_police_sharp),
            label: "Emergencia")
      ],
    );
  }
}
