import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/bloc/NavegationbarBloc.dart';
import 'package:viwit_ma/src/providers/UI_Provider.dart';

class NavegationBar extends StatefulWidget {
  @override
  _NavegationBarState createState() => _NavegationBarState();
}

class _NavegationBarState extends State<NavegationBar> {
  NavegationbarBloc optionNavegationbarBloc = new NavegationbarBloc();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final indexNavegationBar = uiProvider.getSelectedOptionNavegationBar;
    return BottomNavigationBar(
      onTap: (int option) =>
          {uiProvider.setSelectedOptionNavegationBar = option},
      currentIndex: indexNavegationBar,
      backgroundColor: Color(0xFFCED2D8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Color(0xFF03F7A2),
            icon: Icon(Icons.attach_money),
            label: "Balance"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Create QR"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: "Transaction")
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    optionNavegationbarBloc.dispose();
  }
}
