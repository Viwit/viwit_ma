import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:viwit_ma/src/classes/user.dart';
import 'package:viwit_ma/src/services/graphql.dart';

class UiProviderUser extends ChangeNotifier {
  
  int _selectedOptionNavegationBar = 0;
  int _optionLogOut = 0;
  HttpLink _httpLink = HttpLink((new Graphql()).getHttpLink);
  String _httpLinkString = (new Graphql()).getHttpLink;
  String _qrCodePayment = "";
  UserClass userGeneral = new UserClass();

  logOut() {
    userGeneral = new UserClass();
  }

  String get getHttpLinkString => this._httpLinkString;

  int get getSelectedOptionNavegationBar => this._selectedOptionNavegationBar;

  set setSelectedOptionNavegationBar(int option) {
    this._selectedOptionNavegationBar = option;
    notifyListeners();
  }

  int get getOptionLogOut => this._optionLogOut;

  set setOptionLogOut(int optLogOut) {
    this._optionLogOut = optLogOut;
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
