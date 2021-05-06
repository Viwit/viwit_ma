import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../classes/user.dart';
import '../classes/payment.dart';

class UiProvider extends ChangeNotifier {
  int _selectedOptionNavegationBar = 0;
  HttpLink _httpLink = HttpLink('http://23.22.177.41:3000/graphql');
  String _qrCodePayment = "";
  UserClass userGeneral = new UserClass();
  PaymenClass payment;
  BuildContext contextUi;

  logOut() {
    userGeneral = new UserClass();
  }

  int get getSelectedOptionNavegationBar {
    return this._selectedOptionNavegationBar;
  }

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

  int get getUserId => this.userGeneral.getUserId;
  set setUserId(int id) {
    this.userGeneral.setUserId = id;
    notifyListeners();
  }

  String get getfirstname => this.userGeneral.getfirstname;
  set setfirstname(String firstname) {
    this.userGeneral.setfirstname = firstname;
    notifyListeners();
  }

  String get getlastname => this.userGeneral.getlastname;
  set setlastname(String lastname) {
    this.userGeneral.setlastname = lastname;
    notifyListeners();
  }

  String get getemail => this.userGeneral.getemail;
  set setEmail(String emailInp) {
    this.userGeneral.setemail = emailInp;
    notifyListeners();
  }

  DateTime get getreg_date => this.userGeneral.getreg_date;
  set setreg_date(DateTime reg_date) {
    this.userGeneral.setreg_date = reg_date;
    notifyListeners();
  }

  int get getuser_type => this.userGeneral.getuser_type;
  set setuser_type(int user_type) {
    this.userGeneral.user_type = user_type;
    notifyListeners();
  }

  String get getPassword => this.userGeneral.getPassword;
  set setPassword(String password) {
    this.userGeneral.setPassword = password;
    notifyListeners();
  }

  int get getBalance => this.payment.getBalance;
  set setBalance(int balance) {
    this.payment.setBalance = balance;
    notifyListeners();
  }

  int get getUseridPayment => this.payment.user_id;
  set setUseridPayment(int user_id) {
    this.payment.setuser_id = user_id;
    notifyListeners();
  }

  int get getid => this.payment.id;
  set setid(int id) {
    this.payment.setid = id;
    notifyListeners();
  }

  String get gettoken => this.payment.token;
  set settoken(String token) {
    this.payment.settoken = token;
    notifyListeners();
  }

  BuildContext get getContextUi {
    return this.contextUi;
  }

  set setContextUi(BuildContext contextUi) {
    this.contextUi = contextUi;
    notifyListeners();
  }
}
