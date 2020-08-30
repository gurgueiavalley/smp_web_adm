class InstituicaoModel {
  Data _data;

  InstituicaoModel({Data data}) {
    this._data = data;
  }

  Data get data => _data;
  set data(Data data) => _data = data;

  InstituicaoModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  List<Instituicoes> _instituicoes;

  Data({List<Instituicoes> instituicoes}) {
    this._instituicoes = instituicoes;
  }

  List<Instituicoes> get instituicoes => _instituicoes;
  set instituicoes(List<Instituicoes> instituicoes) =>
      _instituicoes = instituicoes;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['instituicoes'] != null) {
      _instituicoes = new List<Instituicoes>();
      json['instituicoes'].forEach((v) {
        _instituicoes.add(new Instituicoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._instituicoes != null) {
      data['instituicoes'] = this._instituicoes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instituicoes {
  int _id;
  String _nome;
  String _descricao;
  String _img;
  String _nomeImg;

  Instituicoes(
      {int id, String nome, String descricao, String img, String nomeImg}) {
    this._id = id;
    this._nome = nome;
    this._descricao = descricao;
    this._img = img;
    this._nomeImg = nomeImg;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;
  String get img => _img;
  set img(String img) => _img = img;
  String get nomeImg => _nomeImg;
  set nomeImg(String nomeImg) => _nomeImg = nomeImg;

  Instituicoes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    _descricao = json['descricao'];
    _img = json['img'];
    _nomeImg = json['nomeImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nome'] = this._nome;
    data['descricao'] = this._descricao;
    data['img'] = this._img;
    data['nomeImg'] = this._nomeImg;
    return data;
  }
}
