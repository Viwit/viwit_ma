import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int _userId = 1;

  int get getUserId {
    return this._userId;
  }

  set setSelectedOptionNavegationBar(int user) {
    this._userId = user;
    notifyListeners();
  }
}
