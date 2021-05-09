import 'package:flutter/material.dart';
import 'package:viwit_ma/src/classes/User.dart';

class UserProvider extends ChangeNotifier {

  UserClass user = new UserClass();

  logOut(){
    user = new UserClass();
  }

  int get getUserId => this.user.user_id;
  set setUserId(int id) {
    this.user.user_id = id;
    notifyListeners();
  }

  String get getFirstname => this.user.firstname;
  set setFirstname(String firstname) {
    this.user.firstname = firstname;
    notifyListeners();
  }

  String get getLastname => this.user.lastname;
  set setLastname(String lastname) {
    this.user.lastname = lastname;
    notifyListeners();
  }

  String get getEmail => this.user.email;
  set setEmail(String emailInp) {
    this.user.email = emailInp;
    notifyListeners();
  }

  DateTime get getReg_date => this.user.reg_date;
  set setReg_date(DateTime reg_date) {
    this.user.reg_date = reg_date;
    notifyListeners();
  }

  int get getUser_type => this.user.user_type;
  set setUser_type(int user_type) {
    this.user.user_type = user_type;
    notifyListeners();
  }

  String get getPassword => this.user.password;
  set setPassword(String password) {
    this.user.password = password;
    notifyListeners();
  }

}
