class RespostaModel {
  Data _data;

  RespostaModel({Data data}) {
    this._data = data;
  }

  Data get data => _data;
  set data(Data data) => _data = data;

  RespostaModel.fromJson(Map<String, dynamic> json) {
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
  List<Respostas> _respostas;

  Data({List<Respostas> respostas}) {
    this._respostas = respostas;
  }

  List<Respostas> get respostas => _respostas;
  set respostas(List<Respostas> respostas) => _respostas = respostas;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['respostas'] != null) {
      _respostas = new List<Respostas>();
      json['respostas'].forEach((v) {
        _respostas.add(new Respostas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._respostas != null) {
      data['respostas'] = this._respostas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Respostas {
  int _id;
  String _resposta;

  Respostas({int id, String resposta}) {
    this._id = id;
    this._resposta = resposta;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get resposta => _resposta;
  set resposta(String resposta) => _resposta = resposta;

  Respostas.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _resposta = json['resposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['resposta'] = this._resposta;
    return data;
  }
}
