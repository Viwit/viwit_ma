import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int _userId = 2;

  int get getUserId {
    return this._userId;
  }

  set setSelectedUserId(int user) {
    this._userId = user;
    notifyListeners();
  }
}
