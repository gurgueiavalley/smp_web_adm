import 'dart:convert';
import 'dart:typed_data';
import 'package:admin_chat/Controller/instituicaoController.dart';
import 'package:admin_chat/Model/instituicao.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

Firestore firestore = fb.firestore();

class TelaInstituicao extends StatefulWidget {
  @override
  _TelaInstituicaoState createState() => _TelaInstituicaoState();
}

class _TelaInstituicaoState extends State<TelaInstituicao> {
  ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  bool _carregando = false;
  Uint8List data;
  html.File fileImage;

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
                                    child: data == null
                                        ? Image.asset('assets/add.png')
                                        : Image.memory(data),
                                  ),
                                  Container(
                                    width: 230,
                                    height: 50,
                                    color: Colors.blue,
                                    child: RaisedButton.icon(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        //uploadImage();
                                        pickImage();
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
                                              if (fileImage == null) {
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
                                                    await uploadToFirebase();
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

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      fileImage = input.files.first;
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {}));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          data = base64.decode(stripped);
        });
      });
    });

    input.click();
  }

  // upload da imagem para o firebase
  uploadToFirebase() async {
    String nome_image = DateTime.now().toString();

    fb.StorageReference storageRef = fb.storage().ref(
          'ImagemAdministradorWeb/$nome_image',
        );
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(fileImage).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    String url = imageUri.toString();
    print('Nova url');
    print(url);

    await InstituicaoController().cadastrar(
      Instituicoes(
        nome: _nome.text,
        descricao: _descricao.text,
        img: url,
        nomeImg: nome_image,
      ),
    );

    _nome.text = '';
    _descricao.text = '';
    Navigator.pop(context);
  }
}
