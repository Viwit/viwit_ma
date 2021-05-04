import 'dart:async';

import 'package:viwit_ma/src/bloc/NavegationbarRepository.dart';

class NavegationbarBlocBase {}

class ChangeNavegationbarHistorial extends NavegationbarBlocBase {}

class ChangeNavegationbarBalance extends NavegationbarBlocBase {}

class NavegationbarBloc {
  NavegationBarRepository repository = NavegationBarRepository();
  int _option = 0;

  StreamController<NavegationbarBlocBase> _input = StreamController();
  StreamController<int> _output = StreamController();

  Stream<int> get changeNavegationbarStream => _output.stream;
  StreamSink<NavegationbarBlocBase> get sendEvent => _input.sink;

  NavegationbarBloc() {
    _input.stream.listen(_onEvent);
  }

  void _onEvent(NavegationbarBlocBase event) {
    print("opt = $_option --- rep = ${repository.getOption()}");
    if (event is ChangeNavegationbarHistorial) {
      repository.changeOption(1);
      _option = repository.getOption();
    } else if (event is ChangeNavegationbarBalance) {
      repository.changeOption(0);
      _option = repository.getOption();
    }
    _output.add(_option);
  }

  void dispose() {
    _input.close();
    _output.close();
  }
}
