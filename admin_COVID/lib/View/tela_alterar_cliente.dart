import 'package:admin_chat/Controller/clienteController.dart';
import 'package:admin_chat/Model/cliente.dart';
import 'package:admin_chat/View/componentes.dart/carregando.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaAlterarCliente extends StatefulWidget {
  final Clientes clientes;
  const TelaAlterarCliente({Key key, this.clientes}) : super(key: key);

  @override
  _TelaAlterarClienteState createState() => _TelaAlterarClienteState();
}

class _TelaAlterarClienteState extends State<TelaAlterarCliente> {
  ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _usuario = TextEditingController();
  TextEditingController _senha = TextEditingController();
  bool _salvando = false;
  bool _editar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usuario.text = widget.clientes.login;
    _senha.text = widget.clientes.senha;
  }

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
                      Icon(Icons.edit),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Alterar Usuário',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Altere os dados do usuário',
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          left: 5,
                          top: 80,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: _lagura * 0.8,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        enabled: _editar,
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
                                        enabled: _editar,
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
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Visibility(
                                              visible: !_editar,
                                              child:
                                                  FloatingActionButton.extended(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                heroTag: null,
                                                onPressed: () async {
                                                  showDialog(
                                                      context: context,
                                                      child:
                                                          CupertinoAlertDialog(
                                                        content: Text(
                                                          'Deseja excluir?',
                                                        ),
                                                        actions: [
                                                          CupertinoButton(
                                                            child: Text('Não'),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                              context,
                                                            ),
                                                          ),
                                                          CupertinoButton(
                                                            child: Text('Sim'),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                              showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                child:
                                                                    Carregando(),
                                                              );

                                                              await ClienteController()
                                                                  .excluir(
                                                                widget.clientes
                                                                    .id,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ));
                                                },
                                                icon: Icon(Icons.delete),
                                                label: Text('Excluir'),
                                              ),
                                              replacement:
                                                  FloatingActionButton.extended(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                heroTag: null,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.clear),
                                                label: Text('Cancelar'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Visibility(
                                              visible: !_editar,
                                              child:
                                                  FloatingActionButton.extended(
                                                backgroundColor: Colors.blue,
                                                foregroundColor: Colors.white,
                                                heroTag: null,
                                                onPressed: () {
                                                  _editar = true;
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.edit),
                                                label: Text('Editar'),
                                              ),
                                              replacement:
                                                  FloatingActionButton.extended(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                heroTag: null,
                                                onPressed: () async {
                                                  _editar = true;
                                                  setState(() {});
                                                  if (_globalKey.currentState
                                                      .validate()) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      child: Carregando(),
                                                    );

                                                    await ClienteController()
                                                        .alterar(
                                                      widget.clientes.id,
                                                      Clientes(
                                                        login: _usuario.text,
                                                        senha: _senha.text,
                                                      ),
                                                    );

                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                icon: Icon(Icons.save),
                                                label: Text('Salvar'),
                                              ),
                                            ),
                                          ),
                                        ],
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
