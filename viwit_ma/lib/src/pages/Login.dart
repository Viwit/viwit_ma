import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viwit_ma/src/classes/token.dart';
import 'package:viwit_ma/src/pages/Register.dart';
import 'package:viwit_ma/src/providers/uiProvider/user/UiProviderUser.dart';
import 'package:viwit_ma/src/pages/messages/LoginMessage.dart';
import 'package:viwit_ma/src/services/graphql.dart';

import '../providers/userProvider/UserProvider.dart';

final _controllerEmail = TextEditingController();
final _controllerPassword = TextEditingController();

class LoginUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final uiProviderUser = Provider.of<UiProviderUser>(context);
    final indexNavegationBar = uiProviderUser.getSelectedOptionNavegationBar;
    if (indexNavegationBar > 4) {
      uiProviderUser.setSelectedOptionNavegationBar = 0;
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
    final userProvider = Provider.of<UserProvider>(context);
    final userUiProvider = Provider.of<UiProviderUser>(context);
  return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
      child: Text('Ingresar', style: GoogleFonts.mandali(fontSize: 20)),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    elevation: 3.0,
    color: Color(0xFF3399FF),
    textColor: Colors.white,
    onPressed: () async {
      String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(_controllerEmail.text ?? '') && _controllerPassword.text != ""){
        Graphql graphQuery = new Graphql();
        String query = """query{
                        get_login(email:"${_controllerEmail.text}",password:"${_controllerPassword.text}"){
                          isLogin,
                          user_id
                        }
                      }""";
        Map getLogin = await graphQuery.queryOrMutation(query);
        if(getLogin['data']['get_login']['isLogin'] == 1){
          
          String mutationCreateToken = """mutation{
                              put_token_firebase(id:${getLogin['data']['get_login']['user_id']},firebase:"${userProvider.getTokenFirebase}"){
                                isValid,
                                token{
                                  finish,
                                  id,
                                  initial,
                                  token,
                                  type
                                }
                              }
                            }""";

          Map putTokenFirebase = await graphQuery.queryOrMutation(mutationCreateToken);

          if(putTokenFirebase['data']['put_token_firebase']['isValid'] == 1){

            String getuserQuery = """query{
                                              getuser(id:${getLogin['data']['get_login']['user_id']}){
                                                User_id,
                                                Firstname,
                                                Lastname,
                                                Email,
                                                Reg_date,
                                                User_type
                                              }
                                            }""";

            Map getuserMap = await graphQuery.queryOrMutation(getuserQuery);
            userProvider.setFirstname = getuserMap['data']['getuser']['Firstname'];
            userProvider.setLastname = getuserMap['data']['getuser']['Lastname'];
            userProvider.setEmail = getuserMap['data']['getuser']['Email'];
            userProvider.setUser_type = getuserMap['data']['getuser']['User_type'];
            userProvider.setToken = Token.fromMap(putTokenFirebase['data']['put_token_firebase']['token']);
            userProvider.setUserId = getLogin['data']['get_login']['user_id'];
            userProvider.setEmail = _controllerEmail.text;
            userProvider.setPassword= _controllerPassword.text;
            _controllerEmail.clear();
            _controllerPassword.clear();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginMessage()),
            );
          }
        }else{
          _controllerPassword.clear();
        }
      }
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
