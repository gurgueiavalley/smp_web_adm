import 'package:admin_chat/Model/instituicao.dart';
import 'package:admin_chat/constants.dart';

class InstituicaoQuery {
  // cadastrar intituicao
  cadastrar(Instituicoes instituicoes) async {
    String query = """
      mutation MyMutation {
        insert_instituicoes(objects: {
          nome: "${instituicoes.nome}", 
          descricao: "${instituicoes.descricao}", 
          nomeImg: "${instituicoes.nomeImg}", 
          img: "${instituicoes.img}"
        }) {
          affected_rows
        }
      }    
    """;

    var res = await hasuraConnect.mutation(query);
    print(res);
    return true;
  }

  // listar instituições stream
  listar() {
    String query = """
      subscription MySubscription {
        instituicoes {
          id
          nome
          descricao
          img
          nomeImg
        }
      }
    """;

    return query;
  }

  // alterar intituição sem alterar a imagem
  alterarSemImagem(int id, Instituicoes instituicoes) async {
    String query = """
      mutation MyMutation {
        update_instituicoes(where: {id: {_eq: $id}}, 
        _set: {
          nome: "${instituicoes.nome}", 
          descricao: "${instituicoes.descricao}"
        }) {
          affected_rows
        }
      }

    """;
    var res = await hasuraConnect.mutation(query);
    print(res);
    return true;
  }

// alterar instituição e alterando imagem
  alterarComImagem(int id, Instituicoes instituicoes) async {
    String query = """
      mutation MyMutation {
        update_instituicoes(where: {id: {_eq: $id}},
        _set: {
          nome: "${instituicoes.nome}", 
          descricao: "${instituicoes.descricao}", 
          img: "${instituicoes.img}", 
          nomeImg: "${instituicoes.nomeImg}"
        }) {
          affected_rows
        }
      }    
    """;
    var res = await hasuraConnect.mutation(query);
    print(res);
    return true;
  }

  // excluir instiuição
  excluir(int id) async {
    String query = """
      mutation MyMutation {
        delete_instituicoes(where: {id: {_eq: $id}}) {
          affected_rows
        }
      }

    """;
    var res = await hasuraConnect.mutation(query);
    print(res);
    return true;
  }
}
