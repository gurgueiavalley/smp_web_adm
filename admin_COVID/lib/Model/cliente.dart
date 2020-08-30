class ClienteModel {
  Data _data;

  ClienteModel({Data data}) {
    this._data = data;
  }

  Data get data => _data;
  set data(Data data) => _data = data;

  ClienteModel.fromJson(Map<String, dynamic> json) {
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
  List<Clientes> _clientes;

  Data({List<Clientes> clientes}) {
    this._clientes = clientes;
  }

  List<Clientes> get clientes => _clientes;
  set clientes(List<Clientes> clientes) => _clientes = clientes;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['clientes'] != null) {
      _clientes = new List<Clientes>();
      json['clientes'].forEach((v) {
        _clientes.add(new Clientes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._clientes != null) {
      data['clientes'] = this._clientes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clientes {
  int _id;
  String _login;
  String _senha;

  Clientes({int id, String login, String senha}) {
    this._id = id;
    this._login = login;
    this._senha = senha;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get login => _login;
  set login(String login) => _login = login;
  String get senha => _senha;
  set senha(String senha) => _senha = senha;

  Clientes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _login = json['login'];
    _senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['login'] = this._login;
    data['senha'] = this._senha;
    return data;
  }
}
