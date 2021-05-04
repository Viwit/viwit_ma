class NavegationBarRepository {
  
  int _option = 0;

  static NavegationBarRepository _instance =
      NavegationBarRepository._internal();

  NavegationBarRepository._internal();

  factory NavegationBarRepository() {
    return _instance;
  }

  int getOption() {
    return this._option;
  }

  void changeOption(int opt) {
    switch (opt) {
      case 0:
        this._option = 0;
        break;
      case 1:
        this._option = 1;
        break;
      default:
    }
  }
}
