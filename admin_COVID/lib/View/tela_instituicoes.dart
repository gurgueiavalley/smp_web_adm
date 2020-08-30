import 'dart:html';
import 'package:admin_chat/Controller/instituicaoController.dart';
import 'package:admin_chat/Model/instituicao.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';
import 'package:file_picker_web/file_picker_web.dart';

Firestore firestore = fb.firestore();

class TelaInstituicao extends StatefulWidget {
  @override
  _TelaInstituicaoState createState() => _TelaInstituicaoState();
}

class _TelaInstituicaoState extends State<TelaInstituicao> {
  ScrollController _scrollController = ScrollController();
  File _image;
  final reader = new FileReader();
  GlobalKey<FormState> _globalKey = GlobalKey();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  bool _carregando = false;

  void _pickFiles() async {
    _image = await FilePicker.getFile();
    print(_image.relativePath);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double _lagura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _key,
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Form(
              key: _globalKey,
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
                      Icon(Icons.school),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Nova Instituição',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Cadastre uma nova Instituição, e ela estará disponivel no aplicativo.',
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
                            const EdgeInsets.only(right: 5, left: 50, top: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //color: Colors.red,
                              width: 230,
                              height: _altura * 0.7,
                              child: Column(
                                children: [
                                  Container(
                                    height: 230,
                                    width: 230,
                                    margin: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      color: _image == null
                                          ? Colors.grey
                                          : Colors.white,
                                      image: DecorationImage(
                                        image: _image == null
                                            ? NetworkImage(
                                                'https://img.icons8.com/officel/2x/add-image.png',
                                              )
                                            : AssetImage(
                                                'assets/carregada.jpg',
                                              ),
                                        //_image.relativePath
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    height: 50,
                                    color: Colors.blue,
                                    child: RaisedButton.icon(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        uploadImage();
                                      },
                                      icon: Icon(Icons.cloud_upload),
                                      label: AutoSizeText(
                                        'Selecionar foto',
                                        wrapWords: true,
                                        maxFontSize: 50,
                                        minFontSize: 5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Prefira uma imagem com um formato png.',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _image != null
                                      ? Text(
                                          'Nome da imagem: ' + _image.name,
                                          style: TextStyle(color: Colors.green),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
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
                                        controller: _nome,
                                        decoration: InputDecoration(
                                          labelText: 'NOME',
                                          hintText: 'Ex: Pedro',
                                        ),
                                        validator: (x) {
                                          if (x.isEmpty) {
                                            return 'Nome inválido.';
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _descricao,
                                        decoration: InputDecoration(
                                          labelText: 'DESCRIÇÃO',
                                          hintText: 'Ex: Colégio Santos',
                                        ),
                                        validator: (x) {
                                          if (x.isEmpty) {
                                            return 'Descrição inválido.';
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
                                              if (_image == null) {
                                                var snak = SnackBar(
                                                  content: Text(
                                                    'Adicione um logo!',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                );

                                                _key.currentState
                                                    .showSnackBar(snak);
                                              } else {
                                                _carregando = true;
                                                setState(() {});
                                                String url_img =
                                                    await uploadToFirebase(
                                                        _image);
                                              }
                                            }

                                            print('Destino:');
                                          },
                                          icon: Icon(Icons.save),
                                          label: Text('Salvar'),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Visibility(
                                      visible: _carregando,
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

// pegando imagem
  uploadImage() async {
    await _pickFiles();
    print('pegar imagem');
  }

  // upload dqa
  fb.UploadTask _uploadTask;

  uploadToFirebase(File imageFile) async {
    String nome_image = DateTime.now().toString();
    String url_imagem;

    final filePath = 'ImagemAdministradorWeb/$nome_image';
    _uploadTask = fb
        .storage()
        .refFromURL('gs://covid-4f1af.appspot.com')
        .child(filePath)
        .put(imageFile);

    _uploadTask.future.asStream().listen((event) async {
      print('entrou');
      double progresso =
          event != null ? event.bytesTransferred / event.totalBytes * 100 : 0;
      if (progresso == 100) {
        print('sucesso');
        var url = await (event).ref.getDownloadURL();
        url_imagem = url.toString();

        print(url_imagem);
        await InstituicaoController().cadastrar(
          Instituicoes(
            nome: _nome.text,
            descricao: _descricao.text,
            img: url_imagem,
            nomeImg: nome_image,
          ),
        );

        _nome.text = '';
        _descricao.text = '';
        Navigator.pop(context);

        if (url != null) {
          print('entrou');
        }
      }
    });

    setState(() {});
  }
}
