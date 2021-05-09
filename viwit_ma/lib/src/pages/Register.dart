import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/pages/Login.dart';
import 'package:viwit_ma/src/pages/userPages/messagesUser/RegisterUser.dart';

import 'package:viwit_ma/src/providers/userProvider/UserProvider.dart';

final _controllerEmail = TextEditingController();
final _controllerPassword = TextEditingController();
final _controllerFirstName = TextEditingController();
final _controllerLastName = TextEditingController();

class RegisterUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _fondo(context),
          _registerForm(context),
          Container(
            padding: EdgeInsets.only(top: sizeScreen.height * 0.85),
            child: Column(
              children: [
                Image.asset(
                  'assets/viwit.png',
                  height: 80,
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
            colors: <Color>[Color(0xFF4499FF), Color(0xFF009911)])),
  );

  return Stack(
    alignment: Alignment.center,
    children: <Widget>[fondoGradient],
  );
}

Widget _registerForm(BuildContext context) {
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
          height: sizeScreen.height * 0.78,
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
              Text('Registro',
                  style: GoogleFonts.mandali(
                      color: Colors.grey[700], fontSize: 50.0)),
              SizedBox(height: sizeScreen.height * 0.06),
              _fistname(),
              SizedBox(height: sizeScreen.height * 0.01),
              _lastname(),
              SizedBox(height: sizeScreen.height * 0.01),
              _email(),
              SizedBox(height: sizeScreen.height * 0.01),
              _password(),
              SizedBox(height: sizeScreen.height * 0.06),
              _registrarButton(context),
              SizedBox(height: sizeScreen.height * 0.04),
              _backToLoginButton(context)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _fistname() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
          controller: _controllerFirstName,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon:
                  Icon(Icons.supervised_user_circle, color: Color(0xFF3399FF)),
              hintText: 'Alvaro',
              labelText: 'First Name')));
}

Widget _lastname() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
          controller: _controllerLastName,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle_outlined,
                  color: Color(0xFF3399FF)),
              hintText: 'Uribe Velez',
              labelText: 'Last name')));
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

Widget _registrarButton(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      child: Text('Registrar', style: GoogleFonts.mandali(fontSize: 20)),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    elevation: 3.0,
    color: Color(0xFF3399FF),
    textColor: Colors.white,
    onPressed: () {
      userProvider.setEmail = _controllerEmail.text;
      userProvider.setPassword = _controllerPassword.text;
      userProvider.setFirstname = _controllerFirstName.text;
      userProvider.setLastname = _controllerLastName.text;
      _controllerEmail.clear();
      _controllerPassword.clear();
      _controllerFirstName.clear();
      _controllerLastName.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterUserMutation()),
      );
    },
  );
}

Widget _backToLoginButton(BuildContext context) {
  return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      child: Text('Volver', style: GoogleFonts.mandali(fontSize: 20)),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    elevation: 3.0,
    color: Color(0xFF8899FF),
    textColor: Colors.white,
    onPressed: () {
      _controllerEmail.clear();
      _controllerPassword.clear();
      _controllerFirstName.clear();
      _controllerLastName.clear();
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginUser()),
      );
    },
  );
}
