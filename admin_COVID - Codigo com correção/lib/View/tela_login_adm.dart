import 'package:admin_chat/Query/queryCliente.dart';
import 'package:admin_chat/View/base.dart';
import 'package:admin_chat/constants.dart';
import 'package:flutter/material.dart';

import '../Query/queryAdm.dart';

class SignInADM extends StatefulWidget {
  @override
  _SignInADMState createState() => _SignInADMState();
}

class _SignInADMState extends State<SignInADM> {
  TextEditingController _login = TextEditingController();
  TextEditingController _senha = TextEditingController();
  GlobalKey<FormState> _formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Form(
            key: _formkey,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ...[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Faça o Login',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Divider(
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextFormField(
                        controller: _login,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Seu login',
                          labelText: 'Login',
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "O campo é obrigatório";
                          if (value.length < 5)
                            return "O campo precisa de mais de 5 caracteres";
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _senha,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) return "O campo é obrigatório";
                          if (value.length < 3)
                            return "O campo precisa de mais de 5 caracteres";
                          return null;
                        },
                        onFieldSubmitted: (value) async {
                          _realizarLogin();
                        },
                      ),
                      FlatButton(
                        child: Text('Sign in'),
                        onPressed: () async {
                          _realizarLogin();
                        },
                      ),
                    ].expand(
                      (widget) => [
                        widget,
                        SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _realizarLogin() async {
    if (_formkey.currentState.validate()) {
      print('botao clicado');
      var dados = await hasuraConnect
          .query(Adminstrador().queryLoginADM(_login.text, _senha.text));
      var tam = dados['data']['administrador'].length;
      print(dados['data']);
      if (tam == 1) {
        Navigator.popAndPushNamed(context, 'base');
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Erro"),
                content: Text("Login e/ou Senha inválido(s)"),
                actions: <Widget>[
                  FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]);
          },
        );
      }
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
