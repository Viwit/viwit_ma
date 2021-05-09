import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:viwit_ma/src/classes/user.dart';
import 'package:viwit_ma/src/classes/payment.dart';

class UiProvider extends ChangeNotifier {
  
  int _selectedOptionNavegationBar = 0;
  HttpLink _httpLink = HttpLink('http://23.22.177.41:3000/graphql');
  String _qrCodePayment = "";
  UserClass userGeneral = new UserClass();

  logOut() {
    userGeneral = new UserClass();
  }

  int get getSelectedOptionNavegationBar => this._selectedOptionNavegationBar;

  set setSelectedOptionNavegationBar(int option) {
    this._selectedOptionNavegationBar = option;
    notifyListeners();
  }

  HttpLink get getIpgraphQL {
    return this._httpLink;
  }

  String get getQrCode {
    return this._qrCodePayment;
  }

  set setQrCode(String qr) {
    this._qrCodePayment = _qrCodePayment;
    notifyListeners();
  }


}