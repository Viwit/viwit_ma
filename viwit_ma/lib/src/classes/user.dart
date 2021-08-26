import 'package:viwit_ma/src/classes/token.dart';

class UserClass {
  
  //Id del usuario
  int _user_id;

  int get user_id => _user_id;
  set user_id(int user_id) {
    this._user_id = user_id;
  }
  
  //Nombre del usuario
  String _firstname;

  String get firstname => _firstname;
  set firstname(String firstname) {
    this._firstname = firstname;
  }
  
  //Apellido del usuario
  String _lastname;

  String get lastname => _lastname;
  set lastname(String lastname) {
    this._lastname = lastname;
  }
  
  //Email
  String _email;

  String get email => _email;
  set email(String email) {
    this._email = email;
  }

  //Fecha de registo
  DateTime _reg_date;

  DateTime get reg_date => _reg_date;
  set reg_date(DateTime reg_date) {
    this._reg_date = reg_date;
  }
  
  //Tipo de usuario
  int _user_type;

  int get user_type => _user_type;
  set user_type(int user_type) {
    this._user_type = user_type;
  }

  //Contraseña
  String _password;

  String get password => _password;
  set password(String password) {
    this._password = password;
  }

  //Token Firebase
  String _tokenFirebase;
  String get tokenFirebase => _tokenFirebase;
  set tokenFirebase(String tokenFirebase) {
    this._tokenFirebase = _tokenFirebase;
  }

  Token _token;
  Token get token => _token;
  set token(Token token) {
    this._token = token;
  }

}
