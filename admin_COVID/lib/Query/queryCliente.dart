import 'package:admin_chat/Model/cliente.dart';
import 'package:admin_chat/constants.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ClienteQuery {
  // cadastrar
  Future<bool> queryCadastrarCliente(Clientes clienteModel) async {
    String query = """
      mutation MyMutation {
        insert_clientes(objects: {
          login: "${clienteModel.login}", 
          senha: "${clienteModel.senha}"
        }) {
          returning {
            id
          }
          affected_rows
        }
      }
    """;
    var res = await hasuraConnect.mutation(query);
    print(res);
    return true;
  }

  // listar
  String queryListarCliente() {
    String query = """
      subscription MySubscription {
      clientes {
        id
        login
        senha
      }
    }    
    """;

    return query;
  }

  // excluir
  Future<bool> queryExcluirCliente(int id) async {
    print('deletando: $id');

    String query = """
      mutation MyMutation {
        delete_clientes(where: {id: {_eq: $id }}) {
          affected_rows
        }
      }

    """;

    var res = await hasuraConnect.mutation(query);
    return true;
  }

  // editar
  Future<bool> queryEditarCliente(int id, Clientes clientes) async {
    String query = """
      mutation MyMutation {
        update_clientes(where: {id: {_eq: $id}}, _set: {
          login: "${clientes.login}", 
          senha: "${clientes.senha}"
        }) {
          affected_rows
        }
      }

    """;
    var res = await hasuraConnect.mutation(query);
    return true;
  }

  // verificar login/senha
  queryLoginCliente(String login, String senha) {
    String query = """
      query MyQuery {
        clientes(where: {login: {_eq: "$login"}, senha: {_eq: "$senha"}}) {
          login
          senha
        }
      }   
    """;
    return query;
  }

  // verificar login/senha
  queryLogin() {
    String query = """
      query MyQuery {
        clientes {
          login
          senha
        }
      }   
    """;

    return query;
  }
}
