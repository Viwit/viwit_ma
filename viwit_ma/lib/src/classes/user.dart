class UserClass {
  int user_id;
  String firstname;
  String lastname;
  String email;
  DateTime reg_date;
  int user_type;
  String _password;

  int get getUserId => this.user_id;
  set setUserId(int id) => this.user_id;

  String get getfirstname => this.firstname;
  set setfirstname(String firstname) => this.firstname;

  String get getlastname => this.lastname;
  set setlastname(String lastname) => this.lastname;

  String get getemail => this.email;
  set setemail(String emailIn) => this.email;

  DateTime get getreg_date => this.reg_date;
  set setreg_date(DateTime reg_date) => this.reg_date;

  int get getuser_type => this.user_type;
  set setuser_type(int user_type) => this.user_type;

  String get getPassword => this._password;
  set setPassword(String _password) => this._password;
}
