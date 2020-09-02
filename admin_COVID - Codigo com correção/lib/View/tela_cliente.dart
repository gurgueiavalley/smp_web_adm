import 'dart:html';
import 'package:admin_chat/Model/cliente.dart';
import 'package:admin_chat/Query/queryCliente.dart';
import 'package:admin_chat/View/tela_cad_cliente.dart';
import 'package:admin_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TelaCliente extends StatefulWidget {
  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _largura = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Inicio'),
        icon: Icon(Icons.arrow_upward),
        heroTag: null,
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        },
      ),
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pesquisar Usuários',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Expanded(child: Container()),
                  Visibility(
                    visible: _largura >= 1000,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      splashColor: Colors.white,
                      foregroundColor: Colors.white,
                      hoverColor: Colors.redAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, 'cadastrar_cliente');
                      },
                      label: Text('Adicionar um novo Usuário'),
                      icon: Icon(Icons.add),
                    ),
                    replacement: FloatingActionButton(
                      backgroundColor: Colors.green,
                      splashColor: Colors.white,
                      foregroundColor: Colors.white,
                      hoverColor: Colors.redAccent,
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, 'cadastrar_cliente');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              Text(
                'Busque por Usuários',
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 150,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            controller: _editingController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                hintText: 'Digite o nome do Usuário',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _editingController.clear();
                                    setState(() {});
                                  },
                                )),
                          ),
                        ),
                        StreamBuilder(
                          stream: hasuraConnect.subscription(
                            ClienteQuery().queryListarCliente(),
                          ),
                          builder: (_, d) {
                            if (d.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: ClienteModel.fromJson(d.data)
                                    .data
                                    .clientes
                                    .length,
                                itemBuilder: (_, i) {
                                  if (ClienteModel.fromJson(d.data)
                                      .data
                                      .clientes
                                      .elementAt(i)
                                      .login
                                      .contains(_editingController.text)) {
                                    return ListTile(
                                      title: Text(
                                        'Usuário: ${ClienteModel.fromJson(d.data).data.clientes.elementAt(i).login}',
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.black45,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                          'Senha: ${ClienteModel.fromJson(d.data).data.clientes.elementAt(i).senha}'),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          'alterar_cliente',
                                          arguments:
                                              ClienteModel.fromJson(d.data)
                                                  .data
                                                  .clientes
                                                  .elementAt(i),
                                        );
                                      },
                                      trailing: Icon(Icons.edit),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            } else {
                              return CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
