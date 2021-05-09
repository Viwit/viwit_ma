import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/Home.dart';
import 'package:viwit_ma/src/pages/Register.dart';
import 'package:viwit_ma/src/providers/uiProvider/UiProvider.dart';

final _controllerEmail = TextEditingController();
final _controllerPassword = TextEditingController();

class LoginUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiProvider>(context);
    final indexNavegationBar = uiProvider.getSelectedOptionNavegationBar;
    if (indexNavegationBar > 2) {
      uiProvider.setSelectedOptionNavegationBar = 0;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _fondo(context),
          _loginFormulario(context),
          Container(
            padding: EdgeInsets.only(top: sizeScreen.height * 0.755),
            child: Column(
              children: [
                Image.asset(
                  'assets/viwit.png',
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _fondo(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;
  final fondoGradient = Container(
    height: sizeScreen.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: <Color>[Color(0xFF4499FF), Color(0xFF3399FF)])),
  );

  return Stack(
    alignment: Alignment.center,
    children: <Widget>[fondoGradient],
  );
}

Widget _loginFormulario(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
            child: Container(
          height: sizeScreen.width * 0.05,
        )),
        Container(
          width: sizeScreen.width * 0.85,
          height: sizeScreen.height * 0.638,
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 7.0),
                    spreadRadius: 2.0)
              ]),
          child: Column(
            children: <Widget>[
              Text('Login',
                  style: GoogleFonts.mandali(
                      color: Colors.grey[700], fontSize: 50.0)),
              SizedBox(height: sizeScreen.height * 0.06),
              _email(),
              SizedBox(height: sizeScreen.height * 0.04),
              _password(),
              SizedBox(height: sizeScreen.height * 0.04),
              _loginButton(context),
              SizedBox(height: sizeScreen.height * 0.015),
              _registerButton(context)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _email() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
          controller: _controllerEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Color(0xFF3399FF)),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico')));
}

Widget _password() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
          controller: _controllerPassword,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outlined, color: Color(0xFF3399FF)),
              hintText: '************',
              labelText: 'Contraseña')));
}

Widget _loginButton(BuildContext context) {
  return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
      child: Text('Ingresar', style: GoogleFonts.mandali(fontSize: 20)),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    elevation: 3.0,
    color: Color(0xFF3399FF),
    textColor: Colors.white,
    onPressed: () {
      _controllerEmail.clear();
      _controllerPassword.clear();
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  );
}

Widget _registerButton(BuildContext context) {
  return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      child: Text('Registrar', style: GoogleFonts.mandali(fontSize: 20)),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    elevation: 3.0,
    color: Color(0xFF8899FF),
    textColor: Colors.white,
    onPressed: () {
      _controllerEmail.clear();
      _controllerPassword.clear();
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterUser()),
      );
    },
  );
}
