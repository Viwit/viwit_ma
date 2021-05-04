import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  
  int _selectedOptionNavegationBar = 0;
  String _selectedOptionAppNavBar = "Viwit";

  int get getSelectedOptionNavegationBar {
    return this._selectedOptionNavegationBar;
  }

  set setSelectedOptionNavegationBar(int option) {
    this._selectedOptionNavegationBar = option;
    notifyListeners();
  }

  String get getSelectedOptionAppNavBar {
    return this._selectedOptionAppNavBar;
  }

  set setSelectedOptionAppNavBar(String option) {
    this._selectedOptionAppNavBar = option;
    notifyListeners();
  }
}
