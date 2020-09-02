import 'package:admin_chat/Model/instituicao.dart';
import 'package:admin_chat/Query/queryInstituicao.dart';
import 'package:admin_chat/View/tela_instituicoes.dart';
import 'package:admin_chat/constants.dart';
import 'package:flutter/material.dart';

class TelaListarInstituicao extends StatefulWidget {
  @override
  _TelaListarInstituicaoState createState() => _TelaListarInstituicaoState();
}

class _TelaListarInstituicaoState extends State<TelaListarInstituicao> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _editingController = TextEditingController();
  bool _inicio = false;

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
                    'Pesquisar Instituição',
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
                        Navigator.pushNamed(context, 'cadastrar_instituicao');
                      },
                      label: Text('Adicionar nova Instituição'),
                      icon: Icon(Icons.add),
                    ),
                    replacement: FloatingActionButton(
                      backgroundColor: Colors.green,
                      splashColor: Colors.white,
                      foregroundColor: Colors.white,
                      hoverColor: Colors.redAccent,
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, 'cadastrar_instituicao');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              Text(
                'Busque sua asInstituição e faça alterações no cadastros',
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
                                hintText: 'Digite o nome da Instituição',
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
                          stream: hasuraConnect
                              .subscription(InstituicaoQuery().listar()),
                          builder: (_, d) {
                            if (d.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: InstituicaoModel.fromJson(d.data)
                                    .data
                                    .instituicoes
                                    .length,
                                itemBuilder: (_, i) {
                                  if (InstituicaoModel.fromJson(d.data)
                                      .data
                                      .instituicoes
                                      .elementAt(i)
                                      .nome
                                      .toLowerCase()
                                      .contains(
                                        _editingController.text.toLowerCase(),
                                      )) {
                                    return ListTile(
                                      title: Text(
                                        InstituicaoModel.fromJson(d.data)
                                            .data
                                            .instituicoes
                                            .elementAt(i)
                                            .nome,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          InstituicaoModel.fromJson(d.data)
                                              .data
                                              .instituicoes
                                              .elementAt(i)
                                              .img,
                                        ),
                                      ),
                                      subtitle: Text(
                                        InstituicaoModel.fromJson(d.data)
                                            .data
                                            .instituicoes
                                            .elementAt(i)
                                            .descricao,
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          'alterar_instituicao',
                                          arguments:
                                              InstituicaoModel.fromJson(d.data)
                                                  .data
                                                  .instituicoes
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
                        ),
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
