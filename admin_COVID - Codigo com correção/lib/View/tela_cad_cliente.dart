import 'package:admin_chat/Controller/clienteController.dart';
import 'package:admin_chat/Model/cliente.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TelaCadCliente extends StatefulWidget {
  @override
  _TelaCadClienteState createState() => _TelaCadClienteState();
}

class _TelaCadClienteState extends State<TelaCadCliente> {
  ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _usuario = TextEditingController();
  TextEditingController _senha = TextEditingController();
  bool _salvando = false;

  @override
  Widget build(BuildContext context) {
    double _lagura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FloatingActionButton.extended(
                      hoverColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      focusColor: Colors.red,
                      backgroundColor: Colors.blue,
                      onPressed: () => Navigator.pop(context),
                      label: Text('Voltar'),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Nova Usuário',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Cadastre um novo usuário',
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 5, left: 5, top: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                //color: Colors.green,
                                //width: 250,
                                height: _lagura * 0.8,

                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _usuario,
                                        decoration: InputDecoration(
                                          labelText: 'USUÁRIO',
                                          hintText: 'Ex: pedro01',
                                        ),
                                        validator: (x) {
                                          if (x.isEmpty) {
                                            return 'Usuário inválido!';
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _senha,
                                        decoration: InputDecoration(
                                          labelText: 'SENHA',
                                          hintText: 'Ex: 142536',
                                        ),
                                        validator: (x) {
                                          if (x.isEmpty) {
                                            return 'Senha inválido!';
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: RaisedButton.icon(
                                          onPressed: () async {
                                            if (_globalKey.currentState
                                                .validate()) {
                                              _salvando = true;
                                              setState(() {});

                                              bool res =
                                                  await ClienteController()
                                                      .cadastrar(
                                                Clientes(
                                                  login: _usuario.text,
                                                  senha: _senha.text,
                                                ),
                                              );

                                              if (res) {
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                          icon: Icon(Icons.save),
                                          label: Text('Salvar'),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Visibility(
                                      visible: _salvando,
                                      child: LinearProgressIndicator(),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
